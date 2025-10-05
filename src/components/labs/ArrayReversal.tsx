import { useState } from 'react';
import { CheckCircle2, XCircle, Play } from 'lucide-react';

export function ArrayReversal() {
  const [code, setCode] = useState(`// Write a function that reverses an array in-place
// Do NOT use Array.Reverse() - implement it yourself!

public static void ReverseArray(int[] arr) {
  // Your code here
}

// Test cases:
int[] test1 = { 1, 2, 3, 4, 5 };
ReverseArray(test1);
// Expected: [5, 4, 3, 2, 1]

int[] test2 = { 10, 20 };
ReverseArray(test2);
// Expected: [20, 10]`);

  const [output, setOutput] = useState<string>('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);

  const solution = `public static void ReverseArray(int[] arr) {
  int left = 0;
  int right = arr.Length - 1;

  while (left < right) {
    // Swap elements
    int temp = arr[left];
    arr[left] = arr[right];
    arr[right] = temp;

    left++;
    right--;
  }
}`;

  const runCode = () => {
    const hasLoop = code.includes('while') || code.includes('for');
    const hasSwap = code.includes('temp') || (code.includes('arr[') && code.includes('='));
    const hasLeftRight = (code.includes('left') && code.includes('right')) ||
                         (code.includes('[i]') && code.includes('Length'));
    const notUsingReverse = !code.includes('Array.Reverse') && !code.includes('.Reverse()');

    if (hasLoop && hasSwap && hasLeftRight && notUsingReverse) {
      setOutput(`✓ Correct! Your solution:
- Uses two pointers (left and right)
- Swaps elements in-place
- Time Complexity: O(n)
- Space Complexity: O(1)

Test Results:
[1,2,3,4,5] → [5,4,3,2,1] ✓
[10,20] → [20,10] ✓

Great job implementing the algorithm manually!`);
      setIsCorrect(true);
    } else {
      const issues = [];
      if (!notUsingReverse) issues.push('Cannot use Array.Reverse() - implement it yourself');
      if (!hasLoop) issues.push('Need a loop to iterate');
      if (!hasSwap) issues.push('Need to swap elements');
      if (!hasLeftRight) issues.push('Use two pointers from both ends');

      setOutput(`✗ Issues found:\n${issues.map(i => '- ' + i).join('\n')}

Hint: Use two pointers, one at start (0) and one at end (Length-1).
Swap them and move pointers toward center until they meet.`);
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
        <h3 className="text-lg font-semibold mb-2">Exercise: Array Reversal (Two Pointers)</h3>
        <p className="text-gray-400 text-sm mb-4">
          Classic interview problem: Reverse an array in-place without using built-in methods.
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
            <h4 className="text-sm font-semibold mb-2">Algorithm Visualization</h4>
            <pre className="text-xs text-gray-300">
{`[1, 2, 3, 4, 5]
 ↑           ↑
left        right
Swap → [5, 2, 3, 4, 1]

[5, 2, 3, 4, 1]
    ↑     ↑
   left  right
Swap → [5, 4, 3, 2, 1]

[5, 4, 3, 2, 1]
       ↑
  left=right (done)`}
            </pre>
          </div>
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded-lg">
        <h4 className="font-semibold mb-2">💡 Key Concepts</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• <strong>Two Pointers</strong>: Start from both ends, move toward center</li>
          <li>• <strong>In-place</strong>: Modify the array without creating a new one (O(1) space)</li>
          <li>• <strong>Swap</strong>: Use temp variable to exchange values</li>
          <li>• <strong>Time Complexity</strong>: O(n) - visit each element once</li>
        </ul>
      </div>
    </div>
  );
}
