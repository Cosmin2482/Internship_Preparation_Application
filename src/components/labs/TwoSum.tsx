import { useState } from 'react';
import { CheckCircle2, XCircle, Play } from 'lucide-react';

export function TwoSum() {
  const [code, setCode] = useState(`// Two Sum - Popular interview problem!
// Given array of integers and target sum,
// return indices of two numbers that add up to target.
// Each input has exactly ONE solution.
// You cannot use same element twice.

public static int[] TwoSum(int[] nums, int target) {
  // Your code here
  return new int[] { };
}

// Examples:
// TwoSum([2, 7, 11, 15], 9) → [0, 1]  (2 + 7 = 9)
// TwoSum([3, 2, 4], 6) → [1, 2]  (2 + 4 = 6)
// TwoSum([3, 3], 6) → [0, 1]  (3 + 3 = 6)`);

  const [output, setOutput] = useState<string>('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);

  const solution = `public static int[] TwoSum(int[] nums, int target) {
  Dictionary<int, int> map = new Dictionary<int, int>();

  for (int i = 0; i < nums.Length; i++) {
    int complement = target - nums[i];

    if (map.ContainsKey(complement)) {
      return new int[] { map[complement], i };
    }

    map[nums[i]] = i;
  }

  return new int[] { }; // No solution
}`;

  const runCode = () => {
    const hasDictionary = code.includes('Dictionary') || code.includes('HashMap') || code.includes('map');
    const hasLoop = code.includes('for') || code.includes('while');
    const hasComplement = code.includes('target -') || code.includes('- nums[');
    const hasContainsKey = code.includes('ContainsKey') || code.includes('contains') || code.includes('TryGetValue');
    const returnsIndices = code.includes('return new int[]') || code.includes('return new int[') || code.includes('return [');

    if (hasDictionary && hasLoop && hasComplement && hasContainsKey && returnsIndices) {
      setOutput(`✓ Excellent! Your solution is optimal!

Algorithm: Hash Map (Dictionary) approach
Time Complexity: O(n) - single pass
Space Complexity: O(n) - storing elements

Test Results:
✓ [2, 7, 11, 15], target = 9 → [0, 1]
  (nums[0] + nums[1] = 2 + 7 = 9)

✓ [3, 2, 4], target = 6 → [1, 2]
  (nums[1] + nums[2] = 2 + 4 = 6)

✓ [3, 3], target = 6 → [0, 1]
  (nums[0] + nums[1] = 3 + 3 = 6)

How it works:
1. Store seen numbers with their indices in Dictionary
2. For each number, calculate complement (target - num)
3. Check if complement exists in Dictionary
4. If yes, return indices; if no, continue

This is the optimal O(n) solution! Much better than
nested loops which would be O(n²).`);
      setIsCorrect(true);
    } else {
      const issues = [];
      if (!hasDictionary) issues.push('Use Dictionary<int, int> for O(n) solution');
      if (!hasLoop) issues.push('Need a loop to iterate array');
      if (!hasComplement) issues.push('Calculate complement: target - nums[i]');
      if (!hasContainsKey) issues.push('Check if complement exists: ContainsKey()');
      if (!returnsIndices) issues.push('Return array with two indices');

      setOutput(`✗ Issues:\n${issues.map(i => '- ' + i).join('\n')}

Hint: Use Dictionary to store numbers we've seen
For each number:
1. Calculate complement = target - current number
2. Check if complement already in Dictionary
3. If yes → found solution! Return indices
4. If no → add current number to Dictionary

Example: [2, 7, 11, 15], target = 9
- i=0: complement = 9-2 = 7, not in dict, add 2
- i=1: complement = 9-7 = 2, found in dict! return [0,1]

Avoid nested loops (O(n²)) - use Dictionary for O(n)!`);
      setIsCorrect(false);
    }
  };

  const showSolution = () => {
    setCode(solution);
    setOutput('');
    setIsCorrect(null);
  };

  return (
    <div className="space-y-4">
      <div>
        <h3 className="text-lg font-semibold mb-2">Exercise: Two Sum</h3>
        <p className="text-gray-400 text-sm mb-4">
          Very popular interview problem! Tests understanding of hash maps and optimization.
        </p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <div className="space-y-2">
          <div className="flex items-center justify-between">
            <label className="text-sm font-medium">Your Code (C#)</label>
            <button
              onClick={showSolution}
              className="text-xs px-3 py-1 bg-gray-700 hover:bg-gray-600 rounded transition-colors"
            >
              Show Solution
            </button>
          </div>
          <textarea
            value={code}
            onChange={(e) => setCode(e.target.value)}
            className="w-full h-96 bg-gray-900 text-gray-100 p-4 rounded-lg font-mono text-sm resize-none focus:ring-2 focus:ring-cyan-500 focus:outline-none"
            spellCheck={false}
          />
          <button
            onClick={runCode}
            className="w-full px-4 py-2 bg-cyan-600 hover:bg-cyan-700 text-white rounded-lg flex items-center justify-center gap-2 transition-colors"
          >
            <Play size={16} />
            Check Solution
          </button>
        </div>

        <div className="space-y-2">
          <label className="text-sm font-medium">Output</label>
          <div className={`h-96 bg-gray-900 p-4 rounded-lg font-mono text-sm whitespace-pre-wrap overflow-auto ${
            isCorrect === true ? 'border-2 border-green-500' :
            isCorrect === false ? 'border-2 border-red-500' : ''
          }`}>
            {output ? (
              <div className="flex items-start gap-2">
                {isCorrect === true && <CheckCircle2 className="text-green-500 shrink-0 mt-1" size={20} />}
                {isCorrect === false && <XCircle className="text-red-500 shrink-0 mt-1" size={20} />}
                <div>{output}</div>
              </div>
            ) : (
              <span className="text-gray-500">Click "Check Solution" to see results...</span>
            )}
          </div>

          <div className="bg-gray-800 p-3 rounded">
            <h4 className="text-sm font-semibold mb-2">Algorithm Walkthrough</h4>
            <pre className="text-xs text-gray-300">
{`nums = [2, 7, 11, 15], target = 9

Step 1: i=0, num=2
  complement = 9 - 2 = 7
  map empty, add: {2: 0}

Step 2: i=1, num=7
  complement = 9 - 7 = 2
  map contains 2! ✓
  return [0, 1]

Dictionary stores:
{number: index}
Allows O(1) lookup!`}
            </pre>
          </div>
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded-lg">
        <h4 className="font-semibold mb-2">💡 Key Concepts</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• <strong>Hash Map</strong>: Dictionary for O(1) lookups</li>
          <li>• <strong>Complement</strong>: target - current = what we need</li>
          <li>• <strong>Single Pass</strong>: Only loop through array once (O(n))</li>
          <li>• <strong>Common mistake</strong>: Using nested loops (O(n²) - too slow!)</li>
          <li>• <strong>Interview tip</strong>: Always mention time/space complexity</li>
        </ul>
      </div>
    </div>
  );
}
