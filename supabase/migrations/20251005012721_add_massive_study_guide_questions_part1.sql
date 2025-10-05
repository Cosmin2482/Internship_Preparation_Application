/*
  # Add Massive Study Guide Questions - Part 1
  
  Architecture, HTTP, SQL, .NET questions with detailed explanations
*/

DO $$
DECLARE
  general_term_id uuid;
BEGIN
  SELECT id INTO general_term_id FROM terms WHERE term = 'Abstraction' LIMIT 1;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation) VALUES
  
  -- Architecture: Client-Server
  (general_term_id, 'Why use Client-Server architecture?',
   '["It is trendy", "Separates concerns, increases scalability and security - client handles UI, server handles logic and data", "Only for large apps", "No real benefit"]'::jsonb, 1,
   'Client-Server separates concerns: client (browser/app) requests resources and handles presentation; server processes logic, manages data, enforces security. This separation enables independent scaling, better security (sensitive logic on server), and supports multiple client types.'),
  
  -- Layered Architecture
  (general_term_id, 'Why use Layered Architecture (Presentation → Application → Domain → Infrastructure)?',
   '["To make code complex", "Easy testing (test Domain without DB), localized changes (swap DB without changing business logic)", "Only for enterprises", "Slows development"]'::jsonb, 1,
   'Layered architecture isolates responsibilities: Presentation (API/UI), Application (orchestration), Domain (business logic), Infrastructure (DB/external services). This enables testing Domain without real DB, swapping Infrastructure (SQL to MongoDB) without touching business logic.'),
  
  -- REST Principles
  (general_term_id, 'What are the key principles of REST?',
   '["Just use HTTP", "Resources with URIs, semantic methods, consistent status codes, stateless, cacheable", "Only JSON", "No rules"]'::jsonb, 1,
   'REST principles: Resources identified by URIs (/api/users/123), semantic HTTP methods (GET/POST/PUT/DELETE), consistent status codes, stateless (no session on server), cacheable responses. This creates predictable, scalable APIs.'),
  
  -- HTTP Request Anatomy
  (general_term_id, 'What are the three main parts of an HTTP Request?',
   '["URL only", "Start line (method + URL + version), Headers (metadata), Body (data for POST/PUT/PATCH)", "Just body", "Only headers"]'::jsonb, 1,
   'HTTP Request has: 1) Start line (GET /api/users HTTP/1.1), 2) Headers (Content-Type, Authorization, Accept), 3) Body (actual data, only for POST/PUT/PATCH). Query params (?id=5) are part of the URL. Cookies are in headers.'),
  
  -- HTTP Methods
  (general_term_id, 'Why is PUT idempotent but POST is not?',
   '["PUT is newer", "PUT replaces resource at known URI - same result if repeated; POST creates new resource each time", "They are both idempotent", "POST is deprecated"]'::jsonb, 1,
   'PUT replaces a resource at a specific URI (/api/users/123). Calling it N times produces the same final state (idempotent). POST creates a new resource each time (/api/users), so N calls create N resources (not idempotent). This matters for safe retry logic.'),
  
  -- Status Code 422
  (general_term_id, 'When should you use 422 instead of 400?',
   '["Never", "422 for semantic/validation errors with well-formed JSON; 400 for malformed requests (broken JSON, missing headers)", "They are the same", "422 is deprecated"]'::jsonb, 1,
   '400 Bad Request: Malformed request (invalid JSON syntax, missing required headers). 422 Unprocessable Entity: Well-formed request but semantic/business validation fails (age: -5, duplicate email). This distinction helps clients understand the error type.'),
  
  -- SQL INNER vs LEFT JOIN
  (general_term_id, 'What is the difference between INNER JOIN and LEFT JOIN?',
   '["No difference", "INNER returns only matching rows from both tables; LEFT returns all left rows plus matches (NULL if no match)", "LEFT is faster", "INNER includes NULLs"]'::jsonb, 1,
   'INNER JOIN returns only rows with matches in both tables (intersection). LEFT JOIN returns all rows from left table plus matching rows from right table (NULL for non-matching right rows). Use LEFT when you need all left records even without related data.'),
  
  -- SQL Indexes
  (general_term_id, 'Why are indexes important and what is their cost?',
   '["No cost", "Accelerate WHERE/JOIN/ORDER BY from O(N) to O(log N), but slow down INSERT/UPDATE/DELETE", "Only for primary keys", "No performance impact"]'::jsonb, 1,
   'Indexes (usually B-Trees) speed up searches from O(N) linear scan to O(log N) tree lookup. Put indexes on columns used in WHERE, JOIN, ORDER BY. Cost: Every INSERT/UPDATE/DELETE must update all indexes, slowing writes. Index only frequently queried columns.'),
  
  -- SQL Transactions ACID
  (general_term_id, 'Why is Atomicity (all-or-nothing) vital in transactions?',
   '["It is not vital", "Ensures a set of operations either all succeed or all fail, preventing inconsistent data states", "Only for large databases", "Just for performance"]'::jsonb, 1,
   'Atomicity ensures operations in a transaction either all complete or all rollback. Example: Bank transfer must debit one account AND credit another - not just one. Without atomicity, money could disappear or duplicate. ACID (Atomicity, Consistency, Isolation, Durability) guarantees data integrity.'),
  
  -- Normalization
  (general_term_id, 'Why normalize databases (1NF/2NF/3NF)?',
   '["To make queries complex", "Reduces data redundancy, prevents update/delete anomalies, simplifies structure", "Only for large databases", "Slows performance"]'::jsonb, 1,
   'Normalization reduces redundancy by organizing data into separate related tables. This prevents anomalies where updating one row requires updating multiple places. However, normalized data requires JOINs. Denormalize for read-heavy scenarios (reports) where some redundancy is acceptable for performance.'),
  
  -- SQL Injection
  (general_term_id, 'How do you prevent SQL Injection?',
   '["Validate input length", "Use parameterized queries (prepared statements) or ORMs that auto-parameterize; NEVER concatenate user input into SQL", "Only allow numbers", "Use encryption"]'::jsonb, 1,
   'SQL Injection is prevented by parameterized queries: "SELECT * FROM Users WHERE Id = @id" instead of "SELECT * FROM Users WHERE Id = " + userId. ORMs like EF Core automatically parameterize. Never concatenate user input directly into SQL strings.');

END $$;
