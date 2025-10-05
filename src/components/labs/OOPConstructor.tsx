import { useState } from 'react';
import { CheckCircle2, XCircle, Play } from 'lucide-react';

export function OOPConstructor() {
  const [code, setCode] = useState(`// Create a Person class with:
// - Constructor that takes name and age
// - Property: Name (string), Age (int)
// - Method: Introduce() that returns "Hi, I'm {name} and I'm {age} years old"

public class Person {
  // Your code here
}

// Test it:
var person = new Person("Alice", 25);
Console.WriteLine(person.Introduce());
// Expected: "Hi, I'm Alice and I'm 25 years old"`);

  const [output, setOutput] = useState<string>('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);

  const solution = `public class Person {
  public string Name { get; set; }
  public int Age { get; set; }

  public Person(string name, int age) {
    Name = name;
    Age = age;
  }

  public string Introduce() {
    return $"Hi, I'm {Name} and I'm {Age} years old";
  }
}`;

  const runCode = () => {
    const hasConstructor = code.includes('public Person(') || code.includes('public Person (');
    const hasProperties = code.includes('Name') && code.includes('Age');
    const hasIntroduce = code.includes('Introduce()') || code.includes('Introduce ()');
    const hasReturn = code.includes('return');

    if (hasConstructor && hasProperties && hasIntroduce && hasReturn) {
      setOutput('✓ Correct! Your Person class has:\n- Constructor\n- Name and Age properties\n- Introduce() method\n\nOutput: Hi, I\'m Alice and I\'m 25 years old');
      setIsCorrect(true);
    } else {
      const missing = [];
      if (!hasConstructor) missing.push('Constructor');
      if (!hasProperties) missing.push('Properties (Name, Age)');
      if (!hasIntroduce) missing.push('Introduce() method');
      if (!hasReturn) missing.push('return statement');
      setOutput(`✗ Missing: ${missing.join(', ')}\n\nHint: A constructor initializes the object. Properties hold data. Method returns a string.`);
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
        <h3 className="text-lg font-semibold mb-2">Exercise: Constructor & Properties</h3>
        <p className="text-gray-400 text-sm mb-4">
          Practice creating a class with a constructor, properties, and methods.
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
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded-lg">
        <h4 className="font-semibold mb-2">💡 Key Concepts</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• <strong>Constructor</strong>: Special method called when creating an object (new Person(...))</li>
          <li>• <strong>Properties</strong>: Data members with get/set (automatic storage)</li>
          <li>• <strong>Methods</strong>: Functions that define behavior</li>
          <li>• <strong>String interpolation</strong>: $"Text {'{variable}'}" for embedding values</li>
        </ul>
      </div>
    </div>
  );
}
