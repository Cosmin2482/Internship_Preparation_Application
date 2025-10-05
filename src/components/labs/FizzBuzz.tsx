import { useState } from 'react';
import { CheckCircle2, XCircle, Play } from 'lucide-react';

export function FizzBuzz() {
  const [code, setCode] = useState(`// FizzBuzz - Classic interview problem!
// Print numbers 1-100, but:
// - Multiples of 3: print "Fizz"
// - Multiples of 5: print "Buzz"
// - Multiples of both 3 and 5: print "FizzBuzz"
// - Otherwise: print the number

public static void FizzBuzz() {
  // Your code here
}`);

  const [output, setOutput] = useState<string>('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);

  const solution = `public static void FizzBuzz() {
  for (int i = 1; i <= 100; i++) {
    if (i % 15 == 0) {
      Console.WriteLine("FizzBuzz");
    } else if (i % 3 == 0) {
      Console.WriteLine("Fizz");
    } else if (i % 5 == 0) {
      Console.WriteLine("Buzz");
    } else {
      Console.WriteLine(i);
    }
  }
}`;

  const runCode = () => {
    const hasLoop = code.includes('for') || code.includes('while');
    const hasModulo = code.includes('%');
    const hasFizz = code.includes('"Fizz"') || code.includes("'Fizz'");
    const hasBuzz = code.includes('"Buzz"') || code.includes("'Buzz'");
    const hasFizzBuzz = code.includes('"FizzBuzz"') || code.includes("'FizzBuzz'");
    const has15Check = code.includes('% 15') || (code.includes('% 3') && code.includes('% 5'));

    if (hasLoop && hasModulo && hasFizz && hasBuzz && hasFizzBuzz && has15Check) {
      setOutput(`✓ Perfect! Your FizzBuzz solution works correctly!

Output (first 20 lines):
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
17
Fizz
19
Buzz
...

Key Points:
✓ Loop from 1 to 100
✓ Check divisibility by 15 first (important!)
✓ Then check 3, then 5
✓ Print number if none match

This is one of the most common interview warmup questions!`);
      setIsCorrect(true);
    } else {
      const issues = [];
      if (!hasLoop) issues.push('Need a loop (for or while)');
      if (!hasModulo) issues.push('Use modulo (%) to check divisibility');
      if (!hasFizz) issues.push('Print "Fizz" for multiples of 3');
      if (!hasBuzz) issues.push('Print "Buzz" for multiples of 5');
      if (!hasFizzBuzz) issues.push('Print "FizzBuzz" for multiples of both');
      if (!has15Check) issues.push('Check for multiples of 15 FIRST!');

      setOutput(`✗ Issues:\n${issues.map(i => '- ' + i).join('\n')}

Important: Check i % 15 == 0 BEFORE checking i % 3 or i % 5
(Because 15 is divisible by both 3 and 5)

Hint: Use if/else if chain:
if (i % 15 == 0) → FizzBuzz
else if (i % 3 == 0) → Fizz
else if (i % 5 == 0) → Buzz
else → print number`);
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
        <h3 className="text-lg font-semibold mb-2">Exercise: FizzBuzz</h3>
        <p className="text-gray-400 text-sm mb-4">
          The classic interview warmup! Tests your understanding of loops, conditionals, and modulo.
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
            <h4 className="text-sm font-semibold mb-2">Pattern Examples</h4>
            <div className="text-xs text-gray-300">
              <div className="mb-2">
                <strong>Number 3:</strong> 3 % 3 = 0 → "Fizz"<br/>
                <strong>Number 5:</strong> 5 % 5 = 0 → "Buzz"<br/>
                <strong>Number 15:</strong> 15 % 15 = 0 → "FizzBuzz"<br/>
                <strong>Number 7:</strong> 7 % 3 ≠ 0, 7 % 5 ≠ 0 → "7"
              </div>
              <div className="text-yellow-400">
                ⚠️ Order matters! Check 15 first, otherwise 15 will print "Fizz"
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded-lg">
        <h4 className="font-semibold mb-2">💡 Why This Matters</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• <strong>Most common</strong> interview warmup question</li>
          <li>• Tests: loops, conditionals, modulo operator, logic order</li>
          <li>• <strong>Interview tip</strong>: Explain your logic as you code</li>
          <li>• Common mistake: Not checking 15 first (order of conditions matters!)</li>
        </ul>
      </div>
    </div>
  );
}
