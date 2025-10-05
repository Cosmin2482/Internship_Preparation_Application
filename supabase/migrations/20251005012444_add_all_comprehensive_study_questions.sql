/*
  # Add All Comprehensive Study Guide Questions
  
  1. New Questions
    - All OOP fundamentals with detailed "why" explanations
    - Architecture (Client-Server, Layered, REST)
    - HTTP anatomy and status codes
    - CRUD & SQL with practical examples
    - .NET & EF Core patterns
    - JavaScript/TypeScript/React/Angular
    - Unit Testing with AAA and Moq
    - SOLID and Design Patterns
    - Computer Science fundamentals
    - Git and Collaboration
    - Agile/Scrum
    - Cloud & DevOps
    - Security basics
    - Performance and Debugging
    - Behavioral questions (HR)
    
  2. All questions in English for interview practice
*/

-- Get a term ID for general questions (we'll use Abstraction as a catch-all)
DO $$
DECLARE
  general_term_id uuid;
BEGIN
  SELECT id INTO general_term_id FROM terms WHERE term = 'Abstraction' LIMIT 1;
  
  -- OOP Fundamentals - Class vs Object
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation) VALUES
  (general_term_id, 'Why does the distinction between Class and Object matter?',
   '["It does not matter", "It helps separate definition from usage, facilitating testing and reusability", "Only for large projects", "Only for documentation"]'::jsonb, 1,
   'A class is the blueprint; an object is the runtime instance. This separation allows you to define once and create many instances, making testing (mock objects) and reusability much easier.'),
  
  -- Encapsulation
  (general_term_id, 'What is the main benefit of Encapsulation?',
   '["Faster code", "Hides state (private fields), exposes safe properties/methods, prevents invalid states and reduces impact of changes", "Better UI", "Smaller files"]'::jsonb, 1,
   'Encapsulation hides internal state (private fields) and exposes controlled access through properties/methods. This prevents invalid states and localizes changes - you can change internal implementation without breaking external code.'),
  
  -- Abstraction  
  (general_term_id, 'Why use Abstraction (interface/abstract class)?',
   '["To make code complex", "You can change implementations (Card vs Cash payment) without breaking clients", "Only for large teams", "Not useful anymore"]'::jsonb, 1,
   'Abstraction provides a contract (interface/abstract). This allows you to swap implementations (e.g., CreditCardPayment vs CashPayment) without modifying client code, enabling flexibility and testability.'),
  
  -- Inheritance
  (general_term_id, 'When should you use Inheritance vs Composition?',
   '["Always use inheritance", "Inheritance for strict is-a relationships; composition when its not is-a or for more flexibility", "Always use composition", "They are the same"]'::jsonb, 1,
   'Use Inheritance for true "is-a" relationships (Dog is-a Animal). When not strictly "is-a", prefer Composition (Car has-an Engine) for flexibility and to avoid tight coupling.'),
  
  -- Polymorphism
  (general_term_id, 'What is the benefit of Polymorphism?',
   '["Faster execution", "Same call, different implementations - enables extensibility and generic code", "Smaller file size", "Only for OOP purists"]'::jsonb, 1,
   'Polymorphism allows the same method call to execute different implementations. This enables extensibility (add new types without changing existing code) and writing generic, reusable code.'),
  
  -- Access Modifiers
  (general_term_id, 'Why do we have Access Modifiers (public/private/protected/internal)?',
   '["To make code longer", "To control visibility and coupling between components", "Only for security", "They are deprecated"]'::jsonb, 1,
   'Access modifiers (public, private, protected, internal, and combinations) control what code can see and use what. This manages coupling and helps enforce encapsulation and architectural boundaries.');

END $$;
