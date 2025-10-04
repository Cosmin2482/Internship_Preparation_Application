/*
  # Translate Key Term Titles to Romanian
  
  Translate most important terms for better UX
*/

-- Update key OOP terms
UPDATE terms SET term = 'Cei 4 Piloni OOP' WHERE term = '4 Pillars of OOP' AND language = 'ro';
UPDATE terms SET term = 'Encapsulare' WHERE term = 'Encapsulation' AND language = 'ro';
UPDATE terms SET term = 'Abstractizare' WHERE term = 'Abstraction' AND language = 'ro';
UPDATE terms SET term = 'Moștenire' WHERE term = 'Inheritance' AND language = 'ro';
UPDATE terms SET term = 'Polimorfism' WHERE term = 'Polymorphism' AND language = 'ro';
UPDATE terms SET term = 'Overloading vs Overriding' WHERE term = 'Method Overloading vs Overriding' AND language = 'ro';
UPDATE terms SET term = 'Clase și Obiecte' WHERE term = 'Classes and Objects' AND language = 'ro';
UPDATE terms SET term = 'Interfețe vs Clase Abstracte' WHERE term = 'Interfaces vs Abstract Classes' AND language = 'ro';
UPDATE terms SET term = 'Modificatori de Acces' WHERE term = 'Access Modifiers' AND language = 'ro';
UPDATE terms SET term = 'Static vs Instance' WHERE term = 'Static vs Instance Members' AND language = 'ro';
UPDATE terms SET term = 'Compoziție vs Moștenire' WHERE term = 'Composition vs Inheritance' AND language = 'ro';

-- Update HTTP/REST terms
UPDATE terms SET term = 'Cerere și Răspuns HTTP' WHERE term = 'HTTP Request & Response Anatomy' AND language = 'ro';
UPDATE terms SET term = 'Metode HTTP (GET, POST, PUT, PATCH, DELETE)' WHERE term = 'HTTP Methods (GET POST PUT PATCH DELETE)' AND language = 'ro';
UPDATE terms SET term = 'Coduri de Status HTTP' WHERE term = 'HTTP Status Codes' AND language = 'ro';
UPDATE terms SET term = 'PUT vs PATCH (Operații Update)' WHERE term = 'PUT vs PATCH (Update Operations)' AND language = 'ro';
UPDATE terms SET term = 'Idempotență în HTTP' WHERE term = 'Idempotency in HTTP' AND language = 'ro';
UPDATE terms SET term = '401 Unauthorized vs 403 Forbidden' WHERE term = '401 Unauthorized vs 403 Forbidden' AND language = 'ro';
UPDATE terms SET term = 'REST API' WHERE term = 'REST API Principles' AND language = 'ro';
UPDATE terms SET term = 'CRUD' WHERE term = 'CRUD Operations' AND language = 'ro';

-- Update .NET terms
UPDATE terms SET term = 'IEnumerable vs IQueryable' WHERE term = 'IEnumerable vs IQueryable' AND language = 'ro';
UPDATE terms SET term = 'FirstOrDefault vs Single vs SingleOrDefault' WHERE term = 'FirstOrDefault vs Single vs SingleOrDefault' AND language = 'ro';
UPDATE terms SET term = 'Dependency Injection' WHERE term = 'Dependency Injection (DI)' AND language = 'ro';
UPDATE terms SET term = 'Entity Framework Core' WHERE term = 'Entity Framework Core Basics' AND language = 'ro';
UPDATE terms SET term = 'Async/Await' WHERE term = 'Async/Await Pattern' AND language = 'ro';
UPDATE terms SET term = 'LINQ' WHERE term = 'LINQ Queries' AND language = 'ro';

-- Update CS Fundamentals
UPDATE terms SET term = 'Complexitate Big O' WHERE term = 'Big O Notation' AND language = 'ro';
UPDATE terms SET term = 'Array vs Linked List' WHERE term = 'Array vs Linked List' AND language = 'ro';
UPDATE terms SET term = 'Stack vs Queue' WHERE term = 'Stack vs Queue' AND language = 'ro';
UPDATE terms SET term = 'Hash Table' WHERE term = 'Hash Tables' AND language = 'ro';
UPDATE terms SET term = 'Binary Search' WHERE term = 'Binary Search' AND language = 'ro';
UPDATE terms SET term = 'Algoritmi de Sortare' WHERE term = 'Sorting Algorithms' AND language = 'ro';
UPDATE terms SET term = 'Recursie' WHERE term = 'Recursion' AND language = 'ro';

-- Update SQL terms
UPDATE terms SET term = 'SQL JOIN-uri' WHERE term = 'SQL Joins' AND language = 'ro';
UPDATE terms SET term = 'Primary Key vs Foreign Key' WHERE term = 'Primary Key vs Foreign Key' AND language = 'ro';
UPDATE terms SET term = 'Indexuri în SQL' WHERE term = 'Database Indexes' AND language = 'ro';
UPDATE terms SET term = 'Tranzacții SQL' WHERE term = 'SQL Transactions' AND language = 'ro';
UPDATE terms SET term = 'Normalizare Baze de Date' WHERE term = 'Database Normalization' AND language = 'ro';

-- Update JavaScript/TypeScript terms
UPDATE terms SET term = 'Promises și Async/Await' WHERE term = 'Promises and Async Await' AND language = 'ro';
UPDATE terms SET term = 'Callbacks' WHERE term = 'Callback Functions' AND language = 'ro';
UPDATE terms SET term = 'DOM Manipulation' WHERE term = 'DOM Manipulation' AND language = 'ro';
UPDATE terms SET term = 'React Hooks (useState, useEffect)' WHERE term LIKE '%React Hooks%' AND language = 'ro';
UPDATE terms SET term = 'Props vs State în React' WHERE term LIKE '%Props vs State%' AND language = 'ro';
UPDATE terms SET term = 'TypeScript: Tipuri și Interfețe' WHERE term LIKE '%TypeScript Types%' AND language = 'ro';

-- Update Soft Skills terms
UPDATE terms SET term = 'Metoda STAR pentru Interviuri' WHERE term = 'Behavioral Interview Questions' AND language = 'ro';
UPDATE terms SET term = 'Sfaturi Interviu și Fraze de Aur' WHERE term = 'Interview Tips and Golden Phrases' AND language = 'ro';
UPDATE terms SET term = 'Agile și Scrum' WHERE term LIKE '%Agile%Scrum%' AND language = 'ro';

-- Update AI/ML terms
UPDATE terms SET term = 'Clasificare vs Regresie' WHERE term LIKE '%Classification vs Regression%' AND language = 'ro';
UPDATE terms SET term = 'Clustering' WHERE term = 'Clustering' AND language = 'ro';
UPDATE terms SET term = 'Large Language Models (LLMs)' WHERE term LIKE '%LLM%' AND language = 'ro';
UPDATE terms SET term = 'Prompt Engineering' WHERE term = 'Prompt Engineering' AND language = 'ro';

-- Update DevOps terms
UPDATE terms SET term = 'Git: Branch, Merge, Pull Request' WHERE term LIKE '%Git%Branch%' AND language = 'ro';
UPDATE terms SET term = 'CI/CD' WHERE term = 'CI/CD Pipelines' AND language = 'ro';

-- Update Value vs Reference types
UPDATE terms SET term = 'Tipuri Valoare vs Tipuri Referință' WHERE term = 'Value Types vs Reference Types' AND language = 'ro';
UPDATE terms SET term = 'String Immutability' WHERE term = 'String Immutability' AND language = 'ro';
UPDATE terms SET term = 'Garbage Collector' WHERE term = 'Garbage Collector (GC)' AND language = 'ro';

-- Update Design Patterns
UPDATE terms SET term = 'Singleton Pattern' WHERE term = 'Singleton Pattern' AND language = 'ro';
UPDATE terms SET term = 'Factory Pattern' WHERE term = 'Factory Pattern' AND language = 'ro';
UPDATE terms SET term = 'Observer Pattern' WHERE term = 'Observer Pattern' AND language = 'ro';
UPDATE terms SET term = 'Repository Pattern' WHERE term = 'Repository Pattern' AND language = 'ro';
UPDATE terms SET term = 'MVC Pattern' WHERE term = 'MVC (Model-View-Controller)' AND language = 'ro';
UPDATE terms SET term = 'SOLID Principles' WHERE term = 'SOLID Principles' AND language = 'ro';
