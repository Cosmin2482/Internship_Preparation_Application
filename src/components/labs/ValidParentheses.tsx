import { useState } from 'react';
import { CheckCircle, XCircle, Play } from 'lucide-react';

export function ValidParentheses() {
  const [code, setCode] = useState(`function isValid(s) {
  // Your code here
  // Use a stack to match opening and closing brackets




  return false;
}`);

  const [result, setResult] = useState<{ success: boolean; message: string } | null>(null);

  const runTests = () => {
    try {
      const func = eval(`(${code})`);

      const tests = [
        { input: '()', expected: true },
        { input: '()[]{}', expected: true },
        { input: '(]', expected: false },
        { input: '([)]', expected: false },
        { input: '{[]}', expected: true },
        { input: '', expected: true },
        { input: '((', expected: false },
        { input: '))((', expected: false }
      ];

      for (const test of tests) {
        const output = func(test.input);
        if (output !== test.expected) {
          setResult({
            success: false,
            message: `Failed: isValid("${test.input}") returned ${output}, expected ${test.expected}`
          });
          return;
        }
      }

      setResult({
        success: true,
        message: 'All tests passed! You understand stack-based validation.'
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
        <h2 className="text-2xl font-bold text-white mb-2">Valid Parentheses</h2>
        <p className="text-gray-300 mb-4">
          Determine if a string of brackets is valid. Every opening bracket must have a matching closing bracket in the correct order.
        </p>

        <div className="bg-gray-900 border border-cyan-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-cyan-400 font-semibold mb-2">Problem:</h3>
          <p className="text-gray-300 text-sm mb-2">
            Given a string containing only '(', ')', '{', '}', '[', ']', determine if it's valid.
          </p>
          <div className="space-y-1 text-sm">
            <p className="text-gray-400">Valid: "()" "()[]{}" "{[]}"</p>
            <p className="text-gray-400">Invalid: "(]" "([)]" "((("</p>
          </div>
        </div>

        <div className="bg-gray-900 border border-blue-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-blue-400 font-semibold mb-2">Hints:</h3>
          <ul className="text-gray-300 text-sm space-y-1 list-disc list-inside">
            <li>Use a stack to keep track of opening brackets</li>
            <li>When you see an opening bracket, push it onto the stack</li>
            <li>When you see a closing bracket, check if it matches the top of the stack</li>
            <li>At the end, the stack should be empty for a valid string</li>
            <li>You can use an array as a stack with push() and pop()</li>
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
          <li>This is one of the most common interview questions</li>
          <li>Time complexity: O(n) where n is string length</li>
          <li>Space complexity: O(n) for the stack in worst case</li>
          <li>Demonstrates understanding of stack data structure</li>
          <li>Can be extended: "generate all valid parentheses of length n"</li>
          <li>Explain your thought process clearly when solving</li>
        </ul>
      </div>
    </div>
  );
}
