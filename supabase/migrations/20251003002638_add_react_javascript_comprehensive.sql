/*
  # Add React and JavaScript Comprehensive Terms
  
  Add: React Hooks (useState, useEffect), Props vs State, JavaScript Promises, Callbacks, DOM
*/

DO $$
DECLARE
  cat_angular uuid;
  cat_cs uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_angular FROM categories WHERE slug = 'angular';
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';

  -- React useState Hook
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'React useState Hook',
    'useState lets you add state (data that changes) to functional components. Returns current value and updater function.',
    'useState: React Hook for state management in functional components. Returns [state, setState]. setState triggers re-render.',
    'useState manages component state. Call useState(initialValue) returns array: [currentState, setStateFunction]. Calling setState updates state and re-renders component. State persists between renders. Use for interactive UI data.',
    to_jsonb(ARRAY['Mutating state directly instead of setState', 'Not understanding state updates are asynchronous', 'Too many useState calls (consider useReducer)', 'Forgetting functional updates for previous state']),
    jsonb_build_object(
      'csharp', E'// Blazor equivalent (C#)\n@page "/counter"\n\n<h3>Counter</h3>\n<p>Count: @count</p>\n<button @onclick="Increment">Increment</button>\n\n@code {\n  // State\n  private int count = 0;\n  \n  // Update state\n  private void Increment() {\n    count++; // StateHasChanged called automatically\n  }\n}',
      'typescript', E'import { useState } from ''react'';\n\nfunction Counter() {\n  // Declare state variable\n  const [count, setCount] = useState(0);\n  const [name, setName] = useState(''Guest'');\n  \n  // Update state\n  const increment = () => {\n    setCount(count + 1); // Creates new state\n  };\n  \n  // Functional update (uses previous state)\n  const incrementTwice = () => {\n    setCount(prev => prev + 1);\n    setCount(prev => prev + 1);\n  };\n  \n  return (\n    <div>\n      <h3>Counter</h3>\n      <p>Count: {count}</p>\n      <p>Name: {name}</p>\n      <button onClick={increment}>Increment</button>\n      <button onClick={() => setCount(0)}>Reset</button>\n      <input \n        value={name}\n        onChange={e => setName(e.target.value)}\n      />\n    </div>\n  );\n}\n\n// Array/Object state\nfunction TodoList() {\n  const [todos, setTodos] = useState([]);\n  \n  const addTodo = (text) => {\n    setTodos([...todos, { id: Date.now(), text }]);\n  };\n  \n  const removeTodo = (id) => {\n    setTodos(todos.filter(t => t.id !== id));\n  };\n}'
    ),
    E'useState:\nconst [count, setCount] = useState(0);\n       ↓         ↓              ↓\n   current  updater     initial\n   value   function     value\n\nsetCount(5) → triggers re-render\n\nFunctional update:\nsetCount(prev => prev + 1)\n  Uses previous state',
    130
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'useState returns?', to_jsonb(ARRAY['Value only', '[currentState, setStateFunction]', 'Object', 'Number']), 1, 'Array with value and updater.'),
    (current_term_id, 'setState does?', to_jsonb(ARRAY['Nothing', 'Updates state and triggers re-render', 'Deletes state', 'Logs']), 1, 'Update and re-render component.'),
    (current_term_id, 'Mutate state directly?', to_jsonb(ARRAY['Yes, always', 'No, use setState', 'Sometimes', 'Doesn''t matter']), 1, 'Never mutate, always setState.'),
    (current_term_id, 'Functional update when?', to_jsonb(ARRAY['Never', 'When update depends on previous state', 'Always', 'Random']), 1, 'setState(prev => prev + 1) for safety.'),
    (current_term_id, 'useState for?', to_jsonb(ARRAY['Props', 'Component internal state', 'Global state', 'Constants']), 1, 'Local component state.');

  -- React useEffect Hook
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'React useEffect Hook',
    'useEffect runs side effects (fetch data, subscriptions, timers) after render. Cleanup function runs before unmount.',
    'useEffect: Hook for side effects in functional components. Runs after render. Dependency array controls when it runs. Return cleanup function.',
    'useEffect handles side effects: data fetching, subscriptions, DOM manipulation, timers. Runs after every render by default. Dependency array controls re-execution. Empty array = run once. Return function for cleanup (unsubscribe, clear timers).',
    to_jsonb(ARRAY['Missing dependencies causing stale closures', 'Not cleaning up subscriptions/timers', 'Infinite loops from wrong dependencies', 'Heavy logic without optimization', 'useEffect for everything (overuse)']),
    jsonb_build_object(
      'csharp', E'// Blazor OnInitializedAsync equivalent\n@page "/user/{Id:int}"\n@inject UserService UserService\n\n<h3>User Details</h3>\n@if(user != null) {\n  <p>Name: @user.Name</p>\n}\n\n@code {\n  [Parameter] public int Id { get; set; }\n  private User user;\n  \n  // Like useEffect with [Id] dependency\n  protected override async Task OnInitializedAsync() {\n    user = await UserService.GetByIdAsync(Id);\n  }\n  \n  protected override async Task OnParametersSetAsync() {\n    // Runs when Id changes\n    user = await UserService.GetByIdAsync(Id);\n  }\n  \n  public void Dispose() {\n    // Cleanup\n  }\n}',
      'typescript', E'import { useState, useEffect } from ''react'';\n\nfunction UserProfile({ userId }) {\n  const [user, setUser] = useState(null);\n  const [loading, setLoading] = useState(true);\n  \n  // Runs after every render\n  useEffect(() => {\n    console.log(''Component rendered'');\n  });\n  \n  // Runs once on mount (empty dependency array)\n  useEffect(() => {\n    console.log(''Component mounted'');\n    \n    // Cleanup on unmount\n    return () => {\n      console.log(''Component unmounting'');\n    };\n  }, []);\n  \n  // Runs when userId changes\n  useEffect(() => {\n    setLoading(true);\n    \n    fetch(`/api/users/${userId}`)\n      .then(res => res.json())\n      .then(data => {\n        setUser(data);\n        setLoading(false);\n      });\n  }, [userId]); // Dependency array\n  \n  // Cleanup example: timer\n  useEffect(() => {\n    const timer = setInterval(() => {\n      console.log(''Tick'');\n    }, 1000);\n    \n    // Cleanup: clear timer\n    return () => clearInterval(timer);\n  }, []);\n  \n  // Cleanup example: subscription\n  useEffect(() => {\n    const subscription = dataService.subscribe(data => {\n      setUser(data);\n    });\n    \n    return () => subscription.unsubscribe();\n  }, []);\n  \n  if(loading) return <p>Loading...</p>;\n  return <div>{user?.name}</div>;\n}'
    ),
    E'useEffect:\nuseEffect(() => {\n  // Side effect\n  fetch(data);\n  \n  return () => {\n    // Cleanup\n  };\n}, [deps]);\n   ↓\n[] = run once\n[dep] = run when dep changes\nno array = run every render\n\nCleanup prevents memory leaks',
    131
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'useEffect runs?', to_jsonb(ARRAY['Before render', 'After render', 'During render', 'Never']), 1, 'Side effects after DOM update.'),
    (current_term_id, 'Empty dependency array?', to_jsonb(ARRAY['Every render', 'Run once on mount', 'Never runs', 'On unmount']), 1, '[] = componentDidMount equivalent.'),
    (current_term_id, 'Cleanup function for?', to_jsonb(ARRAY['Rendering', 'Unsubscribe, clear timers', 'State', 'Props']), 1, 'Prevent memory leaks.'),
    (current_term_id, 'Missing dependency?', to_jsonb(ARRAY['No problem', 'Stale closure, bugs', 'Faster', 'Better']), 1, 'Stale data from closure.'),
    (current_term_id, 'useEffect for?', to_jsonb(ARRAY['State', 'Side effects: fetch, subscriptions, timers', 'Rendering', 'Props']), 1, 'Effects after render.');

  -- Props vs State
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_angular, 'React Props vs State',
    'Props = data passed from parent (read-only). State = component''s own data (mutable).',
    'Props: external data passed to component, immutable. State: internal data managed by component, mutable via setState.',
    'Props come from parent, read-only in child. State is internal, changeable. Props for configuration, State for interactive data. Lifting state up shares data. Unidirectional data flow: parent controls props, child manages state.',
    to_jsonb(ARRAY['Mutating props (forbidden)', 'Too much state (lift up shared state)', 'Prop drilling (use Context)', 'Not understanding one-way data flow']),
    jsonb_build_object(
      'csharp', E'// Blazor Components\n// Parent\n<ChildComponent Name="John" Age={30} OnClick={HandleClick} />\n\n// Child\n@code {\n  [Parameter] // Props\n  public string Name { get; set; }\n  \n  [Parameter]\n  public int Age { get; set; }\n  \n  [Parameter] // Event callback (like props)\n  public EventCallback<string> OnClick { get; set; }\n  \n  // State\n  private int count = 0;\n  \n  private void IncrementCount() {\n    count++; // Modify own state\n    // Name = "changed"; // WRONG! Cannot modify props\n  }\n}',
      'typescript', E'// Parent Component\nfunction ParentComponent() {\n  const [count, setCount] = useState(0);\n  \n  return (\n    <ChildComponent \n      name="John"              // Prop\n      age={30}                 // Prop\n      onIncrement={setCount}   // Prop (callback)\n    />\n  );\n}\n\n// Child Component\nfunction ChildComponent({ name, age, onIncrement }) {\n  // Props (read-only)\n  console.log(name); // "John"\n  // name = "Jane"; // WRONG! Props are immutable\n  \n  // Own state (mutable)\n  const [localCount, setLocalCount] = useState(0);\n  \n  return (\n    <div>\n      <p>Name: {name}</p>\n      <p>Age: {age}</p>\n      <p>Local Count: {localCount}</p>\n      <button onClick={() => setLocalCount(localCount + 1)}>\n        Increment Local\n      </button>\n      <button onClick={() => onIncrement(prev => prev + 1)}>\n        Increment Parent\n      </button>\n    </div>\n  );\n}\n\n// Data flow\n// Parent State → Child Props (one way)\n// Child calls callback → Parent updates state → Props change'
    ),
    E'Props vs State:\n\n[Parent Component]\n  state: count = 0\n       ↓ props\n[Child Component]\n  props: { name, age } ← read-only\n  state: localCount ← mutable\n\nData flow:\n  Parent → Child (props)\n  Child → Parent (callbacks)\n\nOne-way data flow',
    132
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Props are?', to_jsonb(ARRAY['Mutable', 'Immutable, from parent', 'Internal state', 'Methods']), 1, 'Read-only data from parent.'),
    (current_term_id, 'State is?', to_jsonb(ARRAY['From parent', 'Component''s own mutable data', 'Read-only', 'Props']), 1, 'Internal changeable data.'),
    (current_term_id, 'Can child modify props?', to_jsonb(ARRAY['Yes', 'No, props immutable', 'Sometimes', 'Always']), 1, 'Props read-only in child.'),
    (current_term_id, 'Lifting state up?', to_jsonb(ARRAY['Delete state', 'Move state to common parent to share', 'Lower state', 'Remove state']), 1, 'Share data between siblings.'),
    (current_term_id, 'Data flow in React?', to_jsonb(ARRAY['Two-way', 'One-way: parent to child', 'Random', 'Child to parent']), 1, 'Unidirectional data flow.');

  RAISE NOTICE 'Added React comprehensive terms';
END $$;
