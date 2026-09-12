const fs = require('fs');
const path = require('path');
const { MongoClient, BSON } = require('mongodb');

// Get MongoDB URI from command line argument or environment variable or prompt
const defaultUri = process.env.MONGODB_URI || process.argv[2];
const dbName = process.env.DB_NAME || process.argv[3] || 'HotelManagerment';

if (!defaultUri) {
  console.error('\n❌ Thiếu connection string MongoDB!');
  console.log('\nCách sử dụng:');
  console.log('  node import_atlas.js "<MONGODB_URI>"');
  console.log('\nVí dụ MongoDB Atlas:');
  console.log('  node import_atlas.js "mongodb+srv://admin:password123@cluster0.abcde.mongodb.net/?retryWrites=true&w=majority"\n');
  process.exit(1);
}

const ignoredFiles = new Set([
  'package.json',
  'package-lock.json',
  'migration_summary.json'
]);

async function run() {
  console.log('🚀 Đang kết nối tới MongoDB...');
  const client = new MongoClient(defaultUri);

  try {
    await client.connect();
    console.log(`✅ Kết nối thành công! Database: [${dbName}]\n`);

    const db = client.db(dbName);
    const files = fs.readdirSync(__dirname).filter(f => f.endsWith('.json') && !ignoredFiles.has(f));

    console.log(`📁 Tìm thấy ${files.length} collections cần import:\n`);

    let totalDocs = 0;

    for (const file of files) {
      const collectionName = path.basename(file, '.json');
      const filePath = path.join(__dirname, file);
      const raw = fs.readFileSync(filePath, 'utf-8');

      if (!raw || raw.trim() === '' || raw.trim() === '[]') {
        console.log(`  ⚪ [${collectionName}]: 0 documents (trống)`);
        continue;
      }

      let docs;
      try {
        docs = BSON.EJSON.parse(raw, { relaxed: false });
      } catch (err) {
        // Fallback to standard JSON.parse if EJSON fails
        docs = JSON.parse(raw);
      }

      if (!Array.isArray(docs) || docs.length === 0) {
        console.log(`  ⚪ [${collectionName}]: 0 documents`);
        continue;
      }

      const collection = db.collection(collectionName);

      // Perform bulk upsert by _id or insertMany
      const operations = docs.map(doc => {
        if (doc._id !== undefined && doc._id !== null) {
          return {
            replaceOne: {
              filter: { _id: doc._id },
              replacement: doc,
              upsert: true
            }
          };
        } else {
          return {
            insertOne: {
              document: doc
            }
          };
        }
      });

      await collection.bulkWrite(operations, { ordered: false });
      totalDocs += docs.length;
      console.log(`  ✅ [${collectionName}]: Đã nạp ${docs.length} documents`);
    }

    console.log(`\n🎉 HOÀN TẤT! Tổng cộng đã nạp ${totalDocs} documents vào MongoDB Atlas [${dbName}].`);
  } catch (err) {
    console.error('\n❌ Lỗi khi import:', err.message);
  } finally {
    await client.close();
  }
}

run();
