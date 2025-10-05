import { useState } from 'react';
import { CheckCircle, XCircle, Play } from 'lucide-react';

export function LinkedListBasics() {
  const [code, setCode] = useState(`class Node {
  constructor(value) {
    this.value = value;
    this.next = null;
  }
}

class LinkedList {
  constructor() {
    this.head = null;
  }

  append(value) {
    // Add a node to the end of the list

  }

  prepend(value) {
    // Add a node to the beginning of the list

  }

  find(value) {
    // Return true if value exists, false otherwise

    return false;
  }

  toArray() {
    // Convert linked list to array for testing
    const result = [];
    let current = this.head;
    while (current) {
      result.push(current.value);
      current = current.next;
    }
    return result;
  }
}`);

  const [result, setResult] = useState<{ success: boolean; message: string } | null>(null);

  const runTests = () => {
    try {
      eval(code);
      const LinkedList = eval('LinkedList');

      const list = new LinkedList();

      list.append(1);
      list.append(2);
      list.append(3);
      let arr = list.toArray();
      if (JSON.stringify(arr) !== JSON.stringify([1, 2, 3])) {
        setResult({
          success: false,
          message: `Failed: After append(1,2,3), expected [1,2,3], got [${arr}]`
        });
        return;
      }

      list.prepend(0);
      arr = list.toArray();
      if (JSON.stringify(arr) !== JSON.stringify([0, 1, 2, 3])) {
        setResult({
          success: false,
          message: `Failed: After prepend(0), expected [0,1,2,3], got [${arr}]`
        });
        return;
      }

      if (!list.find(2)) {
        setResult({
          success: false,
          message: 'Failed: find(2) should return true'
        });
        return;
      }

      if (list.find(99)) {
        setResult({
          success: false,
          message: 'Failed: find(99) should return false'
        });
        return;
      }

      setResult({
        success: true,
        message: 'All tests passed! You understand linked list fundamentals.'
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
        <h2 className="text-2xl font-bold text-white mb-2">Linked List Basics</h2>
        <p className="text-gray-300 mb-4">
          Implement basic operations on a singly linked list: append, prepend, and find.
        </p>

        <div className="bg-gray-900 border border-cyan-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-cyan-400 font-semibold mb-2">Problem:</h3>
          <p className="text-gray-300 text-sm mb-2">
            Complete the LinkedList class with three methods:
          </p>
          <ul className="text-gray-300 text-sm space-y-1 list-disc list-inside">
            <li>append(value) - Add a node at the end</li>
            <li>prepend(value) - Add a node at the beginning</li>
            <li>find(value) - Check if a value exists in the list</li>
          </ul>
        </div>

        <div className="bg-gray-900 border border-blue-500/30 rounded-lg p-4 mb-4">
          <h3 className="text-blue-400 font-semibold mb-2">Hints:</h3>
          <ul className="text-gray-300 text-sm space-y-1 list-disc list-inside">
            <li>For append: traverse to the last node, then set its next to a new node</li>
            <li>Handle the case when the list is empty (head is null)</li>
            <li>For prepend: create a new node and point its next to current head</li>
            <li>For find: traverse the list and compare each node's value</li>
            <li>Remember to update this.head when needed</li>
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
          className="w-full h-96 bg-gray-900 text-gray-100 font-mono text-sm p-4 rounded-lg border border-gray-700 focus:border-cyan-500 focus:outline-none"
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
          <li>Linked lists are fundamental data structures - know them well</li>
          <li>Common operations: insert, delete, reverse, detect cycle</li>
          <li>Time complexity: O(1) for prepend, O(n) for append and find</li>
          <li>Space complexity: O(1) for all operations</li>
          <li>Advantage over arrays: O(1) insertion/deletion at beginning</li>
          <li>Disadvantage: No random access, must traverse sequentially</li>
          <li>In C#, you would use LinkedList&lt;T&gt; from System.Collections.Generic</li>
        </ul>
      </div>
    </div>
  );
}
