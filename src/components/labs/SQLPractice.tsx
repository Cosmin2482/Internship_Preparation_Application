import { useState } from 'react';
import { CheckCircle, XCircle } from 'lucide-react';

interface Challenge {
  id: number;
  title: string;
  description: string;
  expectedClauses: string[];
  hint: string;
}

const challenges: Challenge[] = [
  {
    id: 1,
    title: 'Basic SELECT',
    description: 'Write a query to select all names from the employees table where age is greater than 30, ordered alphabetically.',
    expectedClauses: ['SELECT', 'FROM employees', 'WHERE age > 30', 'ORDER BY'],
    hint: 'You need SELECT, FROM, WHERE, and ORDER BY clauses'
  },
  {
    id: 2,
    title: 'JOIN Query',
    description: 'Write a query to get employee names and their department names by joining employees and departments tables.',
    expectedClauses: ['SELECT', 'FROM employees', 'JOIN departments', 'ON'],
    hint: 'Use INNER JOIN or just JOIN to combine tables'
  },
  {
    id: 3,
    title: 'Aggregation',
    description: 'Write a query to count the number of employees in each department, showing only departments with more than 5 employees.',
    expectedClauses: ['SELECT', 'COUNT', 'FROM employees', 'GROUP BY', 'HAVING'],
    hint: 'Use GROUP BY with COUNT and HAVING for filtering groups'
  },
  {
    id: 4,
    title: 'Subquery',
    description: 'Write a query to find employees whose salary is above the average salary.',
    expectedClauses: ['SELECT', 'FROM employees', 'WHERE salary >', 'SELECT', 'AVG'],
    hint: 'Use a subquery with AVG() in the WHERE clause'
  }
];

export function SQLPractice() {
  const [currentChallenge, setCurrentChallenge] = useState(0);
  const [userQuery, setUserQuery] = useState('');
  const [feedback, setFeedback] = useState<{ success: boolean; message: string } | null>(null);

  const challenge = challenges[currentChallenge];

  const checkQuery = () => {
    const normalized = userQuery.toUpperCase().replace(/\s+/g, ' ').trim();

    const missingClauses = challenge.expectedClauses.filter(clause => {
      const normalizedClause = clause.toUpperCase();
      return !normalized.includes(normalizedClause);
    });

    if (missingClauses.length === 0) {
      setFeedback({
        success: true,
        message: 'Excellent! Your query contains all the required clauses. This is a valid solution structure.'
      });
    } else {
      setFeedback({
        success: false,
        message: `Missing or incorrect clauses: ${missingClauses.join(', ')}. ${challenge.hint}`
      });
    }
  };

  const nextChallenge = () => {
    setCurrentChallenge((prev) => (prev + 1) % challenges.length);
    setUserQuery('');
    setFeedback(null);
  };

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-2xl font-bold text-white mb-2">SQL Practice Pad</h3>
        <p className="text-gray-400">
          Practice writing SQL queries. The validator checks for required clauses and structure.
        </p>
      </div>

      <div className="bg-gray-900 rounded-lg p-6">
        <div className="flex items-center justify-between mb-4">
          <h4 className="text-lg font-bold text-white">
            Challenge {currentChallenge + 1} of {challenges.length}: {challenge.title}
          </h4>
          <button
            onClick={nextChallenge}
            className="text-sm bg-gray-700 hover:bg-gray-600 text-gray-300 px-3 py-1 rounded transition-colors"
          >
            Next Challenge
          </button>
        </div>

        <p className="text-gray-300 mb-4">{challenge.description}</p>

        <div className="mb-4">
          <label className="block text-sm font-medium text-gray-400 mb-2">Your SQL Query:</label>
          <textarea
            value={userQuery}
            onChange={(e) => setUserQuery(e.target.value)}
            placeholder="SELECT ..."
            className="w-full bg-gray-800 text-gray-200 font-mono text-sm p-4 rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none resize-y"
            rows={8}
          />
        </div>

        <button
          onClick={checkQuery}
          disabled={!userQuery.trim()}
          className="w-full bg-cyan-600 hover:bg-cyan-500 disabled:bg-gray-700 disabled:cursor-not-allowed text-white font-bold py-3 rounded-lg transition-colors"
        >
          Check Query
        </button>

        {feedback && (
          <div
            className={`mt-4 p-4 rounded-lg border ${
              feedback.success
                ? 'bg-green-900/30 border-green-500'
                : 'bg-red-900/30 border-red-500'
            }`}
          >
            <div className="flex items-start gap-3">
              {feedback.success ? (
                <CheckCircle className="text-green-400 flex-shrink-0 mt-0.5" size={20} />
              ) : (
                <XCircle className="text-red-400 flex-shrink-0 mt-0.5" size={20} />
              )}
              <p className="text-gray-200 text-sm">{feedback.message}</p>
            </div>
          </div>
        )}
      </div>

      <div className="bg-gray-900 rounded-lg p-4">
        <h4 className="font-bold text-white mb-3">Sample Schema</h4>
        <pre className="text-xs text-gray-300 font-mono bg-gray-800 p-3 rounded overflow-x-auto">
{`employees
  - id (INT)
  - name (VARCHAR)
  - age (INT)
  - salary (DECIMAL)
  - department_id (INT)

departments
  - id (INT)
  - name (VARCHAR)
  - location (VARCHAR)`}
        </pre>
      </div>

      <div className="bg-blue-900/30 border border-blue-500 rounded-lg p-4">
        <h4 className="font-bold text-blue-300 mb-2">💡 SQL Tips</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• Always specify table names when joining (employees.name, departments.name)</li>
          <li>• Use HAVING for filtering after GROUP BY, WHERE for filtering before</li>
          <li>• Subqueries must return a single value when used with comparison operators</li>
          <li>• ORDER BY comes last in the query structure</li>
        </ul>
      </div>
    </div>
  );
}
