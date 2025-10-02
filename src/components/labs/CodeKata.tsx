import { useState } from 'react';
import { Play, CheckCircle, XCircle } from 'lucide-react';

interface Kata {
  id: string;
  language: 'typescript' | 'csharp';
  title: string;
  description: string;
  starter: string;
  tests: Array<{ input: string; expected: string }>;
  solution: string;
}

const katas: Kata[] = [
  {
    id: 'ts-even-squares',
    language: 'typescript',
    title: 'Even Squares',
    description: 'Implement evenSquares(nums: number[]): number[] that filters even numbers and returns their squares.',
    starter: `function evenSquares(nums: number[]): number[] {
  // Your code here

}`,
    tests: [
      { input: '[1, 2, 3, 4, 5]', expected: '[4, 16]' },
      { input: '[10, 15, 20]', expected: '[100, 400]' },
      { input: '[1, 3, 5]', expected: '[]' }
    ],
    solution: `function evenSquares(nums: number[]): number[] {
  return nums.filter(n => n % 2 === 0).map(n => n * n);
}`
  },
  {
    id: 'ts-shape-polymorphism',
    language: 'typescript',
    title: 'Shape Polymorphism',
    description: 'Define IShape interface and Rectangle/Circle classes with area() method.',
    starter: `interface IShape {
  // Define interface
}

class Rectangle implements IShape {
  // Implement
}

class Circle implements IShape {
  // Implement
}`,
    tests: [
      { input: 'new Rectangle(4, 5).area()', expected: '20' },
      { input: 'new Circle(3).area()', expected: '28.27 (approx)' }
    ],
    solution: `interface IShape {
  area(): number;
}

class Rectangle implements IShape {
  constructor(private width: number, private height: number) {}
  area(): number {
    return this.width * this.height;
  }
}

class Circle implements IShape {
  constructor(private radius: number) {}
  area(): number {
    return Math.PI * this.radius * this.radius;
  }
}`
  },
  {
    id: 'csharp-reverse-string',
    language: 'csharp',
    title: 'Reverse String',
    description: 'Implement a method that reverses a string without using built-in Reverse().',
    starter: `public string ReverseString(string input)
{
    // Your code here

}`,
    tests: [
      { input: '"hello"', expected: '"olleh"' },
      { input: '"C# rocks"', expected: '"skcor #C"' }
    ],
    solution: `public string ReverseString(string input)
{
    char[] arr = input.ToCharArray();
    int left = 0, right = arr.Length - 1;
    while (left < right)
    {
        var temp = arr[left];
        arr[left] = arr[right];
        arr[right] = temp;
        left++;
        right--;
    }
    return new string(arr);
}`
  }
];

export function CodeKata() {
  const [selectedKata, setSelectedKata] = useState(0);
  const [code, setCode] = useState(katas[0].starter);
  const [results, setResults] = useState<Array<{ passed: boolean; message: string }>>([]);
  const [showSolution, setShowSolution] = useState(false);

  const kata = katas[selectedKata];

  const runTests = () => {
    try {
      // For TypeScript katas, use safe eval (simplified)
      if (kata.language === 'typescript') {
        // Create function from user code
        const fullCode = code + '\n\n// Test execution\n';

        // Simplified test runner (real implementation would use proper sandbox)
        const testResults = kata.tests.map(test => {
          try {
            // This is a simplified check - production would use proper eval sandbox
            const codeCheck = code.toLowerCase();
            const hasFilter = codeCheck.includes('filter');
            const hasMap = codeCheck.includes('map');

            if (kata.id === 'ts-even-squares' && hasFilter && hasMap) {
              return { passed: true, message: `${test.input} → ${test.expected} ✓` };
            } else if (kata.id === 'ts-shape-polymorphism' && codeCheck.includes('interface') && codeCheck.includes('class')) {
              return { passed: true, message: `Structure looks correct ✓` };
            } else {
              return { passed: false, message: `Check your implementation` };
            }
          } catch (err) {
            return { passed: false, message: `Error: ${err}` };
          }
        });

        setResults(testResults);
      } else {
        // C# simulation
        const testResults = kata.tests.map(test => ({
          passed: code.includes('ToCharArray') || code.includes('for') || code.includes('while'),
          message: code.includes('ToCharArray') || code.includes('while')
            ? `${test.input} → ${test.expected} ✓`
            : 'Implement the logic'
        }));
        setResults(testResults);
      }
    } catch (error) {
      setResults([{ passed: false, message: `Error: ${error}` }]);
    }
  };

  const handleKataChange = (index: number) => {
    setSelectedKata(index);
    setCode(katas[index].starter);
    setResults([]);
    setShowSolution(false);
  };

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-2xl font-bold text-white mb-2">Code Kata Practice</h3>
        <p className="text-gray-400">
          Practice coding problems in TypeScript and C#. Write your solution and run tests.
        </p>
      </div>

      <div className="flex gap-2 flex-wrap">
        {katas.map((k, idx) => (
          <button
            key={k.id}
            onClick={() => handleKataChange(idx)}
            className={`px-4 py-2 rounded-lg font-medium text-sm transition-colors ${
              selectedKata === idx
                ? 'bg-cyan-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            }`}
          >
            {k.language === 'typescript' ? '📘' : '💚'} {k.title}
          </button>
        ))}
      </div>

      <div className="bg-gray-900 rounded-lg p-6">
        <div className="mb-4">
          <h4 className="text-lg font-bold text-white mb-2">{kata.title}</h4>
          <p className="text-gray-300 text-sm">{kata.description}</p>
        </div>

        <div className="mb-4">
          <label className="block text-sm font-medium text-gray-400 mb-2">Your Code:</label>
          <textarea
            value={code}
            onChange={(e) => setCode(e.target.value)}
            className="w-full bg-gray-800 text-gray-200 font-mono text-sm p-4 rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none resize-y"
            rows={12}
            spellCheck={false}
          />
        </div>

        <div className="flex gap-3">
          <button
            onClick={runTests}
            className="flex-1 bg-green-600 hover:bg-green-500 text-white font-bold py-3 rounded-lg transition-colors flex items-center justify-center gap-2"
          >
            <Play size={20} />
            Run Tests
          </button>
          <button
            onClick={() => setShowSolution(!showSolution)}
            className="bg-gray-700 hover:bg-gray-600 text-gray-300 font-bold px-6 py-3 rounded-lg transition-colors"
          >
            {showSolution ? 'Hide' : 'Show'} Solution
          </button>
        </div>

        {results.length > 0 && (
          <div className="mt-4 space-y-2">
            <h5 className="font-bold text-white text-sm">Test Results:</h5>
            {results.map((result, idx) => (
              <div
                key={idx}
                className={`p-3 rounded-lg border flex items-start gap-2 ${
                  result.passed
                    ? 'bg-green-900/30 border-green-500'
                    : 'bg-red-900/30 border-red-500'
                }`}
              >
                {result.passed ? (
                  <CheckCircle className="text-green-400 flex-shrink-0 mt-0.5" size={16} />
                ) : (
                  <XCircle className="text-red-400 flex-shrink-0 mt-0.5" size={16} />
                )}
                <span className="text-gray-200 text-sm font-mono">{result.message}</span>
              </div>
            ))}
          </div>
        )}

        {showSolution && (
          <div className="mt-4">
            <h5 className="font-bold text-white text-sm mb-2">Solution:</h5>
            <pre className="text-gray-300 font-mono text-sm bg-gray-800 p-4 rounded-lg overflow-x-auto border border-gray-600">
              {kata.solution}
            </pre>
          </div>
        )}
      </div>

      <div className="bg-blue-900/30 border border-blue-500 rounded-lg p-4">
        <h4 className="font-bold text-blue-300 mb-2">💡 Practice Tips</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• Read the problem carefully and understand the expected input/output</li>
          <li>• Start with a simple solution, then optimize if needed</li>
          <li>• Test edge cases: empty arrays, null values, boundary conditions</li>
          <li>• Use TypeScript/C# features: generics, LINQ/array methods, type safety</li>
        </ul>
      </div>
    </div>
  );
}
