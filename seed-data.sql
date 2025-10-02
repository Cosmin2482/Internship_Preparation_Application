-- Seed script for Internship Prep Super-App
-- This includes representative terms from all categories

-- Get category IDs for reference
DO $$
DECLARE
  cat_cs uuid;
  cat_oop uuid;
  cat_dotnet uuid;
  cat_sql uuid;
  cat_angular uuid;
  cat_arch uuid;
  cat_devops uuid;
  cat_ai uuid;
  cat_hr uuid;
BEGIN
  SELECT id INTO cat_cs FROM categories WHERE slug = 'cs-fundamentals';
  SELECT id INTO cat_oop FROM categories WHERE slug = 'oop';
  SELECT id INTO cat_dotnet FROM categories WHERE slug = 'dotnet';
  SELECT id INTO cat_sql FROM categories WHERE slug = 'sql';
  SELECT id INTO cat_angular FROM categories WHERE slug = 'angular';
  SELECT id INTO cat_arch FROM categories WHERE slug = 'architecture';
  SELECT id INTO cat_devops FROM categories WHERE slug = 'devops';
  SELECT id INTO cat_ai FROM categories WHERE slug = 'ai-ml';
  SELECT id INTO cat_hr FROM categories WHERE slug = 'hr';

  -- Insert CS Fundamentals terms
  -- Array
  INSERT INTO terms (category_id, term, eli5, formal_definition, interview_answer, pitfalls, code_examples, diagram, order_index)
  VALUES (
    cat_cs,
    'Array',
    'Think of an array like a row of numbered lockers. Each locker holds one item, and you can instantly open any locker if you know its number.',
    'An array is a contiguous block of memory that stores elements of the same type, accessible via zero-based indices in O(1) time.',
    'An array is a fundamental data structure that stores elements in contiguous memory locations. Arrays provide constant-time access by index, making lookups very fast. However, insertions and deletions can be expensive since elements may need to be shifted. Arrays are fixed-size in many languages, though some like C# provide dynamic arrays like List<T>.',
    '["Using arrays when you need frequent insertions/deletions (use List instead)", "Not checking bounds before access (IndexOutOfRangeException)", "Forgetting arrays are zero-indexed", "Confusing array.Length with list.Count", "Not initializing array elements (may contain default values)", "Creating very large arrays on the stack instead of heap", "Assuming arrays resize automatically"]',
    '{"csharp": "// Fixed-size array\nint[] numbers = new int[5];\nnumbers[0] = 10;\nnumbers[4] = 50;\n\n// Array with initializer\nstring[] names = { \"Alice\", \"Bob\", \"Charlie\" };\n\n// Multi-dimensional array\nint[,] matrix = new int[3, 3];\nmatrix[0, 0] = 1;\n\n// Jagged array (array of arrays)\nint[][] jagged = new int[3][];\njagged[0] = new int[] { 1, 2 };\njagged[1] = new int[] { 3, 4, 5 };\n\n// Common operations\nConsole.WriteLine($\"Length: {numbers.Length}\");\nArray.Sort(numbers);\nArray.Reverse(numbers);\nint index = Array.IndexOf(names, \"Bob\"); // Returns 1", "typescript": "// TypeScript arrays are dynamic\nconst numbers: number[] = [1, 2, 3, 4, 5];\nnumbers.push(6); // Add to end\nnumbers.pop(); // Remove from end\n\n// Generic syntax\nconst names: Array<string> = [\"Alice\", \"Bob\"];\n\n// Multi-dimensional (array of arrays)\nconst matrix: number[][] = [\n  [1, 2, 3],\n  [4, 5, 6]\n];\n\n// Common operations\nconsole.log(numbers.length);\nnumbers.sort((a, b) => a - b);\nnumbers.reverse();\nconst index = names.indexOf(\"Bob\"); // Returns 1\n\n// Useful methods\nconst doubled = numbers.map(n => n * 2);\nconst evens = numbers.filter(n => n % 2 === 0);\nconst sum = numbers.reduce((acc, n) => acc + n, 0);"}',
    '[Index 0][Index 1][Index 2][Index 3][Index 4]
  ↓       ↓       ↓       ↓       ↓
[ 10  ][ 23  ][ 47  ][ 15  ][ 92  ]

Memory: Contiguous block
Access Time: O(1) - Direct index calculation
Insert/Delete: O(n) - May require shifting elements',
    1
  );

END $$;
