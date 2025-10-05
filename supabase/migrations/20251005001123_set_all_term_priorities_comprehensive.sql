/*
  # Set Priorities for ALL Terms
  
  Comprehensive priority assignment for all 180 terms based on internship interview likelihood
*/

DO $$
BEGIN
  -- First set all to medium as default
  UPDATE terms SET priority = 'medium' WHERE priority IS NULL OR priority = '';
  
  -- 99% PRIORITY - Almost guaranteed in internship interviews
  UPDATE terms SET priority = '99%' WHERE term IN (
    'Class vs Object',
    'Field vs Property',
    'Encapsulation',
    'Abstraction',
    'Inheritance',
    'Polymorphism',
    'abstract class vs interface',
    'Constructor',
    'GET vs POST vs PUT vs PATCH vs DELETE',
    'Status Codes',
    'What is HTTP?',
    'Primary Key vs Foreign Key',
    'INNER JOIN vs LEFT JOIN',
    'Table / Row / Column',
    'DbContext',
    'FirstOrDefault vs SingleOrDefault',
    'Unit Test',
    'AAA Pattern',
    'DTO vs Entity vs ViewModel',
    'Client-Server',
    'Authentication vs Authorization',
    'Headers vs Body vs Query vs Cookies',
    'Content-Type',
    'Repository',
    'Service (Application Layer)',
    'Controller/Endpoint'
  );
  
  -- LIKELY PRIORITY - Very commonly asked in internship interviews
  UPDATE terms SET priority = 'likely' WHERE term IN (
    'Array',
    'List',
    'Dictionary',
    'Stack',
    'Queue',
    'HashSet',
    'LinkedList',
    'sealed',
    'static',
    'virtual / override / new',
    'Access Modifiers',
    'this keyword',
    'base keyword',
    'Value Types vs Reference Types',
    'struct vs class',
    'string (immutable)',
    'StringBuilder',
    'const vs readonly',
    'var vs explicit type',
    'Exception',
    'try-catch-finally',
    'IDisposable / using',
    'Garbage Collection',
    'async / await',
    'Task vs Thread',
    'Synchronous vs Asynchronous',
    'Middleware',
    'Include vs Projection',
    'N+1 Problem',
    'Integration Test',
    'Mock vs Stub vs Fake',
    'MVC Pattern',
    'REST API',
    'Dependency Injection',
    'JWT (JSON Web Token)',
    'Authorization',
    'Method Overloading',
    'null vs nullable types',
    'Generics',
    'IEnumerable vs IQueryable',
    'LINQ',
    'Sorting (Bubble, Quick, Merge)',
    'Big O Notation',
    'Binary Search',
    'Recursion',
    'HTTP Methods',
    'SQL SELECT',
    'WHERE clause',
    'ORDER BY',
    'Async programming',
    'Object',
    'Minimal API vs MVC Controllers',
    'JWT vs Session Cookie'
  );
  
  -- LOW PRIORITY - Advanced/niche topics, less common in internship interviews
  UPDATE terms SET priority = 'low' WHERE term IN (
    'BFS Traversal',
    'DFS Traversal',
    'Binary Search Tree (BST)',
    'Graph',
    'Covariance and Contravariance',
    'Expression-bodied members',
    'Extension Methods',
    'Indexers',
    'record (class/struct)',
    'Generic Constraints',
    'yield return',
    'Reflection',
    'Attributes',
    'E2E Test (End-to-End)',
    'Code Coverage',
    'TDD (Red-Green-Refactor)',
    'Isolation Levels',
    'Normalization vs Denormalization',
    'Eager vs Lazy Loading',
    'CQRS',
    'Event Sourcing',
    'Microservices',
    'Design Patterns Overview',
    'SOLID Principles',
    'CAP Theorem',
    'Regex',
    'Delegates',
    'Events',
    'Lambda Expressions (advanced)',
    'Dynamic types',
    'Tuple',
    'Pattern Matching',
    'React: useEffect',
    'React: key prop',
    'Angular Lifecycle Hooks',
    'Angular Reactive Forms',
    'Angular HttpClient',
    'TypeScript',
    'interface / type',
    'Git: Merge vs Rebase',
    'CI/CD Pipeline',
    'Pagination',
    'Cookies',
    'Location',
    'CORS in Development'
  );
  
  -- MEDIUM - Everything else (default)
  -- These are: moderately common, good to know, but not critical
  -- Examples: Sorting algorithms, HTTP headers (Accept, Authorization for non-99%),
  -- React basics, Testing concepts (Arrange-Act-Assert), etc.
  
  RAISE NOTICE 'Set priorities for all terms';
END $$;
