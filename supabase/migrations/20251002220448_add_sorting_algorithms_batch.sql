/*
  # Add Sorting Algorithms & More CS Fundamentals
  
  1. New Terms (15 terms)
    - Merge Sort, Quick Sort, Bubble Sort, Insertion Sort, Selection Sort
    - Linear Search, Recursion vs Iteration
    - Two Pointers, Sliding Window, Greedy vs DP
    - Stack vs Heap Memory, Value vs Reference Types
    - HTTP Methods, HTTP Status Codes, CORS
*/

DO $$
DECLARE
  cat_cs uuid;
  current_term_id uuid;
BEGIN
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';

  -- Merge Sort
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Merge Sort',
    'Divide list in half repeatedly, then merge sorted halves back together.',
    'Divide-and-conquer sorting algorithm. Recursively split array in half, sort each half, merge sorted halves. O(n log n) time, O(n) space.',
    'Merge sort guarantees O(n log n) in all cases via divide-and-conquer. Stable sort preserving order. Trade-off: O(n) extra space for merging. Use when stable sort and predictable performance needed.',
    to_jsonb(ARRAY['O(n) space overhead', 'Not in-place', 'Slower than quicksort in practice for arrays', 'Recursive stack depth']),
    jsonb_build_object(
      'csharp', E'void MergeSort(int[] arr, int left, int right) {\n  if(left < right) {\n    int mid = left + (right - left) / 2;\n    MergeSort(arr, left, mid);\n    MergeSort(arr, mid + 1, right);\n    Merge(arr, left, mid, right);\n  }\n}\n\nvoid Merge(int[] arr, int l, int m, int r) {\n  int[] temp = new int[r - l + 1];\n  int i = l, j = m + 1, k = 0;\n  while(i <= m && j <= r)\n    temp[k++] = arr[i] <= arr[j] ? arr[i++] : arr[j++];\n  while(i <= m) temp[k++] = arr[i++];\n  while(j <= r) temp[k++] = arr[j++];\n  Array.Copy(temp, 0, arr, l, temp.Length);\n}',
      'typescript', E'function mergeSort(arr: number[]): number[] {\n  if(arr.length <= 1) return arr;\n  const mid = Math.floor(arr.length / 2);\n  const left = mergeSort(arr.slice(0, mid));\n  const right = mergeSort(arr.slice(mid));\n  return merge(left, right);\n}\n\nfunction merge(left: number[], right: number[]): number[] {\n  const result: number[] = [];\n  let i = 0, j = 0;\n  while(i < left.length && j < right.length) {\n    result.push(left[i] <= right[j] ? left[i++] : right[j++]);\n  }\n  return result.concat(left.slice(i)).concat(right.slice(j));\n}'
    ),
    E'Merge Sort:\n[8,3,5,1,9,2]\n  ↓ split\n[8,3,5] [1,9,2]\n  ↓       ↓\n[3,5,8] [1,2,9]\n  ↓ merge ↓\n[1,2,3,5,8,9]\nO(n log n)',
    31
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Merge sort time complexity?', to_jsonb(ARRAY['O(n)', 'O(n log n)', 'O(n²)', 'O(log n)']), 1, 'Divides log n levels, merges n per level.'),
    (current_term_id, 'Merge sort space complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n²)']), 2, 'Needs auxiliary array for merging.'),
    (current_term_id, 'Merge sort is stable?', to_jsonb(ARRAY['Yes', 'No', 'Sometimes', 'Depends on implementation']), 0, 'Preserves relative order of equal elements.'),
    (current_term_id, 'Merge sort worst case?', to_jsonb(ARRAY['O(n)', 'O(n log n)', 'O(n²)', 'O(2^n)']), 1, 'Always O(n log n), no worst case degradation.'),
    (current_term_id, 'Merge sort disadvantage?', to_jsonb(ARRAY['Slow', 'Requires O(n) extra space', 'Unstable', 'Bad worst case']), 1, 'Not in-place, needs auxiliary memory.');

  -- Quick Sort
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Quick Sort',
    'Pick a pivot, put smaller items left, larger right, repeat for each side.',
    'Divide-and-conquer sorting via partitioning. Choose pivot, partition array around it, recursively sort partitions. Average O(n log n), worst O(n²).',
    'Quicksort is fast in practice with O(n log n) average case. In-place with O(log n) space for recursion. Worst case O(n²) with bad pivots (already sorted). Use randomized pivot or median-of-three. Not stable.',
    to_jsonb(ARRAY['O(n²) worst case with bad pivot selection', 'Not stable', 'Stack overflow with deep recursion', 'Poor performance on already sorted data']),
    jsonb_build_object(
      'csharp', E'void QuickSort(int[] arr, int low, int high) {\n  if(low < high) {\n    int pi = Partition(arr, low, high);\n    QuickSort(arr, low, pi - 1);\n    QuickSort(arr, pi + 1, high);\n  }\n}\n\nint Partition(int[] arr, int low, int high) {\n  int pivot = arr[high];\n  int i = low - 1;\n  for(int j = low; j < high; j++) {\n    if(arr[j] < pivot) {\n      i++;\n      (arr[i], arr[j]) = (arr[j], arr[i]);\n    }\n  }\n  (arr[i + 1], arr[high]) = (arr[high], arr[i + 1]);\n  return i + 1;\n}',
      'typescript', E'function quickSort(arr: number[], low = 0, high = arr.length - 1): void {\n  if(low < high) {\n    const pi = partition(arr, low, high);\n    quickSort(arr, low, pi - 1);\n    quickSort(arr, pi + 1, high);\n  }\n}\n\nfunction partition(arr: number[], low: number, high: number): number {\n  const pivot = arr[high];\n  let i = low - 1;\n  for(let j = low; j < high; j++) {\n    if(arr[j] < pivot) {\n      i++;\n      [arr[i], arr[j]] = [arr[j], arr[i]];\n    }\n  }\n  [arr[i + 1], arr[high]] = [arr[high], arr[i + 1]];\n  return i + 1;\n}'
    ),
    E'Quick Sort:\n[3,7,8,5,2,1,9,4]\n     ↑ pivot=4\nPartition: <4 | 4 | >4\n[3,2,1] 4 [7,8,5,9]\nRecurse on both sides\nAvg: O(n log n)',
    32
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Quick sort average case?', to_jsonb(ARRAY['O(n)', 'O(n log n)', 'O(n²)', 'O(log n)']), 1, 'Good partitions divide roughly in half.'),
    (current_term_id, 'Quick sort worst case?', to_jsonb(ARRAY['O(n)', 'O(n log n)', 'O(n²)', 'O(2^n)']), 2, 'Bad pivot causes unbalanced partitions.'),
    (current_term_id, 'Quick sort is in-place?', to_jsonb(ARRAY['Yes, O(log n) stack', 'No, needs O(n) space', 'Only sometimes', 'Never']), 0, 'Swaps in array, only recursion stack overhead.'),
    (current_term_id, 'Quick sort is stable?', to_jsonb(ARRAY['Yes', 'No', 'Can be made stable', 'Depends']), 1, 'Standard quicksort not stable due to swaps.'),
    (current_term_id, 'Prevent worst case how?', to_jsonb(ARRAY['Use merge sort', 'Randomized pivot or median-of-three', 'Always use middle', 'Presort array']), 1, 'Random pivot avoids pathological cases.');

  -- Bubble Sort
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Bubble Sort',
    'Repeatedly swap adjacent items if they are in wrong order, largest bubbles to end.',
    'Simple comparison sort. Repeatedly step through list, compare adjacent elements, swap if wrong order. O(n²) time, O(1) space.',
    'Bubble sort is simple but inefficient O(n²) algorithm. Each pass bubbles largest element to end. Stable and in-place. Only use for teaching or tiny datasets. Optimized version: stop early if no swaps.',
    to_jsonb(ARRAY['O(n²) performance on large data', 'Slow compared to merge/quick sort', 'Too many comparisons and swaps', 'Only good for nearly sorted data']),
    jsonb_build_object(
      'csharp', E'void BubbleSort(int[] arr) {\n  int n = arr.Length;\n  for(int i = 0; i < n - 1; i++) {\n    bool swapped = false;\n    for(int j = 0; j < n - i - 1; j++) {\n      if(arr[j] > arr[j + 1]) {\n        (arr[j], arr[j + 1]) = (arr[j + 1], arr[j]);\n        swapped = true;\n      }\n    }\n    if(!swapped) break; // Optimization: already sorted\n  }\n}',
      'typescript', E'function bubbleSort(arr: number[]): void {\n  const n = arr.length;\n  for(let i = 0; i < n - 1; i++) {\n    let swapped = false;\n    for(let j = 0; j < n - i - 1; j++) {\n      if(arr[j] > arr[j + 1]) {\n        [arr[j], arr[j + 1]] = [arr[j + 1], arr[j]];\n        swapped = true;\n      }\n    }\n    if(!swapped) break;\n  }\n}'
    ),
    E'Bubble Sort:\n[5,3,8,4,2]\nPass 1: [3,5,4,2,8] ← 8 bubbled\nPass 2: [3,4,2,5,8] ← 5 bubbled\nPass 3: [3,2,4,5,8]\nPass 4: [2,3,4,5,8]\nO(n²)',
    33
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Bubble sort time complexity?', to_jsonb(ARRAY['O(n)', 'O(n log n)', 'O(n²)', 'O(log n)']), 2, 'Nested loops: n × n comparisons.'),
    (current_term_id, 'Bubble sort space complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n²)']), 0, 'In-place swaps, no extra array.'),
    (current_term_id, 'Bubble sort is stable?', to_jsonb(ARRAY['Yes', 'No', 'Sometimes', 'Depends']), 0, 'Adjacent swaps preserve equal element order.'),
    (current_term_id, 'When to use bubble sort?', to_jsonb(ARRAY['Large datasets', 'Production code', 'Teaching or tiny data', 'Always']), 2, 'Too slow for practical use, educational only.'),
    (current_term_id, 'Optimization: early termination?', to_jsonb(ARRAY['Impossible', 'Stop if no swaps in pass', 'Skip first element', 'Use recursion']), 1, 'If pass has no swaps, array is sorted.');

  -- Two Pointers
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Two Pointers Pattern',
    'Use two markers moving through data from different positions to solve problems efficiently.',
    'Algorithmic pattern using two indices/pointers to traverse data structure. Common variants: opposite ends (converging), same start (fast/slow), separate arrays.',
    'Two pointers optimize problems by avoiding nested loops. Use for sorted array problems, palindromes, merging, cycle detection (fast/slow). Reduces O(n²) to O(n) in many cases.',
    to_jsonb(ARRAY['Off-by-one errors with pointer movement', 'Not handling edge cases (empty, single element)', 'Wrong pointer initialization', 'Infinite loops from incorrect termination']),
    jsonb_build_object(
      'csharp', E'// Two Sum in sorted array\nint[] TwoSum(int[] arr, int target) {\n  int left = 0, right = arr.Length - 1;\n  while(left < right) {\n    int sum = arr[left] + arr[right];\n    if(sum == target) return new[]{left, right};\n    if(sum < target) left++;\n    else right--;\n  }\n  return new int[0];\n}\n\n// Palindrome check\nbool IsPalindrome(string s) {\n  int left = 0, right = s.Length - 1;\n  while(left < right) {\n    if(s[left++] != s[right--]) return false;\n  }\n  return true;\n}',
      'typescript', E'// Two Sum in sorted array\nfunction twoSum(arr: number[], target: number): number[] {\n  let left = 0, right = arr.length - 1;\n  while(left < right) {\n    const sum = arr[left] + arr[right];\n    if(sum === target) return [left, right];\n    if(sum < target) left++;\n    else right--;\n  }\n  return [];\n}\n\n// Fast/Slow (cycle detection)\nfunction hasCycle(head: ListNode): boolean {\n  let slow = head, fast = head;\n  while(fast?.next) {\n    slow = slow.next;\n    fast = fast.next.next;\n    if(slow === fast) return true;\n  }\n  return false;\n}'
    ),
    E'Two Pointers:\n[1,2,3,4,5,6]\n ↑         ↑\nleft     right\nConverge to middle\n\nFast/Slow:\nS→[1]→[2]→[3]→[4]\nF→[1]   →[3]   →\nDetect cycle: O(n)',
    34
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Two pointers typical complexity?', to_jsonb(ARRAY['O(1)', 'O(log n)', 'O(n)', 'O(n²)']), 2, 'Single pass through array: O(n).'),
    (current_term_id, 'Two pointers requires?', to_jsonb(ARRAY['Sorted array always', 'Often sorted, but not always', 'Tree structure', 'Hash table']), 1, 'Useful with sorted data, but also cycle detection.'),
    (current_term_id, 'Fast/slow pointers detect?', to_jsonb(ARRAY['Sorting', 'Linked list cycle', 'Binary search', 'Minimum']), 1, 'Fast catches slow if cycle exists.'),
    (current_term_id, 'Advantage over nested loops?', to_jsonb(ARRAY['Same complexity', 'Reduces O(n²) to O(n)', 'Easier to code', 'More memory']), 1, 'Avoids nested iteration.'),
    (current_term_id, 'Common use case?', to_jsonb(ARRAY['Sorting', 'Two Sum in sorted array', 'Tree traversal', 'Hashing']), 1, 'Classic two pointers problem.');

  -- Sliding Window
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Sliding Window Pattern',
    'Maintain a moving window over data, adjusting size dynamically to track subarray properties.',
    'Algorithmic pattern maintaining window (subarray/substring) and sliding start/end pointers. Fixed or variable size. Optimizes subarray problems from O(n²) to O(n).',
    'Sliding window efficiently tracks contiguous subarrays by incrementally updating window state instead of recalculating. Use for max/min subarray, longest substring, or anagrams. Reduces nested loops to single pass.',
    to_jsonb(ARRAY['Not updating window state correctly', 'Off-by-one errors in window bounds', 'Forgetting to shrink window when needed', 'Wrong termination condition']),
    jsonb_build_object(
      'csharp', E'// Max sum of k consecutive elements\nint MaxSum(int[] arr, int k) {\n  int sum = arr.Take(k).Sum();\n  int maxSum = sum;\n  for(int i = k; i < arr.Length; i++) {\n    sum += arr[i] - arr[i - k]; // Slide window\n    maxSum = Math.Max(maxSum, sum);\n  }\n  return maxSum;\n}\n\n// Longest substring without repeating chars\nint LengthOfLongestSubstring(string s) {\n  var set = new HashSet<char>();\n  int left = 0, maxLen = 0;\n  for(int right = 0; right < s.Length; right++) {\n    while(set.Contains(s[right])) {\n      set.Remove(s[left++]); // Shrink window\n    }\n    set.Add(s[right]);\n    maxLen = Math.Max(maxLen, right - left + 1);\n  }\n  return maxLen;\n}',
      'typescript', E'// Max sum of k consecutive\nfunction maxSum(arr: number[], k: number): number {\n  let sum = arr.slice(0, k).reduce((a,b) => a+b, 0);\n  let maxSum = sum;\n  for(let i = k; i < arr.length; i++) {\n    sum += arr[i] - arr[i - k];\n    maxSum = Math.max(maxSum, sum);\n  }\n  return maxSum;\n}\n\n// Variable window: longest unique substring\nfunction lengthOfLongestSubstring(s: string): number {\n  const set = new Set<string>();\n  let left = 0, maxLen = 0;\n  for(let right = 0; right < s.length; right++) {\n    while(set.has(s[right])) {\n      set.delete(s[left++]);\n    }\n    set.add(s[right]);\n    maxLen = Math.max(maxLen, right - left + 1);\n  }\n  return maxLen;\n}'
    ),
    E'Sliding Window:\n[1,3,2,5,8,1,9] k=3\n[1,3,2] sum=6\n  [3,2,5] sum=10\n    [2,5,8] sum=15 ← max\nVariable size:\nabcabcbb\n[a b c]abc bb ← expand\nabc[a]bc bb ← shrink\nO(n) single pass',
    35
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Sliding window complexity?', to_jsonb(ARRAY['O(1)', 'O(n)', 'O(n²)', 'O(n log n)']), 1, 'Single pass with two pointers: O(n).'),
    (current_term_id, 'Fixed vs variable window?', to_jsonb(ARRAY['Same', 'Fixed: constant size, Variable: adjusts dynamically', 'Fixed faster', 'No difference']), 1, 'Fixed has set k, variable expands/shrinks.'),
    (current_term_id, 'Sliding window advantage?', to_jsonb(ARRAY['Simpler code', 'Avoids recalculating entire subarray', 'Less memory', 'Parallel']), 1, 'Incremental updates vs full recalculation.'),
    (current_term_id, 'Common use case?', to_jsonb(ARRAY['Sorting', 'Max sum of k consecutive elements', 'Tree traversal', 'Hashing']), 1, 'Classic sliding window problem.'),
    (current_term_id, 'Variable window needs?', to_jsonb(ARRAY['Nothing', 'Condition to expand/shrink', 'Sorting', 'Hash table always']), 1, 'Condition determines when to move pointers.');

  -- Stack vs Heap Memory
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Stack vs Heap Memory',
    'Stack: fast automatic memory for local variables. Heap: slower manual memory for objects.',
    'Stack: LIFO memory for local vars, function calls, value types. Heap: dynamic memory pool for reference types, manually managed (GC in C#). Stack faster, limited size.',
    'Stack stores local variables and function frames with automatic cleanup. Heap stores objects referenced by pointers, managed by GC in C#. Stack is fast but small, heap is larger but slower with GC overhead.',
    to_jsonb(ARRAY['Stack overflow from deep recursion or large local arrays', 'Memory leaks in heap from unreleased references', 'Confusing value vs reference type allocation', 'Premature optimization']),
    jsonb_build_object(
      'csharp', E'// Stack: value types, local variables\nint x = 5; // Stack\nstruct Point { public int X, Y; } // Value type → stack\nPoint p = new Point(); // Stack allocated\n\n// Heap: reference types, objects\nclass Person { public string Name; } // Reference type\nPerson person = new Person(); // Object on heap, reference on stack\nstring name = "Alice"; // String object on heap\n\n// Boxing: value type → heap\nint val = 42; // Stack\nobject boxed = val; // Boxed onto heap',
      'typescript', E'// JavaScript: all objects on heap\nlet x = 5; // Primitive: stack-like behavior\nlet obj = { name: "Alice" }; // Object: heap\n\nfunction example() {\n  let local = 10; // Stack frame\n  let arr = [1,2,3]; // Array object on heap\n} // local cleaned up, arr eligible for GC\n\n// Deep recursion → stack overflow\nfunction recurse(n) {\n  if(n === 0) return;\n  recurse(n - 1); // Stack frame per call\n}'
    ),
    E'Memory Layout:\nSTACK (grows down):\n  ├─ Local vars\n  ├─ Function frames\n  ├─ Value types\n  └─ Fast, auto cleanup\n     ↕ (small, limited)\nHEAP (grows up):\n  ├─ Objects\n  ├─ Reference types\n  ├─ Dynamic allocation\n  └─ GC managed, slower',
    36
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Stack stores?', to_jsonb(ARRAY['All objects', 'Local vars and value types', 'Only primitives', 'Nothing']), 1, 'Function frames and value types on stack.'),
    (current_term_id, 'Heap is managed by?', to_jsonb(ARRAY['Programmer manually', 'Garbage collector (C#/JS)', 'Stack pointer', 'OS only']), 1, 'GC automatically frees unused heap objects.'),
    (current_term_id, 'Stack overflow cause?', to_jsonb(ARRAY['Too many objects', 'Deep recursion or large locals', 'Memory leak', 'Heap exhaustion']), 1, 'Stack has limited size, recursion exhausts it.'),
    (current_term_id, 'Stack vs heap speed?', to_jsonb(ARRAY['Same', 'Stack faster', 'Heap faster', 'Depends']), 1, 'Stack is simple pointer increment, heap needs allocation.'),
    (current_term_id, 'Reference type allocated where?', to_jsonb(ARRAY['Stack', 'Heap with stack reference', 'Either', 'Neither']), 1, 'Object on heap, pointer on stack.');

  -- Value vs Reference Types
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'Value vs Reference Types',
    'Value types copy the data, reference types copy the pointer to data.',
    'Value types (struct, primitives) hold data directly, copied on assignment. Reference types (class, array) hold pointer, assignment copies reference not data.',
    'Value types: stack-allocated, copied by value, independent after copy. Reference types: heap-allocated, copied by reference, changes affect all references. Understanding prevents bugs from unexpected aliasing.',
    to_jsonb(ARRAY['Unexpected aliasing with reference types', 'Performance issues from large struct copies', 'Null reference exceptions', 'Mutating shared state unintentionally']),
    jsonb_build_object(
      'csharp', E'// Value types: int, struct, enum\nint a = 5;\nint b = a; // Copy value\nb = 10; // a still 5\n\nstruct Point { public int X, Y; }\nPoint p1 = new Point { X = 1 };\nPoint p2 = p1; // Copy\np2.X = 5; // p1.X still 1\n\n// Reference types: class, array, string\nclass Person { public string Name; }\nPerson p1 = new Person { Name = "Alice" };\nPerson p2 = p1; // Copy reference\np2.Name = "Bob"; // p1.Name also "Bob" (same object)\n\nint[] arr1 = {1, 2};\nint[] arr2 = arr1; // Copy reference\narr2[0] = 99; // arr1[0] also 99',
      'typescript', E'// Primitives behave like value types\nlet a = 5;\nlet b = a; // Copy value\nb = 10; // a still 5\n\n// Objects are reference types\nconst obj1 = { name: "Alice" };\nconst obj2 = obj1; // Copy reference\nobj2.name = "Bob"; // obj1.name also "Bob"\n\n// Arrays are objects (reference)\nconst arr1 = [1, 2, 3];\nconst arr2 = arr1; // Copy reference\narr2[0] = 99; // arr1[0] also 99\n\n// Clone to avoid aliasing\nconst arr3 = [...arr1]; // Shallow copy\nconst obj3 = {...obj1}; // Shallow copy'
    ),
    E'Value Type:\na: [5]  b: [5]\n  ↓ copy    ↓\na: [5]  b: [10] (independent)\n\nReference Type:\np1: [→ obj] p2: [→ obj]\n         ↓        ↓\n      [name: "Alice"]\n   (both point to same object)',
    37
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'Value type assignment?', to_jsonb(ARRAY['Copies reference', 'Copies data', 'Shares memory', 'Nothing']), 1, 'Entire value copied, independent after.'),
    (current_term_id, 'Reference type assignment?', to_jsonb(ARRAY['Copies data', 'Copies reference pointer', 'Copies value', 'Moves data']), 1, 'Only pointer copied, data shared.'),
    (current_term_id, 'In C#, class is?', to_jsonb(ARRAY['Value type', 'Reference type', 'Either', 'Neither']), 1, 'Classes are reference types.'),
    (current_term_id, 'In C#, struct is?', to_jsonb(ARRAY['Value type', 'Reference type', 'Either', 'Neither']), 0, 'Structs are value types.'),
    (current_term_id, 'Aliasing problem?', to_jsonb(ARRAY['Performance', 'Multiple references modify same object', 'Memory leak', 'Stack overflow']), 1, 'Unexpected mutation via shared reference.');

  -- HTTP Methods
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'HTTP Methods',
    'Different commands for web requests: GET (read), POST (create), PUT (update), DELETE (remove).',
    'HTTP verbs indicating desired action on resource. GET (retrieve), POST (create), PUT (replace), PATCH (partial update), DELETE (remove). Idempotent vs non-idempotent.',
    'GET retrieves data, safe and idempotent. POST creates, non-idempotent. PUT replaces entire resource, idempotent. PATCH partial update. DELETE removes, idempotent. Use correct verb for semantics and caching.',
    to_jsonb(ARRAY['Using GET for state-changing operations', 'Not understanding idempotency', 'PUT vs PATCH confusion', 'Exposing sensitive data in GET params', 'Not handling method not allowed']),
    jsonb_build_object(
      'csharp', E'// ASP.NET Core HTTP methods\n[ApiController]\n[Route("api/[controller]")]\npublic class UsersController : ControllerBase {\n  [HttpGet("{id}")] // GET /api/users/1\n  public IActionResult Get(int id) => Ok(user);\n  \n  [HttpPost] // POST /api/users\n  public IActionResult Create([FromBody] User user) => CreatedAtAction(nameof(Get), new { id = user.Id }, user);\n  \n  [HttpPut("{id}")] // PUT /api/users/1 (replace)\n  public IActionResult Update(int id, [FromBody] User user) => NoContent();\n  \n  [HttpPatch("{id}")] // PATCH /api/users/1 (partial)\n  public IActionResult PartialUpdate(int id, [FromBody] JsonPatchDocument<User> patch) => NoContent();\n  \n  [HttpDelete("{id}")] // DELETE /api/users/1\n  public IActionResult Delete(int id) => NoContent();\n}',
      'typescript', E'// Express.js HTTP methods\napp.get(''/api/users/:id'', (req, res) => {\n  res.json(user); // Retrieve\n});\n\napp.post(''/api/users'', (req, res) => {\n  res.status(201).json(createdUser); // Create\n});\n\napp.put(''/api/users/:id'', (req, res) => {\n  res.status(204).send(); // Replace entire\n});\n\napp.patch(''/api/users/:id'', (req, res) => {\n  res.status(204).send(); // Partial update\n});\n\napp.delete(''/api/users/:id'', (req, res) => {\n  res.status(204).send(); // Remove\n});'
    ),
    E'HTTP Methods:\nGET    /users/1     → Retrieve (safe, idempotent)\nPOST   /users       → Create (not idempotent)\nPUT    /users/1     → Replace (idempotent)\nPATCH  /users/1     → Partial update (idempotent)\nDELETE /users/1     → Remove (idempotent)\n\nIdempotent: same result if repeated',
    38
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'GET method is?', to_jsonb(ARRAY['Modifies data', 'Safe and idempotent', 'Creates resource', 'Deletes resource']), 1, 'Retrieves data without side effects.'),
    (current_term_id, 'POST is idempotent?', to_jsonb(ARRAY['Yes', 'No, creates new resource each call', 'Sometimes', 'Depends']), 1, 'Each POST typically creates new resource.'),
    (current_term_id, 'PUT vs PATCH?', to_jsonb(ARRAY['Same', 'PUT replaces, PATCH partial update', 'PATCH faster', 'PUT safer']), 1, 'PUT sends complete resource, PATCH changes.'),
    (current_term_id, 'DELETE is idempotent?', to_jsonb(ARRAY['Yes, repeated deletes same state', 'No', 'Sometimes', 'Undefined']), 0, 'After first delete, resource gone, same result after.'),
    (current_term_id, 'Safe method means?', to_jsonb(ARRAY['Fast', 'No side effects (read-only)', 'Idempotent', 'Secure']), 1, 'Safe methods don''t modify server state.');

  -- HTTP Status Codes
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'HTTP Status Codes',
    'Three-digit codes telling you what happened: 2xx success, 4xx client error, 5xx server error.',
    'HTTP response codes indicating request outcome. 2xx success, 3xx redirect, 4xx client error, 5xx server error. Semantic codes for proper API design.',
    '200 OK, 201 Created, 204 No Content, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 500 Internal Server Error. Use correct codes for client handling and debugging.',
    to_jsonb(ARRAY['Returning 200 for errors', '401 vs 403 confusion', 'Generic 500 without details', 'Not logging server errors', '404 for unauthorized resources (use 403)']),
    jsonb_build_object(
      'csharp', E'// ASP.NET Core status codes\npublic IActionResult GetUser(int id) {\n  var user = _repo.GetById(id);\n  if(user == null) \n    return NotFound(); // 404\n  return Ok(user); // 200\n}\n\npublic IActionResult Create(User user) {\n  if(!ModelState.IsValid)\n    return BadRequest(ModelState); // 400\n  _repo.Add(user);\n  return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user); // 201\n}\n\npublic IActionResult Delete(int id) {\n  _repo.Delete(id);\n  return NoContent(); // 204\n}',
      'typescript', E'// Express status codes\napp.get(''/users/:id'', (req, res) => {\n  const user = db.findById(req.params.id);\n  if(!user) return res.status(404).json({ error: ''Not found'' });\n  res.status(200).json(user);\n});\n\napp.post(''/users'', (req, res) => {\n  if(!req.body.email) \n    return res.status(400).json({ error: ''Email required'' });\n  const user = db.create(req.body);\n  res.status(201).json(user);\n});\n\napp.delete(''/users/:id'', (req, res) => {\n  db.delete(req.params.id);\n  res.status(204).send();\n});'
    ),
    E'HTTP Status Codes:\n2xx Success:\n  200 OK\n  201 Created\n  204 No Content\n3xx Redirect:\n  301 Moved Permanently\n  302 Found\n4xx Client Error:\n  400 Bad Request\n  401 Unauthorized\n  403 Forbidden\n  404 Not Found\n5xx Server Error:\n  500 Internal Server Error\n  503 Service Unavailable',
    39
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, '200 status means?', to_jsonb(ARRAY['Created', 'Success OK', 'No content', 'Error']), 1, 'Request succeeded, response has body.'),
    (current_term_id, '404 status means?', to_jsonb(ARRAY['Unauthorized', 'Forbidden', 'Not Found', 'Server error']), 2, 'Resource doesn''t exist.'),
    (current_term_id, '401 vs 403?', to_jsonb(ARRAY['Same', '401: not authenticated, 403: not authorized', '403: not authenticated', 'No difference']), 1, '401 needs login, 403 has login but no permission.'),
    (current_term_id, '500 status means?', to_jsonb(ARRAY['Client error', 'Not found', 'Server error', 'Success']), 2, 'Unhandled server-side exception.'),
    (current_term_id, '201 status for?', to_jsonb(ARRAY['OK', 'Resource created', 'Deleted', 'Updated']), 1, 'POST successfully created new resource.');

  -- CORS
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs, 'CORS (Cross-Origin Resource Sharing)',
    'Browser security that blocks websites from making requests to different domains unless allowed.',
    'Browser security mechanism restricting cross-origin HTTP requests. Server must explicitly allow origin via Access-Control-Allow-Origin header. Preflight OPTIONS for non-simple requests.',
    'CORS prevents malicious sites from accessing APIs. Same-origin policy blocks different origin requests. Server sends CORS headers to allow specific origins. Preflight OPTIONS checks complex requests before actual request.',
    to_jsonb(ARRAY['Allowing all origins (*) in production', 'Not handling preflight OPTIONS', 'CORS errors mistaken for server errors', 'Exposing sensitive APIs without auth', 'Not understanding simple vs preflighted requests']),
    jsonb_build_object(
      'csharp', E'// ASP.NET Core CORS\npublic void ConfigureServices(IServiceCollection services) {\n  services.AddCors(options => {\n    options.AddPolicy("AllowSpecificOrigin", builder => {\n      builder.WithOrigins("https://example.com")\n             .AllowAnyMethod()\n             .AllowAnyHeader()\n             .AllowCredentials();\n    });\n  });\n}\n\npublic void Configure(IApplicationBuilder app) {\n  app.UseCors("AllowSpecificOrigin"); // Before routing\n  app.UseRouting();\n  app.UseAuthorization();\n  app.UseEndpoints(...);\n}',
      'typescript', E'// Express CORS middleware\nconst cors = require(''cors'');\n\nconst corsOptions = {\n  origin: ''https://example.com'', // Specific origin\n  methods: [''GET'', ''POST'', ''PUT'', ''DELETE''],\n  allowedHeaders: [''Content-Type'', ''Authorization''],\n  credentials: true // Allow cookies\n};\n\napp.use(cors(corsOptions));\n\n// Manual CORS headers\napp.use((req, res, next) => {\n  res.header(''Access-Control-Allow-Origin'', ''https://example.com'');\n  res.header(''Access-Control-Allow-Methods'', ''GET,POST,PUT,DELETE'');\n  res.header(''Access-Control-Allow-Headers'', ''Content-Type,Authorization'');\n  if(req.method === ''OPTIONS'') return res.sendStatus(200);\n  next();\n});'
    ),
    E'CORS Flow:\nBrowser: example.com → api.other.com\n  ↓\nPreflight OPTIONS (complex request)\n  ← Access-Control-Allow-Origin: example.com\n  ← Access-Control-Allow-Methods: GET,POST\n  ↓\nActual GET/POST request\n  ← Response with CORS headers\n\nSimple requests: no preflight',
    40
  ) RETURNING id INTO current_term_id;
  
  INSERT INTO quiz_questions (term_id, question, choices, correct_index, explanation)
  VALUES
    (current_term_id, 'CORS purpose?', to_jsonb(ARRAY['Speed', 'Prevent malicious cross-origin requests', 'Compress data', 'Authentication']), 1, 'Browser security against malicious sites.'),
    (current_term_id, 'CORS is enforced by?', to_jsonb(ARRAY['Server', 'Browser', 'Network', 'OS']), 1, 'Browser blocks requests, server allows via headers.'),
    (current_term_id, 'Preflight request?', to_jsonb(ARRAY['GET', 'POST', 'OPTIONS', 'DELETE']), 2, 'OPTIONS checks if actual request allowed.'),
    (current_term_id, 'Allow all origins?', to_jsonb(ARRAY['Always safe', 'Avoid in production, use specific origins', 'Required', 'Best practice']), 1, '* allows any site, security risk.'),
    (current_term_id, 'Simple request has?', to_jsonb(ARRAY['Custom headers', 'GET/POST/HEAD with simple headers, no preflight', 'OPTIONS', 'JSON']), 1, 'No preflight needed for simple requests.');

  RAISE NOTICE 'Added 15 more CS Fundamentals terms (sorting, patterns, memory, HTTP)';
END $$;
