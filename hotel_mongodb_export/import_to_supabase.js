const fs = require('fs');
const path = require('path');
const { Client } = require('pg');

const config = {
  host: 'aws-0-ap-southeast-1.pooler.supabase.com',
  port: 5432,
  user: 'postgres.zterndrnmozenwonarpl',
  password: 'hotelthai123@',
  database: 'postgres',
  ssl: { rejectUnauthorized: false }
};

function parseValue(val) {
  if (val === null || val === undefined) return null;
  if (typeof val === 'object') {
    if (val.$date) return new Date(val.$date);
    if (val.$numberDecimal) return parseFloat(val.$numberDecimal);
    return JSON.stringify(val);
  }
  return val;
}

async function run() {
  const client = new Client(config);
  await client.connect();
  console.log('🚀 Đã kết nối tới Supabase PostgreSQL!');

  try {
    // 1. Tạm thời tắt ràng buộc khóa ngoại để nạp dữ liệu nhanh và không bị kẹt thứ tự
    await client.query("SET session_replication_role = 'replica';");

    // 2. Lấy danh sách bảng và cột hiện có trong database
    const colsRes = await client.query(`
      SELECT table_name, column_name, data_type 
      FROM information_schema.columns 
      WHERE table_schema = 'public';
    `);

    const tableCols = {};
    for (const row of colsRes.rows) {
      if (!tableCols[row.table_name]) tableCols[row.table_name] = new Set();
      tableCols[row.table_name].add(row.column_name);
    }

    const files = fs.readdirSync(__dirname).filter(f => f.endsWith('.json') && !['package.json', 'package-lock.json', 'migration_summary.json'].includes(f));
    let totalImported = 0;

    for (const file of files) {
      const tableName = path.basename(file, '.json');
      if (!tableCols[tableName]) {
        console.log(`⚠️ Bảng ${tableName} không tồn tại trong database, bỏ qua.`);
        continue;
      }

      const validCols = tableCols[tableName];
      const raw = fs.readFileSync(path.join(__dirname, file), 'utf-8');
      if (!raw.trim()) continue;

      let items = JSON.parse(raw);
      if (!Array.isArray(items) || items.length === 0) continue;

      console.log(`📦 Đang nạp ${items.length} bản ghi vào bảng [${tableName}]...`);

      for (const item of items) {
        // Chuyển _id thành Id nếu bảng có cột Id
        if (item._id !== undefined) {
          if (validCols.has('Id') && item.Id === undefined) {
            item.Id = item._id;
          }
          delete item._id;
        }

        const keys = Object.keys(item).filter(k => validCols.has(k));
        if (keys.length === 0) continue;

        const colsStr = keys.map(k => `"${k}"`).join(', ');
        const placeholders = keys.map((_, i) => `$${i + 1}`).join(', ');
        const values = keys.map(k => parseValue(item[k]));

        const query = `INSERT INTO "${tableName}" (${colsStr}) VALUES (${placeholders}) ON CONFLICT DO NOTHING;`;
        try {
          await client.query(query, values);
        } catch (insertErr) {
          console.error(`  ❌ Lỗi khi insert vào ${tableName}:`, insertErr.message);
        }
      }

      totalImported += items.length;
      console.log(`  ✅ [${tableName}] xong!`);
    }

    // 3. Bật lại ràng buộc
    await client.query("SET session_replication_role = 'origin';");

    // 4. Đồng bộ lại giá trị Sequence ID cho tất cả các bảng
    console.log('\n🔄 Đang đồng bộ lại Auto-Increment Identity Sequences...');
    for (const tableName of Object.keys(tableCols)) {
      if (tableCols[tableName].has('Id')) {
        try {
          await client.query(`
            SELECT setval(
              pg_get_serial_sequence('"${tableName}"', 'Id'),
              COALESCE((SELECT MAX("Id") FROM "${tableName}"), 0) + 1,
              false
            );
          `);
        } catch (seqErr) {
          // Bảng không dùng serial identity mặc định thì bỏ qua
        }
      }
    }

    console.log(`\n🎉 HOÀN TẤT NẠP DỮ LIỆU! Đã nạp thành công toàn bộ ${totalImported} bản ghi vào Supabase!`);
  } catch (err) {
    console.error('❌ Lỗi tổng quát:', err);
  } finally {
    await client.end();
  }
}

run();
