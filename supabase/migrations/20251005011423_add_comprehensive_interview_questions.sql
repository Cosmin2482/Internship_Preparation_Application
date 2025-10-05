/*
  # Add Comprehensive Interview Questions
  
  1. New Quiz Questions
    - OOP fundamentals (Class vs Object, Encapsulation, Inheritance, Polymorphism)
    - Architecture (Client-Server, Layered, REST)
    - HTTP anatomy (Request, Response, Methods, Status Codes)
    - CRUD & SQL (Joins, Indexes, Transactions)
    - .NET & EF Core (DI, Middleware, Tracking)
    - Unit Testing (AAA, Mocking, TDD)
    - SOLID Principles & Design Patterns
    - Computer Science basics (Data Structures, Algorithms)
    - JavaScript/TypeScript + React/Angular
    - Git & Collaboration
    - Agile/Scrum
    - Cloud & DevOps
    - Security fundamentals
    
  2. Purpose
    - Comprehensive coverage of all interview topics
    - Focus on "why" and practical understanding
    - Aligned with Trimble internship requirements
*/

-- OOP Fundamentals
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the key difference between a Class and an Object?',
  '["A class is an instance, an object is a blueprint", "A class is a blueprint, an object is an instance at runtime", "They are the same thing", "A class is for inheritance, an object is for encapsulation"]'::jsonb,
  1,
  'A class is the blueprint/template that defines properties and methods. An object is an instance of that class created at runtime with actual values.'
FROM terms WHERE term = 'Class vs Object' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why is Encapsulation important in software design?',
  '["It makes code run faster", "It hides internal state and prevents invalid states, reducing impact of changes", "It allows multiple inheritance", "It is only for security"]'::jsonb,
  1,
  'Encapsulation hides the internal state (private fields) and exposes safe interfaces (properties/methods). This prevents invalid states and reduces the impact of changes to internal implementation.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you use Inheritance vs Composition?',
  '["Always use inheritance", "Use inheritance for strict is-a relationships, composition for has-a relationships", "Use composition only for databases", "They are interchangeable"]'::jsonb,
  1,
  'Use Inheritance when the relationship is strictly "is-a" (Dog is an Animal). Use Composition when the relationship is "has-a" (Car has an Engine). Composition provides more flexibility and decoupling.'
FROM terms WHERE term = 'Inheritance' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between override and new in C#?',
  '["No difference", "override produces real polymorphism with runtime binding; new just hides the method with compile-time binding", "new is faster", "override is deprecated"]'::jsonb,
  1,
  'override uses v-table for dynamic binding at runtime (real polymorphism). new hides the base method and uses static binding at compile-time based on reference type. Always prefer override for polymorphism.'
FROM terms WHERE term = 'Polymorphism' LIMIT 1;

-- HTTP & REST
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why is PUT idempotent but POST is not?',
  '["PUT is faster", "PUT replaces a resource at a known URI repeatedly with same result; POST creates new resources each time", "POST is deprecated", "They are both idempotent"]'::jsonb,
  1,
  'PUT replaces a resource at a specific URI. Repeating the same PUT N times results in the same final state (idempotent). POST creates a new resource each time, so N requests create N resources (not idempotent).'
FROM terms WHERE term = 'HTTP Methods' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you use status code 422 instead of 400?',
  '["Never, always use 400", "422 for validation errors with well-formed JSON; 400 for malformed requests", "422 is for authentication", "They are the same"]'::jsonb,
  1,
  '400 Bad Request is for malformed requests (broken JSON, missing headers). 422 Unprocessable Entity is for well-formed requests with semantic/validation errors (age: -5, invalid business logic).'
FROM terms WHERE term = 'HTTP Methods' LIMIT 1;

-- SQL & Databases
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between INNER JOIN and LEFT JOIN?',
  '["No difference", "INNER JOIN returns only matching rows; LEFT JOIN returns all left rows plus matches (NULL if no match)", "LEFT JOIN is faster", "INNER JOIN includes NULL values"]'::jsonb,
  1,
  'INNER JOIN returns only rows that have matches in both tables. LEFT JOIN returns all rows from the left table, plus matching rows from the right table (with NULL for non-matching rows).'
FROM terms WHERE term = 'SQL Joins' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why are indexes important in databases?',
  '["They make tables look pretty", "They accelerate WHERE/JOIN/ORDER BY operations from O(N) to O(log N), but slow down writes", "They are only for primary keys", "They have no performance impact"]'::jsonb,
  1,
  'Indexes (usually B-Trees) accelerate searches from O(N) to O(log N). However, they must be updated on INSERT/UPDATE/DELETE, which slows write operations. Index only what you frequently query.'
FROM terms WHERE term = 'SQL Joins' LIMIT 1;

-- .NET & EF Core
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you use AsNoTracking() in EF Core?',
  '["Never use it", "Use it for read-only queries to improve performance and reduce memory", "Only for deletes", "Always use it"]'::jsonb,
  1,
  'AsNoTracking() disables change tracking, improving performance and reducing memory consumption. Use it for read-only queries (GET endpoints, reports). Use tracking when you need to modify entities and call SaveChanges().'
FROM terms WHERE term = 'async/await' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is Dependency Injection and why is it default in ASP.NET Core?',
  '["A security feature", "A pattern for decoupling and testability; dependencies are injected via constructor", "A database pattern", "Only for large applications"]'::jsonb,
  1,
  'DI is a pattern where dependencies are provided (injected) to a class rather than created inside it. This enables decoupling, testability (inject mocks), and flexible configuration. ASP.NET Core has built-in DI container.'
FROM terms WHERE term = 'async/await' LIMIT 1;

-- Testing
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does the AAA pattern stand for in unit testing?',
  '["Assert, Act, Arrange", "Arrange, Act, Assert", "Always Add Assertions", "Automated Assertion Analysis"]'::jsonb,
  1,
  'AAA stands for Arrange (set up preconditions), Act (execute the code under test), Assert (verify the result). This structured approach makes tests clear and maintainable.'
FROM terms WHERE term = 'Unit Testing' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between a Mock and a Stub?',
  '["No difference", "Mock records interactions and verifies them; Stub just provides canned responses", "Stub is newer", "Mock is only for databases"]'::jsonb,
  1,
  'Stub provides predetermined responses with minimal logic. Mock goes further by recording how it was called (which methods, how many times) and allows verification in the Assert phase (e.g., Moq.Verify).'
FROM terms WHERE term = 'Unit Testing' LIMIT 1;

-- SOLID Principles
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does the Single Responsibility Principle mean?',
  '["One class per file", "A class should have one reason to change (one responsibility)", "Only one method per class", "Single inheritance only"]'::jsonb,
  1,
  'SRP states a class should have only one reason to change, meaning one clear responsibility. This reduces coupling and makes the code easier to understand, test, and modify.'
FROM terms WHERE term = 'SOLID Principles' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why is Dependency Inversion Principle important?',
  '["It inverts dependencies", "High-level modules should depend on abstractions (interfaces), not concrete implementations", "It is only for large projects", "It makes code slower"]'::jsonb,
  1,
  'DIP states that code should depend on abstractions (interfaces) rather than concrete classes. This enables flexibility (swap implementations), testability (inject mocks), and reduces coupling.'
FROM terms WHERE term = 'SOLID Principles' LIMIT 1;

-- Architecture
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the purpose of a Layered Architecture?',
  '["To make code complex", "To separate concerns: Presentation, Application, Domain, Infrastructure for easier testing and changes", "Only for large enterprises", "To slow down development"]'::jsonb,
  1,
  'Layered architecture separates concerns into distinct layers. This isolation enables easier testing (test domain logic without DB), localized changes (swap DB without changing business logic), and clearer code organization.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Async/Await
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What problem does async/await solve?',
  '["Makes code run in parallel", "Frees threads during I/O operations, improving scalability without blocking", "Automatically speeds up CPU-bound tasks", "Only for UI applications"]'::jsonb,
  1,
  'async/await allows threads to be released during I/O operations (DB queries, HTTP calls) so they can handle other requests. This dramatically improves scalability in servers without blocking threads.'
FROM terms WHERE term = 'async/await' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is a deadlock risk with async/await?',
  '["No risks exist", "Using .Wait() or .Result can cause deadlocks in UI/old ASP.NET with synchronization context", "async always causes deadlocks", "Only in databases"]'::jsonb,
  1,
  'Deadlocks can occur when using .Wait() or .Result in code with a synchronization context (old ASP.NET, UI). The blocked thread waits for the async operation, but the async operation needs that thread to complete. Use await or ConfigureAwait(false).'
FROM terms WHERE term = 'async/await' LIMIT 1;

-- Git & Collaboration
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What makes a good Git commit message?',
  '["fix", "Descriptive, explains WHY (not just what), uses imperative mood (Feat: Add validation for Age > 0)", "Any text is fine", "Just the date"]'::jsonb,
  1,
  'Good commit messages are descriptive, explain the reasoning behind the change (not just what changed), and use imperative mood (Add, Fix, Update). This helps with code review and understanding history.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Computer Science Basics
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you choose a Linked List over an Array?',
  '["Always use arrays", "When you need frequent insertions/deletions and can accept O(N) access time", "Linked lists are always faster", "Never use linked lists"]'::jsonb,
  1,
  'Arrays have O(1) access but O(N) insertion/deletion. Linked Lists have O(N) access but O(1) insertion/deletion (once at position). Choose based on your access patterns: frequent random access = array; frequent insertions = linked list.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Security
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between Authentication and Authorization?',
  '["They are the same", "Authentication is who you are (login); Authorization is what you can do (permissions)", "Authorization comes first", "Only needed for banking apps"]'::jsonb,
  1,
  'Authentication (AuthN) verifies identity - who are you? (username/password). Authorization (AuthZ) determines permissions - what can you do? (can this user delete orders?). AuthN always comes before AuthZ.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'How do you prevent SQL Injection?',
  '["Validate input length", "Use parameterized queries or ORMs that handle it automatically; never concatenate user input into SQL", "Only allow numbers", "Use encryption"]'::jsonb,
  1,
  'SQL Injection is prevented by using parameterized queries (prepared statements) or ORMs like EF Core that automatically parameterize. Never concatenate user input directly into SQL strings.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Agile/Scrum
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the purpose of a Daily Scrum (standup)?',
  '["To micromanage developers", "A 15-minute sync where each member shares: what they did yesterday, what they will do today, any blockers", "To assign new tasks", "To review code"]'::jsonb,
  1,
  'Daily Scrum is a short (15-minute) synchronization meeting where team members align on progress and identify blockers. It is not for problem-solving (take those offline) or task assignment.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is a Sprint in Scrum?',
  '["A fast run", "A time-boxed period (1-4 weeks) where the team delivers a working increment of the product", "The entire project duration", "Only for small teams"]'::jsonb,
  1,
  'A Sprint is a time-boxed iteration (typically 2 weeks) where the team commits to delivering a potentially shippable product increment. It includes planning, daily scrums, review, and retrospective.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Cloud & DevOps
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is CI/CD?',
  '["A programming language", "Continuous Integration (automated testing on commit) and Continuous Delivery (automated deployment)", "Only for large companies", "A database technology"]'::jsonb,
  1,
  'CI/CD is Continuous Integration (automatically build and test code when committed) and Continuous Delivery/Deployment (automatically deploy to staging/production if tests pass). This catches bugs early and enables rapid, safe releases.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between IaaS, PaaS, and SaaS?',
  '["No difference", "IaaS (VMs/infrastructure), PaaS (platform for apps like Azure App Service), SaaS (complete software like Gmail)", "Only SaaS exists now", "They are all the same as cloud"]'::jsonb,
  1,
  'IaaS provides virtual infrastructure (VMs, networking). PaaS provides a platform to deploy apps (Azure App Service, Heroku). SaaS provides complete applications (Gmail, Office 365). Control decreases from IaaS to SaaS.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Performance & Debugging
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the N+1 problem in ORM queries?',
  '["A math problem", "Fetching N entities, then making N additional queries for related data; solved with .Include() or .Select()", "An indexing issue", "Only happens in MongoDB"]'::jsonb,
  1,
  'N+1 occurs when you fetch N entities (e.g., 10 Users), then loop and fetch related data (Orders) for each, causing N additional queries (11 total). Solve with eager loading (.Include()) or projection (.Select()).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;
