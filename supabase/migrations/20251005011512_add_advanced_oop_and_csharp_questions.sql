/*
  # Add Advanced OOP and C# Specific Questions
  
  1. Advanced OOP Questions
    - virtual/override/new mechanics
    - abstract class vs interface
    - readonly vs const
    - record vs class
    - generics and constraints
    
  2. C# Specific
    - IDisposable and using
    - Exception handling best practices
    - Fields vs Properties
    - Access modifiers
*/

-- Advanced OOP - virtual/override/new
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Given: Animal a = new Cat(); where Cat uses new instead of override. What does a.Speak() call?',
  '["Cat.Speak()", "Animal.Speak() because new hides the method and binding is to reference type", "Compilation error", "Runtime error"]'::jsonb,
  1,
  'When using new (method hiding), binding is at compile-time based on the reference type (Animal), not the actual object type (Cat). So Animal.Speak() is called. This is why override is preferred for polymorphism.'
FROM terms WHERE term = 'Polymorphism' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the main advantage of abstract class over interface?',
  '["No advantage", "Abstract class can have implementation (common code) and state (fields); interface is pure contract", "Abstract class is faster", "Interfaces are deprecated"]'::jsonb,
  1,
  'Abstract classes can contain both abstract members (contract) and concrete implementations with state (fields). This is useful for sharing common code in a hierarchy. Interfaces define pure contracts.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you use interface over abstract class?',
  '["Never", "When you need multiple inheritance (a class can implement many interfaces) or defining plugin capabilities", "Only for small projects", "Interfaces are slower"]'::jsonb,
  1,
  'Use interfaces when you need multiple inheritance (a class can implement many interfaces but inherit from only one class) or when defining capabilities/contracts that unrelated classes can implement.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- C# Specifics - readonly vs const
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between readonly and const in C#?',
  '["No difference", "const is compile-time constant; readonly can be set in constructor at runtime", "readonly is faster", "const is deprecated"]'::jsonb,
  1,
  'const values must be set at compile-time and are static. readonly values can be set at declaration or in the constructor, allowing runtime initialization. Use const for true constants, readonly for per-instance immutability.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

-- Generics
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why do Generics improve performance over using object?',
  '["They dont", "Generics avoid boxing/unboxing for value types and provide type safety at compile-time", "Generics use less memory", "They are faster to write"]'::jsonb,
  1,
  'Generics (List<int>) avoid boxing/unboxing that occurs with object (List storing int as object). They also provide compile-time type checking, catching errors early instead of at runtime.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does the constraint where T : new() mean?',
  '["T must be new", "T must have a parameterless constructor so you can create instances with new T()", "T must be a new type", "T cannot be instantiated"]'::jsonb,
  1,
  'The where T : new() constraint requires that the type parameter T has a public parameterless constructor. This allows you to create new instances inside the generic class/method using new T().'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

-- IDisposable
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the purpose of IDisposable and using?',
  '["For garbage collection", "To release unmanaged resources (files, DB connections) deterministically; using ensures Dispose() is called", "Only for security", "To improve performance"]'::jsonb,
  1,
  'IDisposable provides a pattern to release unmanaged resources (not handled by GC) like file handles, DB connections, network streams. The using statement ensures Dispose() is called even if an exception occurs.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

-- Exception Handling
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you throw an exception?',
  '["Always for validation", "When a class cannot fulfill its contract (invalid input, resource unavailable); not for control flow", "Never throw exceptions", "Only in production"]'::jsonb,
  1,
  'Throw exceptions when a method cannot fulfill its contract: invalid input that violates preconditions, unavailable resources, unexpected states. Do not use exceptions for normal control flow (they are expensive).'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Where should you catch and log exceptions?',
  '["In every method", "At the highest level where you can handle them meaningfully (e.g., API controller) with full context and stack trace", "Never log exceptions", "Only in development"]'::jsonb,
  1,
  'Catch exceptions at the level where you can handle them meaningfully. In APIs, this is typically at the controller/middleware level where you can log with full context, transform to user-friendly messages, and return appropriate HTTP status codes.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

-- Fields vs Properties
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the advantage of Properties over public Fields?',
  '["No advantage", "Properties allow validation, computed values, and can change implementation without breaking callers", "Properties are faster", "Fields are deprecated"]'::jsonb,
  1,
  'Properties look like fields but are actually methods. This allows you to add validation, compute values, or change from stored to computed without breaking code that uses the property. Fields provide no such protection.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

-- Access Modifiers
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does protected internal mean in C#?',
  '["Same as protected", "Accessible in same assembly OR in derived classes (even from other assemblies)", "Only for internal classes", "Compilation error"]'::jsonb,
  1,
  'protected internal is a combination: accessible within the same assembly (internal) OR from derived classes in any assembly (protected). It is the union of both access levels.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does private protected mean in C#?',
  '["Same as private", "Accessible only in same assembly AND only in derived classes (intersection)", "Does not exist", "Same as protected"]'::jsonb,
  1,
  'private protected (introduced in C# 7.2) is the intersection: accessible only within the same assembly AND only in derived classes. More restrictive than either private or protected alone.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;

-- sealed keyword
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the purpose of the sealed keyword?',
  '["To seal packages", "To prevent inheritance of a class or overriding of a method, enabling optimizations", "Only for security", "To make classes immutable"]'::jsonb,
  1,
  'sealed prevents further inheritance (sealed class) or further overriding (sealed override). This provides a final contract and enables compiler optimizations (devirtualization). Use when you want to prevent extension.'
FROM terms WHERE term = 'Inheritance' LIMIT 1;

-- record vs class
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the main difference between record and class in C#?',
  '["No difference", "Records have structural equality (value-based) and are optimized for immutability; classes have reference equality", "Records are faster", "Classes are deprecated"]'::jsonb,
  1,
  'Records use value-based equality (two records with same data are equal). Classes use reference equality (two objects with same data are not equal unless same reference). Records are optimized for DTOs and immutable data.'
FROM terms WHERE term = 'Encapsulation' LIMIT 1;
