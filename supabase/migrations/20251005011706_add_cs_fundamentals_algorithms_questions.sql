/*
  # Add Computer Science Fundamentals and Algorithm Questions
  
  1. Data Structures
    - Array vs Linked List
    - Stack vs Queue
    - Hash Table
    - Heap/Priority Queue
    
  2. Algorithms
    - Big-O complexity
    - Binary Search
    - Sorting algorithms
    - Recursion vs Iteration
    
  3. Memory & Performance
    - Value vs Reference semantics
    - Stack vs Heap
*/

-- Data Structures - Array vs Linked List
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you choose Array over Linked List?',
  '["Always use arrays", "When you need frequent random access (O(1)) and insertions/deletions are rare", "Linked lists are always better", "No difference"]'::jsonb,
  1,
  'Arrays provide O(1) random access by index but O(N) insertion/deletion (shifting elements). Choose arrays when you frequently access elements by position and insertions are rare. Linked Lists are O(N) access but O(1) insertion/deletion.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Stack vs Queue
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between Stack and Queue?',
  '["No difference", "Stack is LIFO (Last In First Out); Queue is FIFO (First In First Out)", "Stack is faster", "Queue is deprecated"]'::jsonb,
  1,
  'Stack is LIFO: last element added is first removed (like a stack of plates). Queue is FIFO: first element added is first removed (like a line at a store). Use Stack for call stacks, undo/redo; Queue for task processing.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Hash Table
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'How does a Hash Table handle collisions?',
  '["It crashes", "Using Chaining (linked list at each slot) or Open Addressing (probing for next slot)", "It does not handle them", "Only with encryption"]'::jsonb,
  1,
  'Hash Table collisions occur when different keys hash to the same index. Chaining stores multiple items at the same index using a linked list. Open Addressing finds the next available slot using probing.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is load factor and why does it matter in Hash Tables?',
  '["Number of items", "Ratio of items to slots; high load factor degrades performance, requiring rehashing", "Only for security", "It does not matter"]'::jsonb,
  1,
  'Load Factor = (number of items) / (number of slots). High load factor means more collisions and slower lookups. When load factor exceeds a threshold (typically 0.75), the hash table rehashes (resizes), which costs O(N) but amortizes to O(1).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Heap/Priority Queue
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is a Priority Queue and how is it implemented?',
  '["A regular queue", "A queue where elements are served by priority; typically implemented as a Binary Heap", "Only for threading", "A deprecated structure"]'::jsonb,
  1,
  'Priority Queue is an ADT where the highest priority element is removed first (not FIFO). Implemented using Binary Heap (complete binary tree) with O(log N) insertion/extraction. Used in Dijkstra algorithm, task scheduling.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Big-O Complexity
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What operation has O(1) time complexity?',
  '["Binary search", "Array access by index or Hash Table lookup (average case)", "Linear search", "Sorting"]'::jsonb,
  1,
  'O(1) constant time operations include: accessing an array element by index (arr[5]), hash table lookup (average case), push/pop on stack. These operations take the same time regardless of data size.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is an example of O(log n) complexity?',
  '["Linear search", "Binary search on sorted array", "Nested loops", "Array access"]'::jsonb,
  1,
  'O(log N) algorithms divide the problem in half each step. Binary Search is the classic example: search sorted array by checking middle element and discarding half. Tree operations (balanced BST) are also O(log N).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the time complexity of Bubble Sort in worst case?',
  '["O(1)", "O(n²) because of nested loops comparing all elements", "O(log n)", "O(n)"]'::jsonb,
  1,
  'Bubble Sort uses nested loops: outer loop runs N times, inner loop runs up to N times, giving O(N²) complexity. Each element is compared with every other element. This makes it inefficient for large datasets.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Binary Search
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the required condition for Binary Search?',
  '["Any array", "Array must be sorted", "Array must be small", "Array must have duplicates"]'::jsonb,
  1,
  'Binary Search requires the array to be sorted. It works by repeatedly dividing the search interval in half. If the array is not sorted, binary search will not find the element correctly.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What edge cases should you test with Binary Search?',
  '["No edge cases", "Empty array, element at start, element at end, element not present", "Only large arrays", "Only odd-length arrays"]'::jsonb,
  1,
  'Binary Search edge cases include: empty array (return -1), element at index 0, element at last index, element not present (return -1), array with one element. Test these to ensure your implementation is robust.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Sorting Algorithms
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you use Merge Sort vs Quick Sort?',
  '["Always use Merge Sort", "Merge Sort guarantees O(n log n) and is stable; Quick Sort is faster on average but O(n²) worst case", "They are the same", "Quick Sort is always better"]'::jsonb,
  1,
  'Merge Sort: Guaranteed O(N log N), stable (preserves order of equal elements), but uses O(N) extra space. Quick Sort: Average O(N log N), faster in practice, but O(N²) worst case. Choose based on stability needs and data patterns.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When is Insertion Sort a good choice?',
  '["Never", "For small arrays or nearly sorted data where it approaches O(N)", "For large random data", "Only for strings"]'::jsonb,
  1,
  'Insertion Sort is O(N²) worst case but O(N) for nearly sorted data. It is efficient for small arrays (< 10-20 elements) or as a final step in hybrid sorting algorithms like TimSort. Very simple to implement.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Recursion vs Iteration
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the main risk of recursion?',
  '["It is slower", "Stack overflow if recursion depth is too large (exceeds call stack limit)", "Memory leaks", "It does not work"]'::jsonb,
  1,
  'Recursion uses the call stack for each recursive call. Deep recursion (e.g., 10000+ levels) can exceed stack limits and cause Stack Overflow errors. Tail recursion optimization helps, but not all languages support it.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When should you prefer recursion over iteration?',
  '["Never", "For naturally recursive problems (tree traversal, divide-and-conquer) where recursive solution is clearer", "Always use recursion", "Only in functional languages"]'::jsonb,
  1,
  'Recursion is clearer for problems that are naturally recursive: tree/graph traversal, divide-and-conquer (merge sort, quick sort), backtracking. Iteration is better for performance and avoiding stack overflow in simple loops.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Value vs Reference
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'What is the difference between value and reference semantics?',
  '["No difference", "Value: variable stores the data directly, copies create independent data; Reference: variable stores address, copies share the same data", "Reference is faster", "Value is deprecated"]'::jsonb,
  1,
  'Value semantics: variable stores actual data; copying creates a new independent copy. Reference semantics: variable stores memory address; copying creates another reference to same data. Modifying via one reference affects all.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Performance - N+1 Query Problem
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'How do you fix the N+1 query problem in EF Core?',
  '["Cannot be fixed", "Use eager loading with .Include() or projection with .Select() to fetch related data in one query", "Add more indexes", "Use caching"]'::jsonb,
  1,
  'N+1 is fixed by fetching related data upfront: .Include(u => u.Orders) loads all orders in one query (eager loading). Alternatively, use .Select() to project only needed fields. Avoid lazy loading in loops.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

-- Normalization
INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'Why is database normalization important?',
  '["Makes queries faster", "Reduces data redundancy and prevents update/delete anomalies", "Only for large databases", "It is deprecated"]'::jsonb,
  1,
  'Normalization (1NF, 2NF, 3NF) reduces data redundancy by organizing data into separate tables with relationships. This prevents anomalies where updating one row requires updating multiple places. However, may require more JOINs.'
FROM terms WHERE term = 'Abstraction' LIMIT 1;

INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
SELECT id, 'When is denormalization acceptable?',
  '["Never", "For read-heavy scenarios (reports, analytics) where you accept some redundancy to avoid expensive JOINs", "Always denormalize", "Only for NoSQL"]'::jsonb,
  1,
  'Denormalization is acceptable in read-heavy scenarios where query performance is critical (dashboards, reports). You accept some data redundancy to avoid complex JOINs. Write operations become more complex (update multiple places).'
FROM terms WHERE term = 'Abstraction' LIMIT 1;
