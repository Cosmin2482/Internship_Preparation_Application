/*
  # Batch 7 Part 2: React and Angular Details
  
  Adds: async/await (JS), React props/state, useEffect, key, Angular basics
*/

DO $$
DECLARE
  cat_angular_id uuid;
BEGIN
  SELECT id INTO cat_angular_id FROM categories WHERE slug = 'angular';

  -- async/await (JavaScript version)
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular_id,
    'async / await (JavaScript)',
    'async/await = cleaner syntax for Promises. async function returns Promise. await pauses function until Promise resolves. Looks like synchronous code but is asynchronous.',
    'async/await: ES2017 syntactic sugar over Promises. async function always returns Promise. await keyword pauses execution until Promise resolves, extracts value. Error handling via try-catch. Makes async code read like sync code.',
    'Modern way to work with Promises. Mark function with async keyword - it automatically returns Promise. Inside async function, use await before Promise - pauses execution, waits for result, extracts value (no .then needed). Error handling: try-catch instead of .catch(). Benefits: (1) Readable - looks synchronous. (2) Easier debugging. (3) Better error handling. (4) Works with Promise utilities. Under the hood: still Promises, just nicer syntax. Common use: fetch, database calls, file operations. Interview: explain async returns Promise, await only in async functions, error handling, difference from .then, top-level await (ES2022).',
    to_jsonb(ARRAY[
      'Using await outside async function',
      'Not handling errors (no try-catch)',
      'Awaiting in loops (slow - should use Promise.all)',
      'Forgetting async function returns Promise',
      'Not understanding await pauses function, not thread',
      'Mixing .then and await unnecessarily'
    ]),
    jsonb_build_object(
      'typescript', '// ASYNC FUNCTION
async function fetchUser(id: number): Promise<User> {
    // Simulate API call
    const response = await fetch(`/api/users/${id}`);
    
    if (!response.ok) {
        throw new Error("Failed to fetch");
    }
    
    const user: User = await response.json();
    return user; // Automatically wrapped in Promise
}

// CALLING ASYNC FUNCTION
async function displayUser() {
    try {
        const user = await fetchUser(1);
        console.log(user.name);
    } catch (error) {
        console.error("Error:", error);
    }
}

// MULTIPLE ASYNC OPERATIONS

// ✗ BAD (sequential - slow)
async function getBoth() {
    const user = await fetchUser(1); // Wait
    const posts = await fetchPosts(1); // Then wait
    return { user, posts };
}

// ✓ GOOD (parallel - fast)
async function getBothFast() {
    const [user, posts] = await Promise.all([
        fetchUser(1),
        fetchPosts(1)
    ]); // Both run concurrently
    return { user, posts };
}

// ERROR HANDLING
async function safeOperation() {
    try {
        const result = await riskyOperation();
        return result;
    } catch (error) {
        console.error("Operation failed:", error);
        return null;
    } finally {
        console.log("Cleanup");
    }
}

// ASYNC/AWAIT vs PROMISES
// With Promises:
fetchUser(1)
    .then(user => {
        return fetchPosts(user.id);
    })
    .then(posts => {
        console.log(posts);
    })
    .catch(error => {
        console.error(error);
    });

// With async/await:
async function example() {
    try {
        const user = await fetchUser(1);
        const posts = await fetchPosts(user.id);
        console.log(posts);
    } catch (error) {
        console.error(error);
    }
}

// TOP-LEVEL AWAIT (ES2022, modules only)
// No need for async wrapper
const user = await fetchUser(1);
console.log(user);',
      'csharp', '// C# async/await (similar)
public async Task<User> FetchUserAsync(int id) {
    using var client = new HttpClient();
    var response = await client.GetAsync($"/api/users/{id}");
    response.EnsureSuccessStatusCode();
    
    var json = await response.Content.ReadAsStringAsync();
    return JsonSerializer.Deserialize<User>(json);
}

// Calling
public async Task DisplayUserAsync() {
    try {
        var user = await FetchUserAsync(1);
        Console.WriteLine(user.Name);
    } catch (Exception ex) {
        Console.WriteLine($"Error: {ex.Message}");
    }
}'
    ),
    'async/await:

Promise syntax:
fetchUser(1)
    .then(user => {
        return fetchPosts(user.id);
    })
    .then(posts => {
        console.log(posts);
    })
    .catch(error => {
        console.error(error);
    });

async/await syntax:
async function example() {
    try {
        const user = await fetchUser(1);
        const posts = await fetchPosts(user.id);
        console.log(posts);
    } catch (error) {
        console.error(error);
    }
}

How it works:
async function getData() {
    const data = await fetch(url);
                 ↑
    Function pauses here
    (does not block thread)
    Waits for Promise to resolve
    Extracts value from Promise
                 ↓
    return data;
}

Key points:
✓ async returns Promise
✓ await only in async
✓ Pauses function, not thread
✓ Use try-catch for errors',
    53
  ) ON CONFLICT DO NOTHING;

  -- React: props vs state
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular_id,
    'React: props vs state',
    'props = inputs passed to component (like function params). Read-only. state = internal mutable data. Component can change its own state. props flow down, state lives in component.',
    'props: immutable data passed from parent to child component, read-only in receiving component. state: mutable data managed within component, changes trigger re-render. props for communication down tree, state for interactive/changing data within component.',
    'Core React concept. props (properties) are how parent passes data to child, like function arguments. Child receives props, cannot modify them. Parent controls props. state is internal component data that can change. Changes trigger re-render. Use state for: user input, fetched data, UI toggles. Use props for: passing data down, component configuration, callbacks. Interview: explain immutability of props, when state changes component re-renders, lifting state up (move state to parent when multiple children need it), one-way data flow (data down, events up).',
    to_jsonb(ARRAY[
      'Mutating props (never do this)',
      'Too much state (lift up when shared)',
      'Not understanding props are immutable',
      'State in wrong component (should be lifted)',
      'Prop drilling (passing props through many levels)',
      'Not using callbacks to communicate up'
    ]),
    jsonb_build_object(
      'typescript', '// PROPS (parent to child)
interface UserCardProps {
    name: string;
    email: string;
    onDelete: () => void;
}

function UserCard({ name, email, onDelete }: UserCardProps) {
    // props are read-only
    // name = "Changed"; // ERROR
    
    return (
        <div>
            <h3>{name}</h3>
            <p>{email}</p>
            <button onClick={onDelete}>Delete</button>
        </div>
    );
}

// Parent passes props
function UserList() {
    return (
        <div>
            <UserCard 
                name="John" 
                email="john@example.com"
                onDelete={() => console.log("Delete")}
            />
        </div>
    );
}

// STATE (internal mutable data)
function Counter() {
    const [count, setCount] = useState(0); // state
    
    function increment() {
        setCount(count + 1); // Change state → re-render
    }
    
    return (
        <div>
            <p>Count: {count}</p>
            <button onClick={increment}>+</button>
        </div>
    );
}

// COMBINING PROPS AND STATE
interface TodoListProps {
    initialTodos: string[]; // props from parent
}

function TodoList({ initialTodos }: TodoListProps) {
    const [todos, setTodos] = useState(initialTodos); // internal state
    const [input, setInput] = useState("");
    
    function addTodo() {
        setTodos([...todos, input]);
        setInput("");
    }
    
    return (
        <div>
            <input 
                value={input} 
                onChange={e => setInput(e.target.value)} 
            />
            <button onClick={addTodo}>Add</button>
            <ul>
                {todos.map((todo, i) => <li key={i}>{todo}</li>)}
            </ul>
        </div>
    );
}

// LIFTING STATE UP
function Parent() {
    const [count, setCount] = useState(0); // State in parent
    
    return (
        <div>
            <Display count={count} />  {/* Pass as props */}
            <Button onClick={() => setCount(count + 1)} />
        </div>
    );
}

function Display({ count }: { count: number }) {
    return <p>Count: {count}</p>;
}

function Button({ onClick }: { onClick: () => void }) {
    return <button onClick={onClick}>Increment</button>;
}',
      'csharp', '// Angular equivalent (not React)
// @Input() for props
// Component fields for state

@Component({
    selector: ''app-user-card'',
    template: `
        <div>
            <h3>{{name}}</h3>
            <p>{{email}}</p>
            <button (click)="onDelete.emit()">Delete</button>
        </div>
    `
})
export class UserCardComponent {
    @Input() name: string;   // Like React props
    @Input() email: string;
    @Output() onDelete = new EventEmitter();
}'
    ),
    'React: props vs state:

PROPS (immutable, passed from parent):
┌───────────────┐
│    Parent     │
├───────────────┤
│ name="John"   │
└───────┬───────┘
        │ props ↓
┌───────────────┐
│     Child     │
├───────────────┤
│ props.name    │ Read-only
└───────────────┘

<Child name="John" email="j@mail.com" />

✓ Passed from parent
✗ Cannot modify
✓ Like function params

STATE (mutable, internal):
┌───────────────┐
│  Component    │
├───────────────┤
│ [count, set]  │ Internal state
│ = useState(0) │
│               │
│ setCount(1)   │ Change → re-render
└───────────────┘

const [count, setCount] = useState(0);
setCount(count + 1); // Update state

✓ Internal to component
✓ Can modify
✓ Triggers re-render

Data flow:
Props down ↓
Events up ↑',
    54
  ) ON CONFLICT DO NOTHING;

  -- React: useEffect
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular_id,
    'React: useEffect',
    'useEffect = run side effects (fetch data, timers, subscriptions) after render. Dependency array controls when it runs. Empty [] = run once. [count] = run when count changes. Cleanup with return function.',
    'useEffect: React Hook for side effects in functional components. Runs after render. Takes callback and optional dependency array. Dependencies control re-execution. Return cleanup function runs before next effect or unmount. Replaces componentDidMount/Update/Unmount.',
    'useEffect handles side effects - anything that affects outside world (data fetching, subscriptions, timers, DOM manipulation). Runs after component renders. Dependency array: (1) No array - runs after every render (rare). (2) Empty [] - runs once on mount. (3) [var] - runs when var changes. Cleanup: return function from effect, runs before next effect or unmount (clear timers, unsubscribe). Common uses: fetch data on mount, listen to events, sync with external system. Interview: explain dependencies (missing deps = stale closures), cleanup importance, infinite loops (effect updates state that triggers effect), useEffect vs useLayoutEffect (timing).',
    to_jsonb(ARRAY[
      'Missing dependencies (stale closures)',
      'Infinite loops (effect changes state in deps)',
      'Not cleaning up subscriptions/timers',
      'Too many useEffects (can combine)',
      'Using useEffect for derived state (compute during render)',
      'Not understanding when effect runs'
    ]),
    jsonb_build_object(
      'typescript', '// BASIC useEffect
useEffect(() => {
    console.log("Component rendered");
}); // Runs after every render

// RUN ONCE (component mount)
useEffect(() => {
    console.log("Component mounted");
    fetchData();
}, []); // Empty deps = run once

// RUN WHEN DEPENDENCY CHANGES
useEffect(() => {
    console.log(`Count changed to: ${count}`);
}, [count]); // Run when count changes

// CLEANUP
useEffect(() => {
    const timer = setInterval(() => {
        console.log("Tick");
    }, 1000);
    
    // Cleanup function
    return () => {
        clearInterval(timer); // Clear before unmount
    };
}, []);

// DATA FETCHING
function UserProfile({ userId }: { userId: number }) {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);
    
    useEffect(() => {
        let cancelled = false;
        
        async function fetchUser() {
            setLoading(true);
            try {
                const response = await fetch(`/api/users/${userId}`);
                const data = await response.json();
                
                if (!cancelled) {
                    setUser(data);
                }
            } finally {
                if (!cancelled) {
                    setLoading(false);
                }
            }
        }
        
        fetchUser();
        
        // Cleanup: cancel if userId changes mid-fetch
        return () => {
            cancelled = true;
        };
    }, [userId]); // Re-fetch when userId changes
    
    if (loading) return <div>Loading...</div>;
    return <div>{user?.name}</div>;
}

// EVENT LISTENERS
useEffect(() => {
    function handleResize() {
        console.log("Window resized");
    }
    
    window.addEventListener("resize", handleResize);
    
    // Cleanup
    return () => {
        window.removeEventListener("resize", handleResize);
    };
}, []);

// ✗ INFINITE LOOP (BAD)
useEffect(() => {
    setCount(count + 1); // Changes count
}, [count]); // Depends on count → infinite!

// ✗ MISSING DEPENDENCY (BAD)
useEffect(() => {
    console.log(count); // Uses count but not in deps
}, []); // count stale after first render',
      'csharp', '// Angular OnInit (similar to useEffect with [])
export class UserComponent implements OnInit, OnDestroy {
    private subscription: Subscription;
    
    ngOnInit() {
        // Like useEffect(() => {}, [])
        this.subscription = this.service.getData()
            .subscribe(data => this.data = data);
    }
    
    ngOnDestroy() {
        // Like useEffect cleanup
        this.subscription.unsubscribe();
    }
}'
    ),
    'useEffect:

useEffect(() => {
    // Side effect code
    
    return () => {
        // Cleanup
    };
}, [dependencies]);

TIMING:
1. Component renders
2. DOM updates
3. useEffect runs ←

Dependency patterns:

useEffect(() => { ... })
→ Runs every render

useEffect(() => { ... }, [])
→ Runs once (mount)

useEffect(() => { ... }, [count])
→ Runs when count changes

CLEANUP:
useEffect(() => {
    const timer = setInterval(...);
    
    return () => {
        clearInterval(timer); ← Cleanup
    };
}, []);

Cleanup runs:
- Before next effect
- Before unmount

Common uses:
✓ Fetch data
✓ Subscriptions
✓ Timers
✓ Event listeners',
    55
  ) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Completed Batch 7: Added 6 JS/TS/React terms';
END $$;
