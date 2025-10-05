import { useState } from 'react';
import { CheckCircle, XCircle, Play } from 'lucide-react';

export function MergeSortedArrays() {
  const [code, setCode] = useState(`function mergeSortedArrays(arr1, arr2) {
  // Your code here




  return [];
}`);

  const [result, setResult] = useState<{ success: boolean; message: string } | null>(null);

  const runTests = () => {
    try {
      const func = eval(`(${code})`);

      const tests = [
        { arr1: [1, 3, 5], arr2: [2, 4, 6], expected: [1, 2, 3, 4, 5, 6] },
        { arr1: [1, 2, 3], arr2: [4, 5, 6], expected: [1, 2, 3, 4, 5, 6] },
        { arr1: [], arr2: [1, 2], expected: [1, 2] },
        { arr1: [1, 5, 9], arr2: [2, 3, 8], expected: [1, 2, 3, 5, 8, 9] },
        { arr1: [0], arr2: [1], expected: [0, 1] }
      ];

      for (const test of tests) {
        const output = func(test.arr1, test.arr2);
        if (JSON.stringify(output) !== JSON.stringify(test.expected)) {
          setResult({
            success: false,
            message: `Failed: mergeSortedArrays([${test.arr1}], [${test.arr2}]) returned [${output}], expected [${test.expected}]`
          });
          return;
        }
      }

      setResult({
        success: true,
        message: 'All tests passed! Great job merging sorted arrays efficiently.'
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
        <h2 className="text-2xl font-bold text-white mb-2">Merge Two Sorted Arrays</h2>
        <p className="text-gray-300 mb-4">
          Given two sorted arrays, merge them into one sorted array. Use the two-pointer technique for O(n + m) time complexity.
        </p>

        <div className="bg-gray-900 border border-cyan-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-cyan-400 font-semibold mb-2">Problem:</h3>
          <p className="text-gray-300 text-sm mb-2">
            Write a function that takes two sorted arrays and returns a single sorted array containing all elements.
          </p>
          <div className="space-y-1 text-sm">
            <p className="text-gray-400">Example 1: mergeSortedArrays([1,3,5], [2,4,6]) → [1,2,3,4,5,6]</p>
            <p className="text-gray-400">Example 2: mergeSortedArrays([1,2,3], [4,5,6]) → [1,2,3,4,5,6]</p>
          </div>
        </div>

        <div className="bg-gray-900 border border-blue-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-blue-400 font-semibold mb-2">Hints:</h3>
          <ul className="text-gray-300 text-sm space-y-1 list-disc list-inside">
            <li>Use two pointers, one for each array</li>
            <li>Compare elements and add the smaller one to result</li>
            <li>Move the pointer of the array whose element was added</li>
            <li>After one array is exhausted, add remaining elements from the other</li>
          </ul>
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
          <li>This is a classic merge operation from merge sort</li>
          <li>Time complexity: O(n + m) where n and m are array lengths</li>
          <li>Space complexity: O(n + m) for the result array</li>
          <li>Discuss edge cases: empty arrays, arrays of different sizes</li>
          <li>Can be asked as "merge k sorted arrays" as a follow-up</li>
        </ul>
      </div>
    </div>
  );
}
