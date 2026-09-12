const { Client } = require('pg');

async function fix() {
  const c = new Client({
    host: 'aws-0-ap-southeast-1.pooler.supabase.com',
    port: 5432,
    user: 'postgres.zterndrnmozenwonarpl',
    password: 'hotelthai123@',
    database: 'postgres',
    ssl: { rejectUnauthorized: false }
  });

  await c.connect();
  const q = await c.query("SELECT table_name, column_name FROM information_schema.columns WHERE table_schema = 'public' AND data_type = 'timestamp without time zone';");
  for (const row of q.rows) {
    console.log(`Altering ${row.table_name}.${row.column_name}`);
    await c.query(`ALTER TABLE "${row.table_name}" ALTER COLUMN "${row.column_name}" TYPE timestamp with time zone;`);
  }
  console.log('✅ Done converting all timestamps to timestamp with time zone');
  await c.end();
}

fix();
