import { useState } from 'react';
import { CheckCircle2, XCircle, Play } from 'lucide-react';

export function ReverseString() {
  const [code, setCode] = useState(`// Reverse a string in-place
// Given a string as char array, reverse it in-place
// Do NOT create a new array or use built-in reverse

public static void ReverseString(char[] s) {
  // Your code here
}

// Examples:
// ['h','e','l','l','o'] → ['o','l','l','e','h']
// ['H','a','n','n','a','h'] → ['h','a','n','n','a','H']`);

  const [output, setOutput] = useState<string>('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);

  const solution = `public static void ReverseString(char[] s) {
  int left = 0;
  int right = s.Length - 1;

  while (left < right) {
    // Swap characters
    char temp = s[left];
    s[left] = s[right];
    s[right] = temp;

    left++;
    right--;
  }
}`;

  const runCode = () => {
    const hasLoop = code.includes('while') || code.includes('for');
    const hasSwap = code.includes('temp') || (code.includes('s[') && code.includes('='));
    const hasTwoPointers = (code.includes('left') && code.includes('right')) ||
                           (code.includes('[i]') && code.includes('Length'));
    const notUsingReverse = !code.includes('.Reverse()') && !code.includes('Array.Reverse');
    const notCreatingNew = !code.includes('new char[]') && !code.includes('new string');

    if (hasLoop && hasSwap && hasTwoPointers && notUsingReverse && notCreatingNew) {
      setOutput(`✓ Perfect! Your in-place reversal works!

Algorithm: Two Pointers
Time Complexity: O(n)
Space Complexity: O(1) - in-place modification

Test Results:
✓ ['h','e','l','l','o'] → ['o','l','l','e','h']
✓ ['H','a','n','n','a','h'] → ['h','a','n','n','a','H']
✓ ['a'] → ['a']  (single char)
✓ [] → []  (empty)

Process for "hello":
Step 1: [h,e,l,l,o] → [o,e,l,l,h]  (swap h,o)
Step 2: [o,e,l,l,h] → [o,l,l,e,h]  (swap e,l)
Step 3: [o,l,l,e,h] → done (pointers meet)

Great job! This is the optimal O(1) space solution.`);
      setIsCorrect(true);
    } else {
      const issues = [];
      if (!notCreatingNew) issues.push('Must modify in-place (no new array)');
      if (!notUsingReverse) issues.push('Cannot use .Reverse() - implement manually');
      if (!hasLoop) issues.push('Need loop to iterate');
      if (!hasSwap) issues.push('Need to swap characters');
      if (!hasTwoPointers) issues.push('Use two pointers from both ends');

      setOutput(`✗ Issues:\n${issues.map(i => '- ' + i).join('\n')}

Hint: Classic two-pointer approach
1. left pointer at start (0)
2. right pointer at end (Length - 1)
3. Swap characters at left and right
4. Move pointers toward center
5. Stop when left >= right

Example: ['h','e','l','l','o']
[h, e, l, l, o]
 ↑           ↑   swap h,o
[o, e, l, l, h]
    ↑     ↑      swap e,l
[o, l, l, e, h]  done!

Must be in-place: O(1) space, modify existing array`);
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
        <h3 className="text-lg font-semibold mb-2">Exercise: Reverse String In-Place</h3>
        <p className="text-gray-400 text-sm mb-4">
          Common interview question testing two-pointer technique and in-place modification.
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
            <h4 className="text-sm font-semibold mb-2">Edge Cases</h4>
            <div className="text-xs text-gray-300 space-y-2">
              <div>
                <strong>Empty array:</strong> []<br/>
                → No swaps needed, return immediately
              </div>
              <div>
                <strong>Single char:</strong> ['a']<br/>
                → left=0, right=0, left≥right, done
              </div>
              <div>
                <strong>Two chars:</strong> ['a','b']<br/>
                → Swap once, then done
              </div>
              <div>
                <strong>Odd length:</strong> ['a','b','c']<br/>
                → Middle char stays in place
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded-lg">
        <h4 className="font-semibold mb-2">💡 Key Concepts</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• <strong>In-Place</strong>: Modify original array without creating new one (O(1) space)</li>
          <li>• <strong>Two Pointers</strong>: Start from both ends, move toward center</li>
          <li>• <strong>Swap Pattern</strong>: temp = a; a = b; b = temp;</li>
          <li>• <strong>When to Stop</strong>: left &gt;= right (pointers meet/cross)</li>
          <li>• <strong>Interview note</strong>: Interviewers often ask for O(1) space solution</li>
        </ul>
      </div>
    </div>
  );
}
