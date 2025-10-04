/*
  # Batch 7: JavaScript/TypeScript/React/Angular Comprehensive
  
  Adds missing frontend terms:
  - TypeScript basics
  - interface/type
  - Promise
  - async/await (JS version)
  - React: props vs state
  - React: useEffect
  - React: key prop
  - Angular: Component, Service, DI, HttpClient, directives
  - CORS in dev
*/

DO $$
DECLARE
  cat_angular_id uuid;
BEGIN
  SELECT id INTO cat_angular_id FROM categories WHERE slug = 'angular';

  -- TypeScript
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular_id,
    'TypeScript',
    'TypeScript = JavaScript + types. Adds type checking (string, number, interface) at compile time. Catches errors before runtime. Compiles to regular JavaScript.',
    'TypeScript: statically-typed superset of JavaScript developed by Microsoft. Adds optional type annotations, interfaces, enums, generics. Transpiles to JavaScript. Provides IDE tooling (autocomplete, refactoring). Gradually adoptable.',
    'TypeScript adds type safety to JavaScript. Define types for variables, function parameters, return values. Benefits: (1) Catch errors at compile time, not runtime. (2) Better IDE support (IntelliSense). (3) Self-documenting code. (4) Refactoring confidence. (5) Works with existing JS libraries (@types packages). Compiles to plain JavaScript - runs anywhere JS runs. Interview: explain type inference, any vs unknown, interfaces, when to use TypeScript (large projects, teams), migration from JS.',
    to_jsonb(ARRAY[
      'Using any everywhere (defeats purpose)',
      'Not understanding type inference',
      'Over-typing simple code',
      'Ignoring compiler errors (using // @ts-ignore)',
      'Not using strict mode',
      'Confusing compile-time types with runtime checks'
    ]),
    jsonb_build_object(
      'typescript', '// BASIC TYPES
let name: string = "John";
let age: number = 30;
let isActive: boolean = true;
let items: string[] = ["a", "b", "c"];

// FUNCTION with types
function greet(name: string): string {
    return `Hello, ${name}`;
}

// Type inference
let count = 42; // TypeScript infers: number

// INTERFACE
interface User {
    id: number;
    name: string;
    email: string;
    age?: number; // Optional
}

const user: User = {
    id: 1,
    name: "John",
    email: "john@example.com"
};

// TYPE ALIAS
type ID = number | string;
type Status = "pending" | "active" | "inactive"; // Union

// GENERICS
function identity<T>(value: T): T {
    return value;
}

const num = identity<number>(42);
const str = identity<string>("hello");

// ANY vs UNKNOWN
let anything: any = "hello";
anything.toUpperCase(); // OK (dangerous!)

let something: unknown = "hello";
// something.toUpperCase(); // ERROR
if (typeof something === "string") {
    something.toUpperCase(); // OK (type guard)
}

// TYPE ASSERTION
let value: unknown = "hello";
let length: number = (value as string).length;

// NEVER (function never returns)
function throwError(message: string): never {
    throw new Error(message);
}

// Compiles to JavaScript:
// tsc app.ts → app.js (types removed)',
      'csharp', '// C# comparison
// TypeScript interface ~ C# interface
interface User {
    id: number;
    name: string;
}

// C# equivalent
public interface IUser {
    int Id { get; }
    string Name { get; }
}

// TypeScript union types
type Status = "active" | "inactive";

// C# enum
public enum Status {
    Active,
    Inactive
}'
    ),
    'TypeScript:

JavaScript:
let user = { name: "John" };
user.age = 30; // OK (no type checking)
user.toUpperCase(); // Runtime error!

TypeScript:
interface User {
    name: string;
}
let user: User = { name: "John" };
user.age = 30; // Compile error! ✓
user.toUpperCase(); // Compile error! ✓

Benefits:
✓ Catch errors early
✓ IDE autocomplete
✓ Self-documenting
✓ Refactoring safety

Compiles to JS:
.ts → TypeScript Compiler → .js

TypeScript       JavaScript
string      →    (removed)
number      →    (removed)
interface   →    (removed)

Runs in browser/Node as normal JS',
    50
  ) ON CONFLICT DO NOTHING;

  -- interface/type
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular_id,
    'interface / type',
    'interface and type both define shapes of objects. interface User { name: string }. Use for contracts, type checking. Slight differences: interface can extend, type can do unions. Generally prefer interface for objects.',
    'interface: TypeScript construct defining object shape, can extend other interfaces, declaration merging. type: type alias for any type (primitive, union, intersection, object). Both used for type checking, similar for object shapes, differences in capabilities.',
    'Both define object shapes but have nuances. interface: keyword for object contracts, can extend (interface Admin extends User), supports declaration merging (multiple declarations combine). type: more flexible, supports unions (string | number), intersections (User & Admin), primitives, tuples. For objects, prefer interface (more readable, better error messages). Use type for unions, intersections, mapped types. Interview: explain both, when to use each, that they are compile-time only (removed in JS), structural typing (duck typing).',
    to_jsonb(ARRAY[
      'Not knowing when to use interface vs type',
      'Using type for everything',
      'Not understanding structural typing',
      'Forgetting types are compile-time only',
      'Over-complicating with complex types',
      'Not using utility types (Partial, Pick, Omit)'
    ]),
    jsonb_build_object(
      'typescript', '// INTERFACE
interface User {
    id: number;
    name: string;
    email: string;
}

// Extending interface
interface Admin extends User {
    role: string;
    permissions: string[];
}

const admin: Admin = {
    id: 1,
    name: "Alice",
    email: "alice@example.com",
    role: "admin",
    permissions: ["read", "write"]
};

// Declaration merging (unique to interface)
interface User {
    age?: number; // Adds to User
}

// TYPE ALIAS
type ID = number | string; // Union

type Point = {
    x: number;
    y: number;
};

// Type can do unions
type Status = "active" | "inactive" | "pending";

// Intersection (combine types)
type AdminUser = User & { role: string };

// TYPE for functions
type MathFunc = (a: number, b: number) => number;
const add: MathFunc = (a, b) => a + b;

// UTILITY TYPES
interface User {
    id: number;
    name: string;
    email: string;
    password: string;
}

// Partial - all properties optional
type PartialUser = Partial<User>;

// Pick - select properties
type UserBasic = Pick<User, "id" | "name">;

// Omit - exclude properties
type UserPublic = Omit<User, "password">;

// Readonly
type ReadonlyUser = Readonly<User>;

// WHEN TO USE:
// interface: object shapes, extending, public API
// type: unions, intersections, primitives, tuples',
      'csharp', '// C# interface (similar concept)
public interface IUser {
    int Id { get; }
    string Name { get; }
    string Email { get; }
}

// Inheritance
public interface IAdmin : IUser {
    string Role { get; }
    List<string> Permissions { get; }
}

// C# does not have type aliases like TS
// Use actual types or class inheritance'
    ),
    'interface vs type:

INTERFACE:
interface User {
    id: number;
    name: string;
}

✓ Extends other interfaces
✓ Declaration merging
✓ Better error messages
→ Use for object shapes

interface Admin extends User {
    role: string;
}

TYPE:
type ID = number | string;

type User = {
    id: ID;
    name: string;
};

✓ Unions (A | B)
✓ Intersections (A & B)
✓ Primitives, tuples
→ Use for complex types

type Status = "active" | "inactive";
type Point = [number, number];

Both compile away:
No runtime cost',
    51
  ) ON CONFLICT DO NOTHING;

  -- Promise
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular_id,
    'Promise',
    'Promise = represents future value. Async operation that will complete later. States: pending (waiting), fulfilled (success), rejected (error). Use .then() for success, .catch() for errors.',
    'Promise: JavaScript object representing eventual completion or failure of asynchronous operation. Three states: pending, fulfilled, rejected. Provides .then() for success callbacks, .catch() for error handling, .finally() for cleanup. Chainable. Replaced callback hell.',
    'Promise handles async operations without blocking. Create with new Promise((resolve, reject) => ...). Call resolve(value) on success, reject(error) on failure. Consume with .then(value => ...).catch(error => ...). Benefits: (1) Avoids callback hell. (2) Chainable. (3) Error propagation. (4) Better than nested callbacks. Modern approach: async/await syntax sugar over promises. Common use: fetch API, file I/O, timers. Interview: explain states, how to create, how to consume, error handling, Promise.all vs Promise.race, relationship with async/await.',
    to_jsonb(ARRAY[
      'Not handling rejections (.catch missing)',
      'Creating unnecessary promises (promisification)',
      'Not understanding promise chaining',
      'Mixing promises and callbacks',
      'Forgetting promises execute immediately',
      'Not using Promise.all for parallel operations'
    ]),
    jsonb_build_object(
      'typescript', '// CREATING PROMISE
function fetchUser(id: number): Promise<User> {
    return new Promise((resolve, reject) => {
        // Async operation
        setTimeout(() => {
            if (id > 0) {
                resolve({ id, name: "John" }); // Success
            } else {
                reject(new Error("Invalid ID")); // Failure
            }
        }, 1000);
    });
}

// CONSUMING PROMISE
fetchUser(1)
    .then(user => {
        console.log(user.name); // Success
        return user.id;
    })
    .then(id => {
        console.log(`ID: ${id}`);
    })
    .catch(error => {
        console.error(error); // Error
    })
    .finally(() => {
        console.log("Done"); // Always runs
    });

// PROMISE STATES
const promise = fetchUser(1);
// State: pending → fulfilled or rejected

// PROMISE UTILITIES

// All - waits for all to complete
Promise.all([
    fetchUser(1),
    fetchUser(2),
    fetchUser(3)
]).then(users => {
    console.log(users); // Array of all results
}).catch(error => {
    // If ANY fails, catch triggers
});

// Race - first to complete wins
Promise.race([
    fetchUser(1),
    fetchUser(2)
]).then(user => {
    console.log(user); // First one
});

// AllSettled - waits for all (success or fail)
Promise.allSettled([
    fetchUser(1),
    fetchUser(-1)
]).then(results => {
    results.forEach(result => {
        if (result.status === "fulfilled") {
            console.log(result.value);
        } else {
            console.log(result.reason);
        }
    });
});

// FETCH API (returns Promise)
fetch("https://api.example.com/users")
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error(error));',
      'csharp', '// C# Task is similar to JS Promise
Task<User> FetchUserAsync(int id) {
    return Task.Run(() => {
        Thread.Sleep(1000);
        if (id > 0) {
            return new User { Id = id, Name = "John" };
        }
        throw new Exception("Invalid ID");
    });
}

// Consuming
FetchUserAsync(1)
    .ContinueWith(task => {
        if (task.IsCompletedSuccessfully) {
            Console.WriteLine(task.Result.Name);
        }
    });

// Or with async/await
var user = await FetchUserAsync(1);'
    ),
    'Promise States:

PENDING (waiting):
const promise = fetchData();
// Operation in progress...

↓ (success)
FULFILLED (resolved):
promise.then(data => {
    console.log(data); ✓
});

↓ (failure)
REJECTED (error):
promise.catch(error => {
    console.error(error); ✗
});

ALWAYS:
promise.finally(() => {
    // Cleanup
});

Promise Chain:
fetch(url)
    .then(response => response.json())
    .then(data => processData(data))
    .then(result => display(result))
    .catch(error => handleError(error))
    .finally(() => cleanup());

Each .then returns new Promise
→ Chainable',
    52
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Added Batch 7 part 1: JS/TS basics (3 terms)';
END $$;
