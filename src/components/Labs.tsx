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
      // Create function from code
      const userFunction = new Function('return ' + code)();

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

          // Run function
          const result = userFunction(...args);

          // Compare result
          const resultStr = Array.isArray(result) ? result.join(',') : String(result);
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
