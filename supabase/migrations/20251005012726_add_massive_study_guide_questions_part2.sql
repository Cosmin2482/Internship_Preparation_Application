/*
  # Add Massive Study Guide Questions - Part 2
  
  .NET, EF Core, Testing, SOLID, Computer Science fundamentals
*/

DO $$
DECLARE
  general_term_id uuid;
BEGIN
  SELECT id INTO general_term_id FROM terms WHERE term = 'Abstraction' LIMIT 1;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation) VALUES
  
  -- EF Core DbContext
  (general_term_id, 'What is DbContext in EF Core?',
   '["A database", "The bridge between C# entities and database, manages change tracking and Unit of Work pattern", "Only for SQL Server", "A connection string"]'::jsonb, 1,
   'DbContext is the session between your application and database. It tracks changes to entities (Change Tracking), manages Unit of Work (batches changes), and translates LINQ queries to SQL. Maps entities via conventions, Data Annotations, or Fluent API.'),
  
  -- AsNoTracking
  (general_term_id, 'When should you use AsNoTracking() in EF Core?',
   '["Always", "For read-only queries (GET endpoints, reports) to improve performance and reduce memory", "Only for updates", "Never use it"]'::jsonb, 1,
   'AsNoTracking() disables change tracking. Use for read-only scenarios (GET requests, reports) where you will not modify entities. This improves performance (no tracking overhead) and reduces memory. Use tracking (default) when you need to call SaveChanges() after modifying entities.'),
  
  -- Dependency Injection in .NET
  (general_term_id, 'Why is Dependency Injection built-in to ASP.NET Core?',
   '["Historical reasons", "Encourages decoupling and testability - inject interfaces, swap implementations (real vs mock)", "Only for large apps", "Makes code slower"]'::jsonb, 1,
   'DI is built-in to promote loose coupling and testability. Instead of creating dependencies with new, you inject them via constructor. This allows swapping implementations (SqlUserRepo vs MockUserRepo in tests) without changing consuming code. Services registered in Program.cs, injected automatically.'),
  
  -- Minimal API vs MVC
  (general_term_id, 'When should you use Minimal API vs MVC Controllers?',
   '["Always use MVC", "Minimal API for microservices/simple APIs (concise lambdas); MVC for complex apps with views and many endpoints", "They are identical", "Minimal API is deprecated"]'::jsonb, 1,
   'Minimal API uses lambdas for routes (app.MapGet(...)), very concise - ideal for microservices, simple APIs, POCs. MVC Controllers use classes with multiple actions - better for complex applications, when you need filters, model binding, views. Choose based on complexity.'),
  
  -- Middleware
  (general_term_id, 'What is Middleware and why does order matter?',
   '["A database layer", "Software components in request pipeline; order matters because earlier middleware sees request first", "Only for logging", "Order does not matter"]'::jsonb, 1,
   'Middleware sits between server and your endpoint handler. Request flows through pipeline in order: Routing → CORS → Authentication → Authorization → Your Handler → Response (reverse). Order matters: Authentication must come before Authorization; Exception handling should be first to catch all errors.'),
  
  -- AAA Pattern
  (general_term_id, 'What does AAA stand for in unit testing?',
   '["Always Add Assertions", "Arrange (setup), Act (execute), Assert (verify) - structured test pattern", "Automated Assertion Analysis", "All About Algorithms"]'::jsonb, 1,
   'AAA is a structured test pattern: Arrange (set up preconditions - create objects, mocks, test data), Act (execute the method under test), Assert (verify the result matches expected). This clear structure makes tests readable and maintainable.'),
  
  -- Mock vs Stub
  (general_term_id, 'What is the difference between Mock and Stub?',
   '["No difference", "Stub provides canned responses; Mock records interactions and allows verification in Assert phase", "Mock is newer", "Stub is faster"]'::jsonb, 1,
   'Stub provides predetermined responses with minimal logic (StubPayment.Pay() does nothing). Mock goes further by recording how it was called (which methods, with what parameters, how many times) and allows verification (Moq.Verify(x => x.Pay(100), Times.Once)). Mocks are used in Assert.'),
  
  -- TDD Red-Green-Refactor
  (general_term_id, 'What is the TDD Red-Green-Refactor cycle?',
   '["A color scheme", "Red (write failing test) → Green (write minimum code to pass) → Refactor (improve code, re-run test)", "Only for large teams", "Deprecated practice"]'::jsonb, 1,
   'TDD cycle: 1) RED - Write test first, it fails (red) because code does not exist. 2) GREEN - Write minimum code to make test pass (green). 3) REFACTOR - Improve code quality (remove duplication, better names) while keeping tests green. This ensures testable design and no unused code.'),
  
  -- SOLID: Single Responsibility
  (general_term_id, 'What does Single Responsibility Principle mean?',
   '["One class per file", "A class should have one reason to change - one clear responsibility", "Only one method per class", "One instance only"]'::jsonb, 1,
   'SRP states a class should have only one reason to change, meaning one focused responsibility. Example: UserService handles user operations; EmailService handles emails. Do not mix logging, business logic, and data access in one class. This reduces coupling and makes changes localized.'),
  
  -- SOLID: Dependency Inversion
  (general_term_id, 'What does Dependency Inversion Principle state?',
   '["Invert all dependencies", "High-level modules should depend on abstractions (interfaces), not concrete implementations", "Use more classes", "Avoid interfaces"]'::jsonb, 1,
   'DIP states: Depend on abstractions (interfaces), not concrete classes. High-level business logic should not depend on low-level details (database, email). Instead, both depend on interfaces. This enables flexibility (swap SQL for MongoDB), testability (inject mocks), reduces coupling.');

END $$;
