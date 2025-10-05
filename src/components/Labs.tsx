import { useState } from 'react';
import { Beaker, Play, Check, X, ChevronRight, Code2, Trophy, AlertCircle } from 'lucide-react';

interface TestCase {
  input: string;
  expected: string;
  description: string;
}

interface Lab {
  id: string;
  title: string;
  description: string;
  difficulty: 'easy' | 'medium' | 'hard';
  category: string;
  starterCode: string;
  solution: string;
  testCases: TestCase[];
  hints: string[];
}

const labs: Lab[] = [
  {
    id: 'fizzbuzz',
    title: 'FizzBuzz',
    description: 'Returnează "Fizz" pentru multipli de 3, "Buzz" pentru multipli de 5, "FizzBuzz" pentru multipli de ambele, altfel numărul.',
    difficulty: 'easy',
    category: 'Algorithms',
    starterCode: `function fizzBuzz(n) {
  // Your code here

}`,
    solution: `function fizzBuzz(n) {
  if (n % 15 === 0) return "FizzBuzz";
  if (n % 3 === 0) return "Fizz";
  if (n % 5 === 0) return "Buzz";
  return n.toString();
}`,
    testCases: [
      { input: '3', expected: 'Fizz', description: 'Multiple of 3' },
      { input: '5', expected: 'Buzz', description: 'Multiple of 5' },
      { input: '15', expected: 'FizzBuzz', description: 'Multiple of both' },
      { input: '7', expected: '7', description: 'Not a multiple' },
    ],
    hints: [
      'Check divisibility by 15 first',
      'Use modulo operator (%)',
      'Return string for numbers too'
    ]
  },
  {
    id: 'reverse-string',
    title: 'Reverse String',
    description: 'Inversează un string. Ex: "hello" → "olleh"',
    difficulty: 'easy',
    category: 'Strings',
    starterCode: `function reverseString(str) {
  // Your code here

}`,
    solution: `function reverseString(str) {
  return str.split('').reverse().join('');
}`,
    testCases: [
      { input: '"hello"', expected: 'olleh', description: 'Simple string' },
      { input: '"JavaScript"', expected: 'tpircSavaJ', description: 'Capitalization preserved' },
      { input: '"12345"', expected: '54321', description: 'Numbers' },
      { input: '""', expected: '', description: 'Empty string' },
    ],
    hints: [
      'Use split() to convert to array',
      'Use reverse() method',
      'Use join() to convert back'
    ]
  },
  {
    id: 'palindrome',
    title: 'Palindrome Checker',
    description: 'Verifică dacă un string este palindrom (se citește la fel în ambele sensuri).',
    difficulty: 'easy',
    category: 'Strings',
    starterCode: `function isPalindrome(str) {
  // Your code here

}`,
    solution: `function isPalindrome(str) {
  const cleaned = str.toLowerCase().replace(/[^a-z0-9]/g, '');
  return cleaned === cleaned.split('').reverse().join('');
}`,
    testCases: [
      { input: '"racecar"', expected: 'true', description: 'Simple palindrome' },
      { input: '"hello"', expected: 'false', description: 'Not palindrome' },
      { input: '"A man a plan a canal Panama"', expected: 'true', description: 'With spaces & caps' },
      { input: '"12321"', expected: 'true', description: 'Numbers' },
    ],
    hints: [
      'Convert to lowercase first',
      'Remove non-alphanumeric characters',
      'Compare with reversed version'
    ]
  },
  {
    id: 'two-sum',
    title: 'Two Sum',
    description: 'Găsește indicii celor două numere care însumează target. Ex: [2,7,11,15], target=9 → [0,1]',
    difficulty: 'medium',
    category: 'Arrays',
    starterCode: `function twoSum(nums, target) {
  // Your code here

}`,
    solution: `function twoSum(nums, target) {
  const map = new Map();
  for (let i = 0; i < nums.length; i++) {
    const complement = target - nums[i];
    if (map.has(complement)) {
      return [map.get(complement), i];
    }
    map.set(nums[i], i);
  }
  return [];
}`,
    testCases: [
      { input: '[2,7,11,15], 9', expected: '0,1', description: 'First two elements' },
      { input: '[3,2,4], 6', expected: '1,2', description: 'Last two elements' },
      { input: '[3,3], 6', expected: '0,1', description: 'Same number twice' },
      { input: '[1,2,3], 7', expected: '', description: 'No solution' },
    ],
    hints: [
      'Use a hash map for O(n) solution',
      'Store complement as you iterate',
      'Check if complement exists before adding'
    ]
  },
  {
    id: 'valid-parentheses',
    title: 'Valid Parentheses',
    description: 'Verifică dacă parantezele sunt balansate. Ex: "()" → true, "([)]" → false',
    difficulty: 'medium',
    category: 'Stack',
    starterCode: `function isValid(s) {
  // Your code here

}`,
    solution: `function isValid(s) {
  const stack = [];
  const pairs = { '(': ')', '[': ']', '{': '}' };
  for (const char of s) {
    if (pairs[char]) {
      stack.push(char);
    } else {
      const last = stack.pop();
      if (pairs[last] !== char) return false;
    }
  }
  return stack.length === 0;
}`,
    testCases: [
      { input: '"()"', expected: 'true', description: 'Simple valid' },
      { input: '"()[]{}"', expected: 'true', description: 'Multiple types' },
      { input: '"(]"', expected: 'false', description: 'Wrong closing' },
      { input: '"([)]"', expected: 'false', description: 'Interleaved' },
    ],
    hints: [
      'Use a stack data structure',
      'Push opening brackets',
      'Match closing brackets with stack top'
    ]
  },
  {
    id: 'max-number',
    title: 'Find Maximum',
    description: 'Găsește cel mai mare număr dintr-un array.',
    difficulty: 'easy',
    category: 'Arrays',
    starterCode: `function findMax(nums) {
  // Your code here

}`,
    solution: `function findMax(nums) {
  if (nums.length === 0) return null;
  let max = nums[0];
  for (let i = 1; i < nums.length; i++) {
    if (nums[i] > max) max = nums[i];
  }
  return max;
}`,
    testCases: [
      { input: '[1,5,3,9,2]', expected: '9', description: 'Mixed numbers' },
      { input: '[-5,-1,-10]', expected: '-1', description: 'Negative numbers' },
      { input: '[42]', expected: '42', description: 'Single element' },
      { input: '[3,3,3,3]', expected: '3', description: 'All same' },
    ],
    hints: [
      'Initialize max with first element',
      'Compare each element with current max',
      'Handle edge case of empty array'
    ]
  },
  {
    id: 'binary-search',
    title: 'Binary Search',
    description: 'Caută un element într-un array sortat folosind binary search. Returnează indexul sau -1.',
    difficulty: 'medium',
    category: 'Algorithms',
    starterCode: `function binarySearch(arr, target) {
  // Your code here

}`,
    solution: `function binarySearch(arr, target) {
  let left = 0;
  let right = arr.length - 1;
  while (left <= right) {
    const mid = Math.floor((left + right) / 2);
    if (arr[mid] === target) return mid;
    if (arr[mid] < target) left = mid + 1;
    else right = mid - 1;
  }
  return -1;
}`,
    testCases: [
      { input: '[1,2,3,4,5,6,7], 4', expected: '3', description: 'Found in middle' },
      { input: '[1,3,5,7,9], 1', expected: '0', description: 'Found at start' },
      { input: '[2,4,6,8,10], 10', expected: '4', description: 'Found at end' },
      { input: '[1,2,3,4,5], 6', expected: '-1', description: 'Not found' },
    ],
    hints: [
      'Use two pointers: left and right',
      'Calculate middle index',
      'Compare middle element with target'
    ]
  },
  {
    id: 'merge-sorted',
    title: 'Merge Sorted Arrays',
    description: 'Îmbină două array-uri sortate într-un singur array sortat.',
    difficulty: 'medium',
    category: 'Arrays',
    starterCode: `function mergeSorted(arr1, arr2) {
  // Your code here

}`,
    solution: `function mergeSorted(arr1, arr2) {
  const result = [];
  let i = 0, j = 0;
  while (i < arr1.length && j < arr2.length) {
    if (arr1[i] <= arr2[j]) {
      result.push(arr1[i++]);
    } else {
      result.push(arr2[j++]);
    }
  }
  return result.concat(arr1.slice(i)).concat(arr2.slice(j));
}`,
    testCases: [
      { input: '[1,3,5], [2,4,6]', expected: '1,2,3,4,5,6', description: 'Interleaved' },
      { input: '[1,2,3], [4,5,6]', expected: '1,2,3,4,5,6', description: 'Sequential' },
      { input: '[], [1,2,3]', expected: '1,2,3', description: 'One empty' },
      { input: '[1], [2]', expected: '1,2', description: 'Single elements' },
    ],
    hints: [
      'Use two pointers for both arrays',
      'Compare elements and pick smaller',
      'Append remaining elements'
    ]
  },
  {
    id: 'linked-list',
    title: 'Linked List Basics',
    description: 'Creează o funcție care returnează al n-lea element dintr-o listă înlănțuită simulată ca array.',
    difficulty: 'easy',
    category: 'Data Structures',
    starterCode: `function getNthElement(list, n) {
  // Your code here

}`,
    solution: `function getNthElement(list, n) {
  if (n < 0 || n >= list.length) return null;
  return list[n];
}`,
    testCases: [
      { input: '[10,20,30,40], 2', expected: '30', description: 'Middle element' },
      { input: '[5,15,25], 0', expected: '5', description: 'First element' },
      { input: '[1,2,3,4,5], 4', expected: '5', description: 'Last element' },
      { input: '[100], 1', expected: 'null', description: 'Out of bounds' },
    ],
    hints: [
      'Check if n is within bounds',
      'Return element at index n',
      'Return null for invalid index'
    ]
  },
  {
    id: 'oop-constructor',
    title: 'OOP: Constructor & Properties',
    description: 'Creează o clasă Person cu constructor(name, age) și metodă greet() care returnează "Hello, I\'m [name]".',
    difficulty: 'easy',
    category: 'OOP',
    starterCode: `class Person {
  // Your code here

}

// Test: const p = new Person("John", 25); p.greet();`,
    solution: `class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }

  greet() {
    return "Hello, I'm " + this.name;
  }
}`,
    testCases: [
      { input: '"John", 25', expected: "Hello, I'm John", description: 'Basic greeting' },
      { input: '"Alice", 30', expected: "Hello, I'm Alice", description: 'Different name' },
      { input: '"Bob", 20', expected: "Hello, I'm Bob", description: 'Another person' },
      { input: '"Eve", 28', expected: "Hello, I'm Eve", description: 'Short name' },
    ],
    hints: [
      'Use constructor to initialize properties',
      'Store name and age as instance properties',
      'greet() method should return a string'
    ]
  },
  {
    id: 'oop-inheritance',
    title: 'OOP: Inheritance & Polymorphism',
    description: 'Creează Shape cu area() și Rectangle extends Shape care calculează area corect.',
    difficulty: 'medium',
    category: 'OOP',
    starterCode: `class Shape {
  area() {
    return 0;
  }
}

class Rectangle extends Shape {
  // Your code here

}

// Test: const r = new Rectangle(5, 10); r.area();`,
    solution: `class Shape {
  area() {
    return 0;
  }
}

class Rectangle extends Shape {
  constructor(width, height) {
    super();
    this.width = width;
    this.height = height;
  }

  area() {
    return this.width * this.height;
  }
}`,
    testCases: [
      { input: '5, 10', expected: '50', description: 'Rectangle 5x10' },
      { input: '3, 7', expected: '21', description: 'Rectangle 3x7' },
      { input: '4, 4', expected: '16', description: 'Square 4x4' },
      { input: '1, 100', expected: '100', description: 'Thin rectangle' },
    ],
    hints: [
      'Extend Shape class',
      'Override area() method',
      'Calculate width * height'
    ]
  },
  {
    id: 'oop-interface',
    title: 'OOP: Interface Implementation',
    description: 'Creează o clasă Calculator cu metodele add(a,b), subtract(a,b), multiply(a,b).',
    difficulty: 'easy',
    category: 'OOP',
    starterCode: `class Calculator {
  // Your code here

}

// Test: const c = new Calculator(); c.add(5, 3);`,
    solution: `class Calculator {
  add(a, b) {
    return a + b;
  }

  subtract(a, b) {
    return a - b;
  }

  multiply(a, b) {
    return a * b;
  }
}`,
    testCases: [
      { input: '5, 3', expected: '8', description: 'Addition' },
      { input: '10, 4', expected: '6', description: 'Subtraction (using subtract)' },
      { input: '6, 7', expected: '42', description: 'Multiplication (using multiply)' },
      { input: '0, 5', expected: '5', description: 'Add with zero' },
    ],
    hints: [
      'Implement three methods',
      'add returns a + b',
      'subtract returns a - b, multiply returns a * b'
    ]
  },
  {
    id: 'sql-select',
    title: 'SQL: Basic SELECT',
    description: 'Scrie o funcție care simulează SELECT * FROM users WHERE age > minAge',
    difficulty: 'easy',
    category: 'SQL',
    starterCode: `function selectUsers(users, minAge) {
  // Filter users where age > minAge
  // Return filtered array

}`,
    solution: `function selectUsers(users, minAge) {
  return users.filter(u => u.age > minAge);
}`,
    testCases: [
      { input: '[{"name":"John","age":25},{"name":"Jane","age":30}], 20', expected: '2', description: 'Both match' },
      { input: '[{"name":"John","age":25},{"name":"Jane","age":30}], 26', expected: '1', description: 'One match' },
      { input: '[{"name":"John","age":25},{"name":"Jane","age":30}], 40', expected: '0', description: 'None match' },
      { input: '[{"name":"Alice","age":35}], 30', expected: '1', description: 'Single match' },
    ],
    hints: [
      'Use filter() method',
      'Check age > minAge',
      'Return filtered array length for test'
    ]
  },
  {
    id: 'sql-join',
    title: 'SQL: JOIN Simulation',
    description: 'Simulează INNER JOIN între users și orders bazat pe userId',
    difficulty: 'medium',
    category: 'SQL',
    starterCode: `function joinTables(users, orders) {
  // Join users with orders on userId
  // Return array of {userName, orderTotal}

}`,
    solution: `function joinTables(users, orders) {
  return orders.map(order => {
    const user = users.find(u => u.id === order.userId);
    return { userName: user?.name || 'Unknown', orderTotal: order.total };
  });
}`,
    testCases: [
      { input: '[{"id":1,"name":"John"}], [{"userId":1,"total":100}]', expected: '1', description: 'Single join' },
      { input: '[{"id":1,"name":"John"},{"id":2,"name":"Jane"}], [{"userId":1,"total":50},{"userId":2,"total":75}]', expected: '2', description: 'Multiple joins' },
      { input: '[{"id":1,"name":"John"}], []', expected: '0', description: 'No orders' },
      { input: '[{"id":1,"name":"John"}], [{"userId":1,"total":25},{"userId":1,"total":50}]', expected: '2', description: 'Multiple orders same user' },
    ],
    hints: [
      'Use map() on orders',
      'Find matching user for each order',
      'Combine user and order data'
    ]
  },
  {
    id: 'sql-aggregate',
    title: 'SQL: COUNT & SUM',
    description: 'Calculează suma totală a orderelor (SUM) și numărul de ordere (COUNT)',
    difficulty: 'easy',
    category: 'SQL',
    starterCode: `function aggregateOrders(orders) {
  // Return {count: number, sum: total}

}`,
    solution: `function aggregateOrders(orders) {
  return {
    count: orders.length,
    sum: orders.reduce((acc, o) => acc + o.total, 0)
  };
}`,
    testCases: [
      { input: '[{"total":100},{"total":200}]', expected: '2,300', description: 'Two orders' },
      { input: '[{"total":50},{"total":50},{"total":50}]', expected: '3,150', description: 'Three orders' },
      { input: '[{"total":1000}]', expected: '1,1000', description: 'Single order' },
      { input: '[]', expected: '0,0', description: 'No orders' },
    ],
    hints: [
      'Use length for COUNT',
      'Use reduce() for SUM',
      'Return object with both values'
    ]
  },
  {
    id: 'sql-group-by',
    title: 'SQL: GROUP BY Simulation',
    description: 'Grupează ordere după userId și calculează total per user',
    difficulty: 'medium',
    category: 'SQL',
    starterCode: `function groupByUser(orders) {
  // Group by userId and sum totals
  // Return array of {userId, total}

}`,
    solution: `function groupByUser(orders) {
  const groups = {};
  orders.forEach(o => {
    if (!groups[o.userId]) groups[o.userId] = 0;
    groups[o.userId] += o.total;
  });
  return Object.entries(groups).map(([userId, total]) => ({userId: Number(userId), total}));
}`,
    testCases: [
      { input: '[{"userId":1,"total":100},{"userId":1,"total":50}]', expected: '1', description: 'One user, two orders' },
      { input: '[{"userId":1,"total":100},{"userId":2,"total":200}]', expected: '2', description: 'Two users' },
      { input: '[{"userId":1,"total":50},{"userId":2,"total":75},{"userId":1,"total":25}]', expected: '2', description: 'Mixed orders' },
      { input: '[]', expected: '0', description: 'Empty' },
    ],
    hints: [
      'Use object to store groups',
      'Accumulate totals per userId',
      'Convert object to array'
    ]
  },
];

export function Labs() {
  const [selectedLab, setSelectedLab] = useState<Lab | null>(null);
  const [code, setCode] = useState('');
  const [testResults, setTestResults] = useState<Array<{ passed: boolean; message: string }>>([]);
  const [showSolution, setShowSolution] = useState(false);
  const [showHints, setShowHints] = useState(false);

  const selectLab = (lab: Lab) => {
    setSelectedLab(lab);
    setCode(lab.starterCode);
    setTestResults([]);
    setShowSolution(false);
    setShowHints(false);
  };

  const runTests = () => {
    if (!selectedLab) return;

    try {
      // Evaluate code (supports both functions and classes)
      const evaluatedCode = new Function(code + '; return ' + (code.includes('class') ? code.match(/class (\w+)/)?.[1] : code.match(/function (\w+)/)?.[1]))();

      const results = selectedLab.testCases.map(testCase => {
        try {
          // Parse input
          const args = testCase.input.split(',').map(arg => {
            const trimmed = arg.trim();
            if (trimmed.startsWith('[')) {
              return JSON.parse(trimmed);
            }
            if (trimmed.startsWith('"')) {
              return trimmed.slice(1, -1);
            }
            return trimmed === '' ? null : Number(trimmed);
          });

          let result;
          // Check if it's a class (OOP exercise)
          if (selectedLab.category === 'OOP') {
            const instance = new evaluatedCode(...args);
            // For OOP exercises, test specific methods
            if (selectedLab.id === 'oop-constructor') {
              result = instance.greet();
            } else if (selectedLab.id === 'oop-inheritance') {
              result = instance.area();
            } else if (selectedLab.id === 'oop-interface') {
              result = instance.add(args[0], args[1]);
            }
          } else {
            // Regular function
            result = evaluatedCode(...args);
          }

          // Compare result - handle different types
          let resultStr;
          if (selectedLab.category === 'SQL') {
            // For SQL exercises, handle special cases
            if (selectedLab.id === 'sql-select' || selectedLab.id === 'sql-join' || selectedLab.id === 'sql-group-by') {
              resultStr = Array.isArray(result) ? String(result.length) : '0';
            } else if (selectedLab.id === 'sql-aggregate') {
              resultStr = result.count + ',' + result.sum;
            }
          } else if (Array.isArray(result)) {
            resultStr = result.join(',');
          } else if (typeof result === 'object' && result !== null) {
            resultStr = Object.values(result).join(',');
          } else {
            resultStr = String(result);
          }
          const passed = resultStr === testCase.expected;

          return {
            passed,
            message: passed
              ? `✓ ${testCase.description}`
              : `✗ ${testCase.description}: Expected "${testCase.expected}", got "${resultStr}"`
          };
        } catch (err) {
          return {
            passed: false,
            message: `✗ ${testCase.description}: ${err instanceof Error ? err.message : 'Error'}`
          };
        }
      });

      setTestResults(results);
    } catch (err) {
      setTestResults([{
        passed: false,
        message: `Syntax Error: ${err instanceof Error ? err.message : 'Invalid code'}`
      }]);
    }
  };

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'easy': return 'text-green-400 bg-green-900/30 border-green-700';
      case 'medium': return 'text-yellow-400 bg-yellow-900/30 border-yellow-700';
      case 'hard': return 'text-red-400 bg-red-900/30 border-red-700';
      default: return 'text-gray-400 bg-gray-900/30 border-gray-700';
    }
  };

  const allTestsPassed = testResults.length > 0 && testResults.every(r => r.passed);

  if (!selectedLab) {
    return (
      <div className="max-w-7xl mx-auto space-y-6">
        <div className="bg-gradient-to-r from-cyan-600 to-blue-600 rounded-xl p-8 text-white">
          <div className="flex items-center gap-3">
            <Beaker size={40} />
            <div>
              <h1 className="text-4xl font-bold mb-2">Interactive Coding Labs</h1>
              <p className="text-cyan-100">Practice algorithms & data structures with instant validation</p>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {labs.map(lab => (
            <button
              key={lab.id}
              onClick={() => selectLab(lab)}
              className="bg-gray-800 hover:bg-gray-750 border border-gray-700 rounded-xl p-6 text-left transition-all transform hover:scale-105"
            >
              <div className="flex items-start justify-between mb-3">
                <h3 className="text-xl font-bold text-white">{lab.title}</h3>
                <span className={`px-2 py-1 text-xs font-semibold rounded border ${getDifficultyColor(lab.difficulty)}`}>
                  {lab.difficulty}
                </span>
              </div>
              <p className="text-gray-300 text-sm mb-3">{lab.description}</p>
              <div className="flex items-center justify-between">
                <span className="text-xs text-cyan-400 bg-cyan-900/30 px-2 py-1 rounded">
                  {lab.category}
                </span>
                <ChevronRight className="text-gray-500" size={20} />
              </div>
            </button>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto space-y-6">
      <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-3">
            <button
              onClick={() => setSelectedLab(null)}
              className="text-cyan-400 hover:text-cyan-300 transition-colors"
            >
              ← Back to Labs
            </button>
          </div>
          <span className={`px-3 py-1 text-sm font-semibold rounded border ${getDifficultyColor(selectedLab.difficulty)}`}>
            {selectedLab.difficulty}
          </span>
        </div>

        <h2 className="text-3xl font-bold text-white mb-2">{selectedLab.title}</h2>
        <p className="text-gray-300 mb-4">{selectedLab.description}</p>

        <div className="flex gap-2 mb-4">
          <button
            onClick={() => setShowHints(!showHints)}
            className="px-4 py-2 bg-yellow-600/20 hover:bg-yellow-600/30 border border-yellow-700 text-yellow-400 rounded-lg transition-colors text-sm"
          >
            {showHints ? 'Hide' : 'Show'} Hints ({selectedLab.hints.length})
          </button>
          <button
            onClick={() => setShowSolution(!showSolution)}
            className="px-4 py-2 bg-red-600/20 hover:bg-red-600/30 border border-red-700 text-red-400 rounded-lg transition-colors text-sm"
          >
            {showSolution ? 'Hide' : 'Show'} Solution
          </button>
        </div>

        {showHints && (
          <div className="bg-yellow-900/20 border border-yellow-700 rounded-lg p-4 mb-4">
            <h4 className="text-yellow-400 font-semibold mb-2 flex items-center gap-2">
              <AlertCircle size={18} />
              Hints:
            </h4>
            <ul className="space-y-1 text-sm text-gray-300">
              {selectedLab.hints.map((hint, idx) => (
                <li key={idx}>• {hint}</li>
              ))}
            </ul>
          </div>
        )}

        {showSolution && (
          <div className="bg-gray-900 rounded-lg p-4 mb-4 border border-gray-700">
            <h4 className="text-white font-semibold mb-2">Solution:</h4>
            <pre className="text-sm text-cyan-400 overflow-x-auto">
              <code>{selectedLab.solution}</code>
            </pre>
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="space-y-4">
          <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
            <div className="flex items-center gap-2 mb-4">
              <Code2 className="text-cyan-400" size={24} />
              <h3 className="text-xl font-bold text-white">Your Code</h3>
            </div>
            <textarea
              value={code}
              onChange={(e) => setCode(e.target.value)}
              className="w-full h-64 bg-gray-900 text-gray-100 font-mono text-sm p-4 rounded-lg border border-gray-700 focus:border-cyan-500 focus:outline-none resize-none"
              spellCheck={false}
            />
            <button
              onClick={runTests}
              className="w-full mt-4 px-6 py-3 bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 text-white font-semibold rounded-lg transition-all flex items-center justify-center gap-2"
            >
              <Play size={20} />
              Run Tests
            </button>
          </div>
        </div>

        <div className="space-y-4">
          <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
            <h3 className="text-xl font-bold text-white mb-4">Test Cases</h3>
            {testResults.length === 0 ? (
              <p className="text-gray-400 text-sm">Run tests to see results...</p>
            ) : (
              <div className="space-y-2">
                {testResults.map((result, idx) => (
                  <div
                    key={idx}
                    className={`p-3 rounded-lg border flex items-start gap-2 ${
                      result.passed
                        ? 'bg-green-900/20 border-green-700 text-green-400'
                        : 'bg-red-900/20 border-red-700 text-red-400'
                    }`}
                  >
                    {result.passed ? <Check size={20} className="shrink-0 mt-0.5" /> : <X size={20} className="shrink-0 mt-0.5" />}
                    <span className="text-sm">{result.message}</span>
                  </div>
                ))}
              </div>
            )}

            {allTestsPassed && (
              <div className="mt-4 p-4 bg-gradient-to-r from-green-600/20 to-teal-600/20 border-2 border-green-500 rounded-lg">
                <div className="flex items-center gap-2 text-green-400">
                  <Trophy size={24} />
                  <div>
                    <h4 className="font-bold">Perfect! All tests passed! 🎉</h4>
                    <p className="text-sm text-gray-300">Great job! Try another lab to keep practicing.</p>
                  </div>
                </div>
              </div>
            )}
          </div>

          <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
            <h3 className="text-xl font-bold text-white mb-4">Test Inputs</h3>
            <div className="space-y-2">
              {selectedLab.testCases.map((testCase, idx) => (
                <div key={idx} className="bg-gray-900 rounded-lg p-3 border border-gray-700">
                  <div className="flex items-start justify-between gap-2">
                    <div className="flex-1">
                      <span className="text-cyan-400 text-sm font-mono">Input: {testCase.input}</span>
                      <br />
                      <span className="text-green-400 text-sm font-mono">Expected: {testCase.expected}</span>
                    </div>
                    <span className="text-xs text-gray-500">{testCase.description}</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
