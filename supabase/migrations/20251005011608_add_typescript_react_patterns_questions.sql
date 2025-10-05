/*
  # Add TypeScript, React, Angular, and Design Pattern Questions
  
  1. TypeScript
    - Type system basics
    - Union/Intersection types
    - Utility types (Partial, Pick)
    
  2. React
    - Props vs State
    - useEffect dependencies
    - Key prop in lists
    
  3. Angular
    - Components vs Services
    - Dependency Injection
    - Observables
    
  4. Design Patterns
    - Repository, Factory, Strategy, Observer, Adapter
*/

-- TypeScript Basics
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the benefit of TypeScript over JavaScript?',
  '["Faster execution", "Static typing catches errors at compile-time before runtime", "Smaller bundle size", "No benefit"]'::jsonb,
  1,
  'TypeScript adds static typing to JavaScript, catching type errors during development (compile-time) rather than at runtime. This reduces bugs, improves IDE support (autocomplete), and makes refactoring safer.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does the Union type (A | B) mean in TypeScript?',
  '["Both A and B", "Value can be either type A OR type B", "Combination of A and B properties", "A inherits from B"]'::jsonb,
  1,
  'Union type (A | B) means the value can be of type A OR type B. You can only access properties common to both until you narrow the type with type guards (typeof, instanceof).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does Partial<T> do in TypeScript?',
  '["Makes T abstract", "Makes all properties of T optional", "Removes properties from T", "Makes T readonly"]'::jsonb,
  1,
  'Partial<T> is a utility type that makes all properties of type T optional. Useful for update operations where you only provide the fields to change. Example: Partial<User> allows {name?: string, age?: number}.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- React Fundamentals
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between Props and State in React?',
  '["No difference", "Props are passed from parent (immutable from child); State is managed internally (mutable)", "Props are faster", "State is deprecated"]'::jsonb,
  1,
  'Props are data passed from parent components and are immutable (read-only) from the child perspective. State is data managed within a component and can be updated using setState/useState.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What does the dependency array in useEffect control?',
  '["Nothing", "When the effect runs: [] runs once, [var] runs when var changes, no array runs every render", "Performance only", "Type checking"]'::jsonb,
  1,
  'The dependency array controls when useEffect runs. Empty [] means run once after mount. [var] means run when var changes. No array means run after every render (usually wrong).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why is the key prop required when rendering lists in React?',
  '["For styling", "To help React identify which items changed/added/removed for efficient DOM updates", "For security", "It is optional"]'::jsonb,
  1,
  'The key prop helps React identify which items in a list have changed, been added, or removed. This enables efficient DOM updates by reusing existing elements. Use stable, unique identifiers (not array index if order changes).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Angular Fundamentals
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between a Component and a Service in Angular?',
  '["No difference", "Components handle UI/templates; Services contain business logic and are reusable across components", "Services are deprecated", "Components are only for routing"]'::jsonb,
  1,
  'Components are building blocks of UI (template + logic). Services contain reusable business logic (data access, state management) that can be injected into multiple components via Dependency Injection.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'How does Dependency Injection work in Angular?',
  '["Manually creating instances", "Services are injected via constructor; Angular DI container manages lifecycle", "Only for large apps", "Through global variables"]'::jsonb,
  1,
  'Angular has a built-in DI container. You define services with @Injectable(), then inject them via constructor parameters. Angular creates and manages instances, enabling testability and loose coupling.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What are Observables in Angular and why use them?',
  '["Old JavaScript feature", "Reactive streams for handling async data (HTTP, events); support operators for transformation", "Only for animations", "Promises replacement"]'::jsonb,
  1,
  'Observables (from RxJS) represent streams of async data. Unlike Promises (single value), Observables emit multiple values over time. They support powerful operators (map, filter, debounce) for data transformation.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Design Patterns - Repository
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the Repository pattern and when is it useful?',
  '["A database", "Abstracts data access layer; enables testing with mocks and swapping data sources", "Only for large databases", "Deprecated in 2025"]'::jsonb,
  1,
  'Repository pattern abstracts data access logic behind an interface. This enables unit testing (inject mock repos), swapping data sources (SQL to NoSQL), and cleaner domain layer. Some argue EF Core DbContext is already a repository.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Design Patterns - Factory
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why use a Factory pattern instead of new everywhere?',
  '["Factories are faster", "Decouples object creation from usage; allows changing implementations without modifying client code", "new is deprecated", "Only for large objects"]'::jsonb,
  1,
  'Factory pattern centralizes object creation. Client code does not use new directly, so you can change which implementation is created (SqlConnection vs AzureConnection) without modifying clients. Useful for DI.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Design Patterns - Strategy
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What problem does the Strategy pattern solve?',
  '["Database access", "Allows selecting and swapping algorithms at runtime via interface injection", "Only for sorting", "Performance optimization"]'::jsonb,
  1,
  'Strategy pattern defines a family of interchangeable algorithms (strategies) behind an interface. You can inject different strategies at runtime (CreditCardPayment, PayPalPayment, CashPayment) without changing client code.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Design Patterns - Observer
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the Observer pattern used for?',
  '["Debugging", "Notifying multiple objects (observers) when another object (subject) changes state", "Database queries", "Only for UI"]'::jsonb,
  1,
  'Observer pattern allows multiple observers to subscribe to a subject. When the subject changes state, all observers are automatically notified. Common in event systems (C# events, JavaScript EventEmitter).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Design Patterns - Adapter
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When would you use the Adapter pattern?',
  '["To adapt screen sizes", "To integrate incompatible interfaces (wrap external library to match your interface)", "Only for hardware", "To improve performance"]'::jsonb,
  1,
  'Adapter pattern converts the interface of one class to match the interface your code expects. Useful when integrating external libraries or legacy code without modifying them or your existing code.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Composition vs Inheritance
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why is composition often preferred over inheritance?',
  '["Inheritance is deprecated", "Composition provides more flexibility and avoids tight coupling; use inheritance only for strict is-a relationships", "Composition is faster", "No difference"]'::jsonb,
  1,
  'Composition (has-a) is more flexible than inheritance (is-a). It avoids tight coupling and the fragile base class problem. Use inheritance for strict is-a relationships; use composition for has-a or to combine behaviors.'
FROM terms WHERE term = 'Inheritance' LIMIT 1;

-- Promises vs async/await
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the main advantage of async/await over Promises?',
  '["Faster execution", "Cleaner syntax that looks like synchronous code; easier error handling with try/catch", "Promises are deprecated", "No advantage"]'::jsonb,
  1,
  'async/await is syntactic sugar over Promises. It makes async code look synchronous, improving readability. Error handling is simpler with try/catch instead of .catch(). Both compile to the same underlying mechanism.'
FROM terms WHERE term = 'async/await' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'How do you handle errors with async/await?',
  '["Errors cannot be caught", "Wrap in try/catch block; rejected promises throw exceptions", "Use .catch()", "Errors are automatic"]'::jsonb,
  1,
  'With async/await, use try/catch blocks. Rejected promises throw exceptions that can be caught. Without try/catch, unhandled rejections propagate and can crash Node.js or create browser warnings.'
FROM terms WHERE term = 'async/await' LIMIT 1;
