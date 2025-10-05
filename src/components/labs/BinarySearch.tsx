import { useState } from 'react';
import { CheckCircle, XCircle, Play } from 'lucide-react';

export function BinarySearch() {
  const [code, setCode] = useState(`function binarySearch(arr, target) {
  // Your code here
  // Remember: array is sorted
  // Use two pointers: left and right




  return -1; // return index if found, -1 if not found
}`);

  const [result, setResult] = useState<{ success: boolean; message: string } | null>(null);

  const runTests = () => {
    try {
      const func = eval(`(${code})`);

      const tests = [
        { arr: [1, 2, 3, 4, 5], target: 3, expected: 2 },
        { arr: [1, 2, 3, 4, 5], target: 1, expected: 0 },
        { arr: [1, 2, 3, 4, 5], target: 5, expected: 4 },
        { arr: [1, 2, 3, 4, 5], target: 6, expected: -1 },
        { arr: [1, 3, 5, 7, 9], target: 7, expected: 3 },
        { arr: [2, 4, 6, 8, 10, 12], target: 10, expected: 4 },
        { arr: [1], target: 1, expected: 0 },
        { arr: [], target: 1, expected: -1 }
      ];

      for (const test of tests) {
        const output = func(test.arr, test.target);
        if (output !== test.expected) {
          setResult({
            success: false,
            message: `Failed: binarySearch([${test.arr}], ${test.target}) returned ${output}, expected ${test.expected}`
          });
          return;
        }
      }

      setResult({
        success: true,
        message: 'All tests passed! You mastered binary search - O(log n) efficiency!'
      });
    } catch (error) {
      setResult({
        success: false,
        message: `Error: ${error instanceof Error ? error.message : 'Unknown error'}`
      });
    }
  };

  return (
    <div className="space-y-4">
      <div>
        <h2 className="text-2xl font-bold text-white mb-2">Binary Search</h2>
        <p className="text-gray-300 mb-4">
          Implement binary search to find an element in a sorted array. This is a fundamental algorithm that demonstrates divide-and-conquer.
        </p>

        <div className="bg-gray-900 border border-cyan-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-cyan-400 font-semibold mb-2">Problem:</h3>
          <p className="text-gray-300 text-sm mb-2">
            Given a sorted array and a target value, return the index of the target if found, otherwise return -1.
          </p>
          <div className="space-y-1 text-sm">
            <p className="text-gray-400">Example 1: binarySearch([1,2,3,4,5], 3) → 2</p>
            <p className="text-gray-400">Example 2: binarySearch([1,2,3,4,5], 6) → -1</p>
          </div>
        </div>

        <div className="bg-gray-900 border border-blue-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-blue-400 font-semibold mb-2">Algorithm Steps:</h3>
          <ol className="text-gray-300 text-sm space-y-1 list-decimal list-inside">
            <li>Initialize left = 0 and right = array.length - 1</li>
            <li>While left &lt;= right:</li>
            <li className="ml-4">Calculate mid = Math.floor((left + right) / 2)</li>
            <li className="ml-4">If arr[mid] === target, return mid</li>
            <li className="ml-4">If arr[mid] &lt; target, search right half (left = mid + 1)</li>
            <li className="ml-4">If arr[mid] &gt; target, search left half (right = mid - 1)</li>
            <li>If not found, return -1</li>
          </ol>
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-300 mb-2">
          Your Solution (JavaScript/TypeScript):
        </label>
        <textarea
          value={code}
          onChange={(e) => setCode(e.target.value)}
          className="w-full h-64 bg-gray-900 text-gray-100 font-mono text-sm p-4 rounded-lg border border-gray-700 focus:border-cyan-500 focus:outline-none"
          spellCheck={false}
        />
      </div>

      <button
        onClick={runTests}
        className="flex items-center gap-2 bg-cyan-600 hover:bg-cyan-500 text-white px-6 py-3 rounded-lg font-medium transition-colors"
      >
        <Play size={20} />
        Run Tests
      </button>

      {result && (
        <div className={`flex items-start gap-3 p-4 rounded-lg border ${
          result.success
            ? 'bg-green-900/20 border-green-500/50 text-green-300'
            : 'bg-red-900/20 border-red-500/50 text-red-300'
        }`}>
          {result.success ? <CheckCircle size={24} className="flex-shrink-0 mt-0.5" /> : <XCircle size={24} className="flex-shrink-0 mt-0.5" />}
          <p className="text-sm">{result.message}</p>
        </div>
      )}

      <div className="bg-gray-900 border border-gray-700 rounded-lg p-4">
        <h3 className="text-white font-semibold mb-2">Interview Tips:</h3>
        <ul className="text-gray-300 text-sm space-y-2 list-disc list-inside">
          <li>Time complexity: O(log n) - much faster than linear search O(n)</li>
          <li>Space complexity: O(1) iterative, O(log n) recursive</li>
          <li>Only works on sorted arrays!</li>
          <li>Common variants: find first/last occurrence, find closest element</li>
          <li>Watch for integer overflow: use mid = left + (right - left) / 2</li>
          <li>Can implement recursively or iteratively (iterative is better)</li>
        </ul>
      </div>
    </div>
  );
}
