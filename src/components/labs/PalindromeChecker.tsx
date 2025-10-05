import { useState } from 'react';
import { CheckCircle2, XCircle, Play } from 'lucide-react';

export function PalindromeChecker() {
  const [code, setCode] = useState(`// Write a function that checks if a string is a palindrome
// Palindrome: reads the same forwards and backwards
// Ignore case and spaces

public static bool IsPalindrome(string str) {
  // Your code here
  return false;
}

// Test cases:
IsPalindrome("racecar"); // true
IsPalindrome("A man a plan a canal Panama"); // true
IsPalindrome("hello"); // false`);

  const [output, setOutput] = useState<string>('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);

  const solution = `public static bool IsPalindrome(string str) {
  // Remove spaces and convert to lowercase
  str = str.Replace(" ", "").ToLower();

  int left = 0;
  int right = str.Length - 1;

  while (left < right) {
    if (str[left] != str[right]) {
      return false;
    }
    left++;
    right--;
  }

  return true;
}`;

  const runCode = () => {
    const hasLeftRight = (code.includes('left') && code.includes('right')) ||
                         (code.includes('[0]') && code.includes('Length'));
    const hasComparison = code.includes('!=') || code.includes('==');
    const handlesSpaces = code.includes('Replace') || code.includes('Trim') ||
                          code.includes('Where') || code.includes('filter');
    const handlesCase = code.includes('ToLower') || code.includes('ToUpper');

    if (hasLeftRight && hasComparison && handlesSpaces && handlesCase) {
      setOutput(`✓ Excellent! Your solution correctly:
- Handles spaces ("A man a plan..." → "amanaplana...")
- Ignores case (converts to lowercase)
- Uses two-pointer approach
- Time Complexity: O(n)
- Space Complexity: O(n) for cleaned string

Test Results:
✓ "racecar" → true (palindrome)
✓ "A man a plan a canal Panama" → true
✓ "hello" → false (not palindrome)
✓ "" → true (empty string)

Perfect implementation!`);
      setIsCorrect(true);
    } else {
      const issues = [];
      if (!hasLeftRight) issues.push('Use two pointers from both ends');
      if (!hasComparison) issues.push('Compare characters at left and right');
      if (!handlesSpaces) issues.push('Remove spaces first (.Replace(" ", ""))');
      if (!handlesCase) issues.push('Handle case (.ToLower())');

      setOutput(`✗ Issues:\n${issues.map(i => '- ' + i).join('\n')}

Hint:
1. Clean the string: remove spaces, convert to lowercase
2. Use two pointers (left=0, right=length-1)
3. Compare characters, return false if different
4. Move pointers toward center`);
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
        <h3 className="text-lg font-semibold mb-2">Exercise: Palindrome Checker</h3>
        <p className="text-gray-400 text-sm mb-4">
          Common interview question: Check if a string reads the same forwards and backwards.
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
            <h4 className="text-sm font-semibold mb-2">Examples</h4>
            <div className="text-xs text-gray-300 space-y-2">
              <div>
                <div className="text-green-400">✓ Palindromes:</div>
                <div className="ml-2">
                  • "racecar" → r-a-c-e-c-a-r<br/>
                  • "noon" → n-o-o-n<br/>
                  • "A man a plan a canal Panama"
                </div>
              </div>
              <div>
                <div className="text-red-400">✗ Not palindromes:</div>
                <div className="ml-2">
                  • "hello"<br/>
                  • "world"
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded-lg">
        <h4 className="font-semibold mb-2">💡 Key Concepts</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• <strong>String Cleaning</strong>: Remove spaces, normalize case</li>
          <li>• <strong>Two Pointers</strong>: Compare from both ends moving inward</li>
          <li>• <strong>Early Return</strong>: Return false as soon as mismatch found</li>
          <li>• <strong>Edge Cases</strong>: Empty string, single character (both palindromes)</li>
        </ul>
      </div>
    </div>
  );
}
