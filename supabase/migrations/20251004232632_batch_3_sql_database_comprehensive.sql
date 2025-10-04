/*
  # Batch 3: SQL & Database Comprehensive Terms
  
  Adds missing SQL terms:
  - Table/Row/Column basics
  - Normalization vs Denormalization
  - Isolation Levels
  - More SQL fundamentals
*/

DO $$
DECLARE
  cat_sql_id uuid;
BEGIN
  SELECT id INTO cat_sql_id FROM categories WHERE slug = 'sql';

  -- Table/Row/Column basics
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql_id,
    'Table / Row / Column',
    'Table = spreadsheet structure. Row = single record (one person, one order). Column = attribute (name, age, price). Relational database = collection of tables.',
    'Table: named collection of rows with defined schema. Row (tuple/record): single data entry with values for each column. Column (attribute): named, typed field storing specific data. Schema defines column names, types, and constraints.',
    'Fundamental relational database structure. Table is like an Excel sheet with predefined columns. Each row represents one entity (one user, one product). Each column represents one attribute (name, price, created_at). Column has data type (INT, VARCHAR, DATE) and optional constraints (NOT NULL, UNIQUE). Primary key uniquely identifies each row. Interview: explain table design, what makes a good table (normalized, meaningful columns), how rows relate via foreign keys. Avoid: storing multiple values in one column, wide tables with hundreds of columns, no primary key.',
    to_jsonb(ARRAY[
      'Storing multiple values in one column (violates 1NF)',
      'Tables without primary keys',
      'Too many columns (should split into related tables)',
      'Ambiguous column names (use user_id not id in joins)',
      'Not using appropriate data types',
      'Storing calculated data (should compute or use views)'
    ]),
    jsonb_build_object(
      'csharp', '-- CREATE TABLE
CREATE TABLE users (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Row identifier
    name VARCHAR(100) NOT NULL,         -- Column: text, required
    email VARCHAR(255) UNIQUE,          -- Column: unique
    age INT CHECK (age >= 0),           -- Column: integer with constraint
    created_at DATETIME DEFAULT GETDATE()
);

-- INSERT ROW
INSERT INTO users (name, email, age)
VALUES (''John Doe'', ''john@example.com'', 30);

-- Each INSERT creates one ROW:
-- | id | name     | email            | age | created_at          |
-- |----|----------|------------------|-----|---------------------|
-- | 1  | John Doe | john@example.com | 30  | 2024-10-04 10:30:00 |

-- SELECT specific COLUMNS
SELECT name, age FROM users WHERE id = 1;

-- SELECT all COLUMNS
SELECT * FROM users;

-- ALTER TABLE (add column)
ALTER TABLE users ADD COLUMN last_login DATETIME;

-- DESCRIBE table structure
EXEC sp_help ''users'';

-- Entity Framework Core
public class User {
    public int Id { get; set; }           // Maps to id column
    public string Name { get; set; }      // Maps to name column
    public string Email { get; set; }     // Maps to email column
    public int Age { get; set; }          // Maps to age column
    public DateTime CreatedAt { get; set; }
}',
      'typescript', '-- SQL (same across languages)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    age INTEGER CHECK (age >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email, age)
VALUES (''John Doe'', ''john@example.com'', 30);

-- TypeScript interface matching table
interface User {
    id: number;
    name: string;
    email: string;
    age: number;
    created_at: Date;
}

// Query with type
const result = await db.query<User>(
    ''SELECT * FROM users WHERE id = $1'',
    [1]
);'
    ),
    'Table Structure:

TABLE: users
┌────┬──────────┬──────────────────┬─────┬─────────────┐
│ id │ name     │ email            │ age │ created_at  │ ← COLUMNS
├────┼──────────┼──────────────────┼─────┼─────────────┤
│ 1  │ John Doe │ john@example.com │ 30  │ 2024-10-04  │ ← ROW 1
│ 2  │ Jane S.  │ jane@example.com │ 25  │ 2024-10-04  │ ← ROW 2
│ 3  │ Bob M.   │ bob@example.com  │ 35  │ 2024-10-05  │ ← ROW 3
└────┴──────────┴──────────────────┴─────┴─────────────┘
  ↑
  Primary Key

Database:
└─ Table: users
└─ Table: orders
└─ Table: products

Table = structure
Row = one record
Column = one attribute',
    100
  ) ON CONFLICT DO NOTHING;

  -- Normalization vs Denormalization
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql_id,
    'Normalization vs Denormalization',
    'Normalization = split data to reduce redundancy (users table + orders table separate). Denormalization = combine data for faster reads (store user name in orders table). Trade-off: normalized = less duplication, denormalized = faster queries.',
    'Normalization: organizing data to minimize redundancy via normal forms (1NF, 2NF, 3NF). Each fact stored once, related via foreign keys. Denormalization: intentionally introducing redundancy for query performance, typically after measuring bottlenecks. Trade-off: normalized = data integrity, denormalized = read speed.',
    'Normalization reduces duplication by splitting tables. Example: instead of storing customer name/address in every order row, store customer_id and look up from customers table. Benefits: no duplicate data, updates in one place, smaller tables. Costs: joins needed (slower). 1NF: atomic values, no repeating groups. 2NF: no partial dependencies. 3NF: no transitive dependencies. Denormalization is strategic duplication for performance - store commonly-needed data together even if redundant. Use case: read-heavy systems, reporting, caching. Interview: explain when to denormalize (after profiling, read >> writes), how to maintain consistency (triggers, application logic), always start normalized then selectively denormalize.',
    to_jsonb(ARRAY[
      'Denormalizing prematurely (optimize when proven slow)',
      'Not maintaining consistency in denormalized data',
      'Over-normalizing (too many tiny tables)',
      'Not understanding the trade-offs',
      'Denormalizing without measuring performance',
      'Forgetting to update denormalized copies'
    ]),
    jsonb_build_object(
      'csharp', '-- NORMALIZED (3NF)
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    total DECIMAL(10,2),
    created_at DATETIME
);

-- Query requires JOIN
SELECT o.id, c.name, o.total
FROM orders o
JOIN customers c ON o.customer_id = c.id;

-- DENORMALIZED (for performance)
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),  -- ← Redundant!
    customer_email VARCHAR(255), -- ← Redundant!
    total DECIMAL(10,2),
    created_at DATETIME
);

-- Query without JOIN (faster)
SELECT id, customer_name, total
FROM orders;

-- Trade-off: must update orders when customer changes
UPDATE orders
SET customer_name = ''New Name''
WHERE customer_id = 123;

-- Materialized view (controlled denormalization)
CREATE MATERIALIZED VIEW order_summary AS
SELECT 
    o.id,
    c.name AS customer_name,
    o.total,
    o.created_at
FROM orders o
JOIN customers c ON o.customer_id = c.id;

REFRESH MATERIALIZED VIEW order_summary;

-- EF Core example
public class Order {
    public int Id { get; set; }
    public int CustomerId { get; set; }
    public Customer Customer { get; set; }  // Normalized
    
    // Denormalized for fast reads
    public string CustomerName { get; set; }
}',
      'typescript', '-- NORMALIZED
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    total NUMERIC(10,2)
);

-- Need JOIN
SELECT o.id, c.name, o.total
FROM orders o
JOIN customers c ON o.customer_id = c.id;

-- DENORMALIZED
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    customer_name VARCHAR(100), -- Duplicated
    total NUMERIC(10,2)
);

-- No JOIN needed
SELECT id, customer_name, total
FROM orders;'
    ),
    'Normalization vs Denormalization:

NORMALIZED (minimize redundancy):
┌─────────────┐      ┌──────────────┐
│ customers   │      │ orders       │
├─────────────┤      ├──────────────┤
│ id (PK)     │←─────│ customer_id  │
│ name        │      │ total        │
│ email       │      └──────────────┘
└─────────────┘

Query: JOIN required
✓ No duplication
✓ Update once
✗ Slower (join cost)

DENORMALIZED (fast reads):
┌──────────────────────┐
│ orders               │
├──────────────────────┤
│ customer_id          │
│ customer_name   ←─┐  │ Duplicated!
│ customer_email  ←─┤  │
│ total              │  │
└──────────────────────┘

Query: Direct read
✓ Fast (no join)
✗ Duplication
✗ Update multiple places

When to denormalize:
→ Read-heavy workload
→ Proven performance bottleneck
→ Can maintain consistency',
    101
  ) ON CONFLICT DO NOTHING;

  -- Isolation Levels
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_sql_id,
    'Isolation Levels',
    'Isolation level controls what one transaction sees from another. Read Committed = see only committed data. Repeatable Read = same query always returns same data. Serializable = complete isolation, as if alone. Higher level = safer but slower.',
    'Isolation levels: ACID property controlling concurrent transaction visibility. Read Uncommitted (lowest), Read Committed, Repeatable Read, Serializable (highest). Trade-off between concurrency (performance) and consistency (avoiding anomalies like dirty reads, non-repeatable reads, phantom reads).',
    'Isolation levels prevent race conditions in concurrent database access. Read Uncommitted: sees uncommitted changes (dirty reads). Read Committed (default in many DBs): sees only committed data, prevents dirty reads. Repeatable Read: same query always returns same rows during transaction, prevents non-repeatable reads. Serializable: complete isolation, prevents phantom reads (new rows appearing). Higher isolation = more locks = less concurrency. Interview: explain (1) dirty read (reading uncommitted rollback), (2) non-repeatable read (same query different results), (3) phantom read (new rows appear). Choose level based on consistency needs vs performance. Most apps use Read Committed. Financial systems use Serializable.',
    to_jsonb(ARRAY[
      'Using Read Uncommitted in production (dirty reads)',
      'Not understanding performance impact of Serializable',
      'Choosing isolation level without understanding anomalies',
      'Not handling deadlocks with higher isolation',
      'Using default level without considering requirements',
      'Not testing concurrent scenarios'
    ]),
    jsonb_build_object(
      'csharp', '-- SET ISOLATION LEVEL (SQL)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
    SELECT * FROM accounts WHERE id = 1;
COMMIT;

-- READ UNCOMMITTED (dirty reads possible)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- Can see uncommitted changes from other transactions ✗

-- READ COMMITTED (default)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Sees only committed data ✓
-- Same query might return different results

-- REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Same query returns same rows
-- But new rows can appear (phantom reads)

-- SERIALIZABLE (strictest)
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Complete isolation, no anomalies
-- As if transactions run sequentially

-- Example: dirty read
-- Transaction 1:
BEGIN TRANSACTION;
UPDATE accounts SET balance = 1000 WHERE id = 1;
-- (not committed yet)

-- Transaction 2 (Read Uncommitted):
SELECT balance FROM accounts WHERE id = 1;
-- Returns 1000 (uncommitted!) ✗

-- Transaction 1:
ROLLBACK; -- balance back to original

-- Transaction 2 read wrong data!

-- EF Core setting isolation
using var transaction = _context.Database.BeginTransaction(
    System.Data.IsolationLevel.ReadCommitted
);
try {
    var account = _context.Accounts.Find(1);
    account.Balance += 100;
    _context.SaveChanges();
    transaction.Commit();
} catch {
    transaction.Rollback();
}',
      'typescript', '-- PostgreSQL isolation levels
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SELECT * FROM accounts WHERE id = 1;
COMMIT;

-- Node.js with pg
const client = await pool.connect();
try {
    await client.query(''BEGIN ISOLATION LEVEL REPEATABLE READ'');
    const result = await client.query(
        ''SELECT * FROM accounts WHERE id = $1'',
        [1]
    );
    await client.query(''COMMIT'');
} catch (e) {
    await client.query(''ROLLBACK'');
} finally {
    client.release();
}'
    ),
    'Isolation Levels:

READ UNCOMMITTED
├─ Dirty reads ✗
├─ Non-repeatable reads ✗
├─ Phantom reads ✗
└─ Fastest

READ COMMITTED (default)
├─ Dirty reads ✓
├─ Non-repeatable reads ✗
├─ Phantom reads ✗
└─ Balanced

REPEATABLE READ
├─ Dirty reads ✓
├─ Non-repeatable reads ✓
├─ Phantom reads ✗
└─ Stricter

SERIALIZABLE
├─ Dirty reads ✓
├─ Non-repeatable reads ✓
├─ Phantom reads ✓
└─ Slowest (most locks)

Anomalies:
Dirty read: Read uncommitted data
Non-repeatable: Same query, different results
Phantom: New rows appear

Balance: Consistency ↔ Performance',
    102
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Batch 3: Added 3 SQL & Database terms';
END $$;
