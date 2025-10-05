/*
  # Add CS Fundamentals, Algorithms, Git, Cloud Questions
  
  Complete coverage of remaining study guide topics
*/

DO $$
DECLARE
  general_term_id uuid;
BEGIN
  SELECT id INTO general_term_id FROM terms WHERE term = 'Abstraction' LIMIT 1;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation) VALUES
  
  -- Array vs Linked List
  (general_term_id, 'When should you choose Array over Linked List?',
   '["Always use arrays", "When you need frequent random access O(1) by index and insertions/deletions are rare", "Linked lists are always better", "No difference"]'::jsonb, 1,
   'Array: Contiguous storage, O(1) random access by index, O(N) insertion/deletion (shifting elements). Good for frequent reads by position. Linked List: Non-contiguous (linked nodes), O(N) access by index, O(1) insertion/deletion once at position. Good for frequent insertions/deletions.'),
  
  -- Stack vs Queue
  (general_term_id, 'What is the difference between Stack and Queue?',
   '["No difference", "Stack is LIFO (Last In First Out); Queue is FIFO (First In First Out)", "Stack is faster", "Queue is deprecated"]'::jsonb, 1,
   'Stack is LIFO: last element added is first removed (like stack of plates). Use for: call stack, undo/redo, DFS traversal. Queue is FIFO: first element added is first removed (like line at store). Use for: task processing, BFS traversal, message queues.'),
  
  -- Hash Table Collisions
  (general_term_id, 'How do Hash Tables handle collisions?',
   '["They crash", "Chaining (linked list at slot) or Open Addressing (probe for next empty slot)", "They do not handle them", "Only with encryption"]'::jsonb, 1,
   'Hash Table collisions occur when different keys hash to same index. Solutions: 1) Chaining - store multiple items at same index using linked list. 2) Open Addressing - probe for next empty slot (linear probing, quadratic probing). Load factor determines when to rehash (resize).'),
  
  -- Priority Queue / Heap
  (general_term_id, 'What is a Priority Queue and how is it implemented?',
   '["A regular queue", "ADT where highest priority element is served first; typically implemented as Binary Heap with O(log N) operations", "Only for threading", "A deprecated structure"]'::jsonb, 1,
   'Priority Queue is an Abstract Data Type where element with highest priority is extracted first (not FIFO). Typically implemented as Binary Heap (complete binary tree). Insertion and extraction are O(log N). Used in: Dijkstra algorithm, task scheduling, finding top K elements.'),
  
  -- Big-O Examples
  (general_term_id, 'Match algorithms to their Big-O complexity: O(1), O(log n), O(n), O(n log n), O(n²)',
   '["All are O(1)", "O(1): Array access, O(log n): Binary Search, O(n): Linear search, O(n log n): Merge Sort, O(n²): Bubble Sort", "All are O(n)", "Cannot determine"]'::jsonb, 1,
   'O(1) constant: Array index access, hash table lookup (average). O(log n) logarithmic: Binary search on sorted array, balanced tree operations. O(n) linear: Linear search, single loop. O(n log n): Merge sort, quick sort (average). O(n²) quadratic: Bubble sort, nested loops.'),
  
  -- Binary Search Requirements
  (general_term_id, 'What is required for Binary Search to work?',
   '["Any array", "Array must be sorted", "Array must be small", "Must have duplicates"]'::jsonb, 1,
   'Binary Search REQUIRES sorted array. It works by checking middle element and discarding half the search space each iteration. On unsorted array, binary search gives incorrect results. Edge cases to test: empty array, element at start, element at end, element not present.'),
  
  -- Sorting Algorithms
  (general_term_id, 'When should you use Merge Sort vs Quick Sort vs Insertion Sort?',
   '["Always use Merge", "Merge: stable + guaranteed O(n log n); Quick: fastest average O(n log n); Insertion: small/nearly sorted O(n)", "They are identical", "Quick is always best"]'::jsonb, 1,
   'Merge Sort: Stable (preserves equal element order), guaranteed O(n log n), uses O(n) extra space. Quick Sort: Fastest in practice (average O(n log n)), but O(n²) worst case, in-place. Insertion Sort: O(n²) but O(n) for nearly sorted data, great for small arrays (<10-20 elements).'),
  
  -- Recursion vs Iteration
  (general_term_id, 'What is the main risk of recursion and when should you use it?',
   '["No risks", "Stack overflow if too deep; use for naturally recursive problems (tree traversal, divide-and-conquer)", "Always use recursion", "Recursion is deprecated"]'::jsonb, 1,
   'Recursion uses call stack, risking Stack Overflow with deep recursion (>10000 levels). Use recursion for: tree/graph traversal, divide-and-conquer (merge/quick sort), backtracking - where recursive solution is clearer. Use iteration for: simple loops, when depth is large, performance-critical code.'),
  
  -- Value vs Reference Semantics
  (general_term_id, 'What is the difference between value and reference semantics?',
   '["No difference", "Value: variable stores data directly, copies create independent data; Reference: variable stores address, copies share same data", "Reference is faster", "Value is deprecated"]'::jsonb, 1,
   'Value semantics: Variable stores actual data. Copying creates new independent copy. Modifying copy does not affect original. Reference semantics: Variable stores memory address. Copying creates another reference to same data. Modifying through one reference affects all references.'),
  
  -- Git Workflow
  (general_term_id, 'What is the correct Git workflow order?',
   '["push → commit → clone", "clone → branch → commit → push → pull (for updates)", "commit → branch → push", "pull → clone → commit"]'::jsonb, 1,
   'Correct Git workflow: 1) clone (get repository from remote), 2) branch (create feature branch), 3) commit (save changes to local history), 4) push (send commits to remote branch), 5) pull (get others changes, potentially merge). Create Pull Request for code review before merging to main.'),
  
  -- Git Merge vs Rebase
  (general_term_id, 'What is the difference between Git merge and rebase?',
   '["No difference", "Merge combines branches with merge commit (non-linear history); Rebase rewrites history (linear) - do not rebase public branches", "Rebase is deprecated", "Merge is slower"]'::jsonb, 1,
   'Merge combines branch histories, creating a merge commit. Preserves all commits, non-linear history. Rebase replays your commits on top of target branch, rewriting history for linear log. Rule: NEVER rebase public/shared branches (rewrites history others depend on). Rebase only local feature branches before PR.'),
  
  -- CI/CD
  (general_term_id, 'What is CI/CD and what is the minimum for a simple API?',
   '["A programming language", "CI: automated build + tests on commit; CD: automated deployment to staging/production. Minimum: build, unit tests, deploy", "Only for large companies", "A database"]'::jsonb, 1,
   'CI (Continuous Integration): Automatically build and test code when pushed to repository. Catches bugs early. CD (Continuous Delivery/Deployment): Automatically deploy to staging/production if tests pass. Minimum pipeline: 1) Build (compile), 2) Test (unit/integration tests), 3) Deploy (to server). Tools: GitHub Actions, Azure DevOps, Jenkins.'),
  
  -- IaaS vs PaaS vs SaaS
  (general_term_id, 'What is the difference between IaaS, PaaS, and SaaS?',
   '["No difference", "IaaS: VMs/infrastructure; PaaS: platform for apps (Azure App Service); SaaS: complete software (Gmail)", "Only SaaS exists now", "All are the same"]'::jsonb, 1,
   'IaaS (Infrastructure as a Service): Rent virtual machines, networking. You manage OS, runtime, apps. Example: Azure VM, AWS EC2. PaaS (Platform as a Service): Platform manages runtime. You deploy app and data. Example: Azure App Service, Heroku. SaaS (Software as a Service): Complete application. Example: Gmail, Office 365. Control decreases IaaS → PaaS → SaaS.');

END $$;
