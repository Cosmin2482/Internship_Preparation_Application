/*
  # Add Detailed C# OOP Questions
  
  Comprehensive C# specific OOP questions with "why" explanations
*/

DO $$
DECLARE
  general_term_id uuid;
BEGIN
  SELECT id INTO general_term_id FROM terms WHERE term = 'Abstraction' LIMIT 1;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation) VALUES
  
  -- Fields vs Properties
  (general_term_id, 'Why use Properties instead of public Fields?',
   '["No difference", "Properties allow validation, change notifications, and partial immutability without breaking callers", "Properties are just syntax sugar", "Fields are deprecated"]'::jsonb, 1,
   'Properties provide controlled access. You can add validation (age >= 0), notifications (INotifyPropertyChanged), or change from stored to computed value without breaking code that uses the property.'),
  
  -- readonly vs const
  (general_term_id, 'What is the key difference between readonly and const?',
   '["No difference", "const is compile-time; readonly can be set in constructor at runtime", "readonly is faster", "const is deprecated"]'::jsonb, 1,
   'const values must be known at compile-time and are implicitly static. readonly can be set at runtime in the constructor, allowing per-instance immutability. Use const for true constants (PI = 3.14), readonly for immutable instance data.'),
  
  -- virtual/override/new - THE KEY QUESTION
  (general_term_id, 'Why do we have both override and new keywords in C#?',
   '["Historical accident", "override enables real polymorphism (runtime binding); new provides hiding (compile-time binding) for compatibility and control", "new is deprecated", "They do the same thing"]'::jsonb, 1,
   'override uses v-table for dynamic dispatch (real polymorphism). new hides the base method with static binding to reference type. Two mechanisms exist for compatibility (when you cannot modify base) and control over extensibility. Always prefer override for polymorphism.'),
  
  -- The Cat example
  (general_term_id, 'Given Animal a = new Cat() where Cat uses new instead of override for Speak(), what is called?',
   '["Cat.Speak()", "Animal.Speak() because new hides the method - binding is to reference type, not object type", "Compiler error", "Runtime error"]'::jsonb, 1,
   'With new (hiding), binding happens at compile-time based on the reference type (Animal), not the actual object type (Cat). So Animal.Speak() is called. This demonstrates why override (runtime binding) is preferred for polymorphism.'),
  
  -- abstract vs interface
  (general_term_id, 'When to use abstract class vs interface?',
   '["Always use interfaces", "Abstract class for coherent hierarchies with shared code; interface for pure contracts and multiple inheritance", "They are identical", "Abstract classes are deprecated"]'::jsonb, 1,
   'Abstract class can have common code + state (fields), supports single inheritance - good for coherent hierarchies. Interface is pure contract, supports multiple inheritance - good for plugins and capabilities (IDisposable, IComparable).'),
  
  -- sealed
  (general_term_id, 'What is the purpose of sealed keyword?',
   '["To seal envelopes", "Prevents further inheritance (class) or overriding (method), enables optimizations and final contracts", "Only for security", "Makes code slower"]'::jsonb, 1,
   'sealed prevents inheritance of a class or further overriding of a method. This provides a final contract and enables compiler optimizations (devirtualization). Use when you want to prevent extension for design or performance reasons.'),
  
  -- Generics
  (general_term_id, 'Why do Generics increase both safety and performance?',
   '["They do not", "Type safety at compile-time prevents casting errors; avoids boxing/unboxing for value types", "Only safety, not performance", "Only for collections"]'::jsonb, 1,
   'Generics provide compile-time type checking (List<int> cannot accept string), preventing InvalidCastException. They also avoid boxing/unboxing when storing value types (int stored as int, not as object), significantly improving performance.'),
  
  -- Exceptions
  (general_term_id, 'When should you throw exceptions?',
   '["For all validations", "When a class cannot fulfill its contract - signal exceptional conditions, not normal control flow", "Never throw exceptions", "Only in development"]'::jsonb, 1,
   'Throw exceptions when a method cannot fulfill its contract: invalid preconditions, unavailable resources, unexpected states. Do NOT use exceptions for normal control flow (they are expensive). Use return values or Result types for expected failures.'),
  
  -- IDisposable
  (general_term_id, 'What is IDisposable and using used for?',
   '["Memory management", "Releasing unmanaged resources (files, DB connections, streams) deterministically; using ensures Dispose() is called", "Only for performance", "Deprecated pattern"]'::jsonb, 1,
   'IDisposable provides a pattern to release unmanaged resources (not handled by GC) like file handles, database connections, network sockets. The using statement ensures Dispose() is called even if exceptions occur, preventing resource leaks.'),
  
  -- async/await
  (general_term_id, 'What problem does async/await solve?',
   '["Makes code parallel", "Frees threads during I/O operations (network, DB, files) improving scalability without blocking", "Speeds up CPU-bound tasks", "Only for UI responsiveness"]'::jsonb, 1,
   'async/await allows threads to be released during I/O operations instead of blocking. The thread can handle other requests while waiting for network/DB/file operations. This dramatically improves scalability in servers. Does NOT help with CPU-bound work.');

END $$;
