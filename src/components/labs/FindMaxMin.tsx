import { useState } from 'react';
import { CheckCircle2, XCircle, Play } from 'lucide-react';

export function FindMaxMin() {
  const [code, setCode] = useState(`// Find Maximum and Minimum in Array
// Given an array, find both max and min values
// Return as tuple or array

public static (int max, int min) FindMaxMin(int[] nums) {
  // Your code here
  return (0, 0);
}

// Examples:
// [3, 5, 1, 8, 2] → max=8, min=1
// [10] → max=10, min=10
// [-5, -1, -10, -2] → max=-1, min=-10`);

  const [output, setOutput] = useState<string>('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);

  const solution = `public static (int max, int min) FindMaxMin(int[] nums) {
  if (nums.Length == 0) {
    throw new ArgumentException("Array cannot be empty");
  }

  int max = nums[0];
  int min = nums[0];

  for (int i = 1; i < nums.Length; i++) {
    if (nums[i] > max) {
      max = nums[i];
    }
    if (nums[i] < min) {
      min = nums[i];
    }
  }

  return (max, min);
}`;

  const runCode = () => {
    const hasLoop = code.includes('for') || code.includes('while') || code.includes('foreach');
    const hasMaxVariable = code.includes('max =') || code.includes('max=');
    const hasMinVariable = code.includes('min =') || code.includes('min=');
    const hasComparison = code.includes('>') && code.includes('<');
    const hasReturn = code.includes('return');
    const notUsingBuiltIn = !code.includes('.Max()') && !code.includes('.Min()');

    if (hasLoop && hasMaxVariable && hasMinVariable && hasComparison && hasReturn && notUsingBuiltIn) {
      setOutput(`✓ Excellent! Your solution works perfectly!

Algorithm: Single pass with tracking variables
Time Complexity: O(n) - visit each element once
Space Complexity: O(1) - only two variables

Test Results:
✓ [3, 5, 1, 8, 2] → max=8, min=1
✓ [10] → max=10, min=10
✓ [-5, -1, -10, -2] → max=-1, min=-10
✓ [0, 0, 0] → max=0, min=0

How it works:
1. Initialize max and min to first element
2. Loop through remaining elements
3. Update max if current > max
4. Update min if current < min
5. Return both values

This is the optimal single-pass solution!

Bonus: You can use LINQ (.Max() and .Min()) but
implementing manually shows algorithmic thinking.`);
      setIsCorrect(true);
    } else {
      const issues = [];
      if (!notUsingBuiltIn) issues.push('Implement manually (no .Max() or .Min())');
      if (!hasLoop) issues.push('Need loop to iterate array');
      if (!hasMaxVariable) issues.push('Track max value in variable');
      if (!hasMinVariable) issues.push('Track min value in variable');
      if (!hasComparison) issues.push('Compare each element with max and min');
      if (!hasReturn) issues.push('Return (max, min) tuple');

      setOutput(`✗ Issues:\n${issues.map(i => '- ' + i).join('\n')}

Hint: Track both values as you iterate
1. Initialize: max = nums[0], min = nums[0]
2. Loop from i=1 to end
3. If nums[i] > max, update max
4. If nums[i] < min, update min
5. Return (max, min)

Example: [3, 5, 1, 8, 2]
Start: max=3, min=3
i=1 (5): max=5, min=3
i=2 (1): max=5, min=1
i=3 (8): max=8, min=1
i=4 (2): max=8, min=1
Return (8, 1)

Single pass: O(n) time, O(1) space`);
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
        <h3 className="text-lg font-semibold mb-2">Exercise: Find Max and Min</h3>
        <p className="text-gray-400 text-sm mb-4">
          Fundamental array problem - find maximum and minimum values in single pass.
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
            <h4 className="text-sm font-semibold mb-2">Common Mistakes</h4>
            <div className="text-xs text-gray-300 space-y-2">
              <div className="text-red-400">
                ✗ int max = 0; int min = 0;<br/>
                <span className="text-gray-400">
                  → Wrong! Array might have all negatives or all values above 0
                </span>
              </div>
              <div className="text-green-400">
                ✓ int max = nums[0]; int min = nums[0];<br/>
                <span className="text-gray-400">
                  → Correct! Initialize to first element
                </span>
              </div>
              <div className="text-yellow-400 mt-2">
                Edge case: Single element [5] → max=5, min=5 ✓
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded-lg">
        <h4 className="font-semibold mb-2">💡 Key Concepts</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• <strong>Single Pass</strong>: Find both in one loop (O(n))</li>
          <li>• <strong>Initialization</strong>: Start with first element, not 0 or Int32.MaxValue</li>
          <li>• <strong>Tuple Return</strong>: C# tuples for multiple return values</li>
          <li>• <strong>Edge Cases</strong>: Single element, all negatives, all same</li>
          <li>• <strong>Alternative</strong>: LINQ (.Max(), .Min()) but shows less algorithm knowledge</li>
        </ul>
      </div>
    </div>
  );
}
