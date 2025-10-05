/*
  # Update Term Priorities - Comprehensive and Accurate
  
  Set individual term priorities based on interview likelihood
  99% = Almost guaranteed to be asked
  likely = Very commonly asked
  medium = Sometimes asked
  low = Advanced/niche topics
*/

DO $$
BEGIN
  -- Reset all to medium first
  UPDATE terms SET priority = 'medium';
  
  -- 99% PRIORITY - Core fundamentals, asked in almost every interview
  UPDATE terms SET priority = '99%' WHERE term IN (
    -- OOP Fundamentals (critical)
    'Class vs Object',
    'Field vs Property',
    'Encapsulation',
    'Abstraction',
    'Inheritance',
    'Polymorphism',
    'abstract class vs interface',
    'Constructor',
    'Method Overloading',
    
    -- HTTP/REST (critical for web dev)
    'GET vs POST vs PUT vs PATCH vs DELETE',
    'Status Codes',
    'What is HTTP?',
    'Headers vs Body vs Query vs Cookies',
    'Content-Type',
    
    -- SQL (critical for backend)
    'Primary Key vs Foreign Key',
    'INNER JOIN vs LEFT JOIN',
    'Table / Row / Column',
    
    -- .NET Core (critical for .NET roles)
    'DbContext',
    'FirstOrDefault vs SingleOrDefault',
    
    -- Testing (critical)
    'Unit Test',
    'AAA Pattern',
    
    -- Architecture (critical)
    'DTO vs Entity vs ViewModel',
    'Client-Server',
    
    -- Auth (critical for security)
    'Authentication vs Authorization'
  );
  
  -- LIKELY PRIORITY - Very common, asked frequently
  UPDATE terms SET priority = 'likely' WHERE term IN (
    -- OOP Common
    'sealed',
    'static',
    'virtual / override / new',
    'Access Modifiers',
    'this keyword',
    'base keyword',
    
    -- Data Structures (very common)
    'Array',
    'List',
    'Dictionary',
    'Stack',
    'Queue',
    'HashSet',
    'LinkedList',
    
    -- C# Fundamentals
    'Value Types vs Reference Types',
    'struct vs class',
    'string (immutable)',
    'StringBuilder',
    'const vs readonly',
    'var vs explicit type',
    
    -- Exception & Memory
    'Exception',
    'try-catch-finally',
    'IDisposable / using',
    'Garbage Collection',
    
    -- .NET Common
    'Middleware',
    'Include vs Projection',
    'N+1 Problem',
    
    -- Testing Common
    'Integration Test',
    'Mock vs Stub vs Fake',
    'Arrange-Act-Assert',
    
    -- Architecture Common
    'Repository',
    'Service (Application Layer)',
    'MVC Pattern',
    'REST API',
    'Dependency Injection',
    
    -- Auth Common
    'JWT (JSON Web Token)',
    'Authorization',
    
    -- Async (very common)
    'async / await',
    'Task vs Thread',
    'Synchronous vs Asynchronous'
  );
  
  -- LOW PRIORITY - Advanced/niche, less commonly asked
  UPDATE terms SET priority = 'low' WHERE term IN (
    -- Advanced Algorithms
    'BFS (Breadth-First Search)',
    'DFS (Depth-First Search)',
    'Binary Search Tree',
    'Graph',
    
    -- Advanced OOP
    'Covariance and Contravariance',
    'Expression-bodied members',
    'Extension Methods',
    'Indexers',
    
    -- Advanced C#
    'record (class/struct)',
    'Generic Constraints',
    'yield return',
    'Reflection',
    'Attributes',
    
    -- Advanced Testing
    'E2E Test (End-to-End)',
    'Code Coverage',
    'TDD (Red-Green-Refactor)',
    
    -- Advanced DB
    'Isolation Levels',
    'Normalization vs Denormalization',
    'Eager vs Lazy Loading',
    
    -- Advanced Architecture
    'CQRS',
    'Event Sourcing',
    'Microservices',
    
    -- Advanced Concepts
    'Design Patterns Overview',
    'SOLID Principles',
    'CAP Theorem'
  );
  
  -- MEDIUM PRIORITY remains for everything else (default)
  -- Includes: common but not critical topics like Sorting algorithms,
  -- React basics, Git basics, etc.
  
  RAISE NOTICE 'Updated term priorities based on interview likelihood';
END $$;
