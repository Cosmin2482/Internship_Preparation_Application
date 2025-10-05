/*
  # Add Priority to Terms
  
  Add priority field to terms for individual term prioritization
*/

DO $$
BEGIN
  -- Add priority column to terms
  ALTER TABLE terms ADD COLUMN IF NOT EXISTS priority text DEFAULT 'medium';
  
  -- Update some example terms with priorities
  -- You can customize these based on your needs
  
  -- 99% priority terms (most critical)
  UPDATE terms SET priority = '99%' WHERE term IN (
    'Class vs Object',
    'Field vs Property',
    'Encapsulation',
    'Abstraction',
    'Inheritance',
    'Polymorphism',
    'abstract class vs interface',
    'virtual / override / new',
    'GET vs POST vs PUT vs PATCH vs DELETE',
    'Status Codes',
    'Primary Key vs Foreign Key',
    'INNER JOIN vs LEFT JOIN',
    'DbContext',
    'FirstOrDefault vs SingleOrDefault',
    'Unit Test',
    'AAA Pattern',
    'DTO vs Entity vs ViewModel',
    'Repository',
    'Service (Application Layer)',
    'Controller/Endpoint',
    'Authentication vs Authorization',
    'What is HTTP?'
  );
  
  -- Likely priority
  UPDATE terms SET priority = 'likely' WHERE term IN (
    'sealed',
    'static',
    'const vs readonly',
    'struct vs class',
    'Exception',
    'IDisposable / using',
    'Middleware',
    'Include vs Projection',
    'N+1 Problem',
    'Integration Test',
    'Mock vs Stub vs Fake',
    'Client-Server',
    'Minimal API vs MVC Controllers',
    'JWT (JSON Web Token)'
  );
  
  -- Medium priority (default for most)
  -- Already set as default
  
  -- Low priority (advanced/less common)
  UPDATE terms SET priority = 'low' WHERE term IN (
    'record (class/struct)',
    'Generic Constraints',
    'Isolation Levels',
    'E2E Test (End-to-End)',
    'Code Coverage',
    'Eager vs Lazy Loading',
    'Pagination'
  );
  
  RAISE NOTICE 'Added priority field to terms';
END $$;
