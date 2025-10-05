import { Beaker, Code2 } from 'lucide-react';

export function Labs() {
  return (
    <div className="max-w-7xl mx-auto space-y-6">
      <div className="bg-gradient-to-r from-cyan-600 to-blue-600 rounded-xl p-8 text-white">
        <div className="flex items-center gap-3">
          <Beaker size={40} />
          <div>
            <h1 className="text-4xl font-bold mb-2">Interactive Labs</h1>
            <p className="text-cyan-100">Hands-on practice to reinforce concepts</p>
          </div>
        </div>
      </div>

      <div className="bg-gray-800 rounded-xl p-8 border border-gray-700">
        <div className="flex items-center gap-3 mb-6">
          <Code2 className="text-cyan-400" size={32} />
          <h2 className="text-2xl font-bold text-white">Laboratoare Interactive</h2>
        </div>

        <div className="space-y-4">
          <div className="bg-gray-900 rounded-lg p-6 border border-gray-700">
            <h3 className="text-xl font-bold text-white mb-3">Coding Katas Disponibile</h3>
            <ul className="space-y-2 text-gray-300">
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>FizzBuzz:</strong> Clasicul warm-up pentru iterare și condiții</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Two Sum:</strong> Găsește două numere care însumează o țintă (Hash Map - O(n))</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Valid Parentheses:</strong> Verifică paranteze balansate folosind Stack</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Binary Search:</strong> Căutare eficientă în array sortat (O(log n))</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Merge Sorted Arrays:</strong> Îmbină două array-uri sortate</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Reverse String:</strong> Inversează un string in-place</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Palindrome Checker:</strong> Verifică dacă un string e palindrom</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Find Max & Min:</strong> Găsește valori maxime și minime într-un array</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Linked List Basics:</strong> Operații fundamentale cu liste înlănțuite</span>
              </li>
            </ul>
          </div>

          <div className="bg-gray-900 rounded-lg p-6 border border-gray-700">
            <h3 className="text-xl font-bold text-white mb-3">Concepte OOP & .NET</h3>
            <ul className="space-y-2 text-gray-300">
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Constructor & Properties:</strong> Practică cu inițializarea obiectelor</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Inheritance & Polymorphism:</strong> Exerciții cu moștenire și override</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Interface Implementation:</strong> Definirea și implementarea contractelor</span>
              </li>
            </ul>
          </div>

          <div className="bg-gray-900 rounded-lg p-6 border border-gray-700">
            <h3 className="text-xl font-bold text-white mb-3">SQL & Database Practice</h3>
            <ul className="space-y-2 text-gray-300">
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Basic Queries:</strong> SELECT, WHERE, ORDER BY, LIMIT</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>JOINs:</strong> INNER JOIN, LEFT JOIN, RIGHT JOIN practice</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Aggregations:</strong> GROUP BY, HAVING, COUNT, SUM, AVG</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Subqueries:</strong> Interogări nested și CTEs</span>
              </li>
            </ul>
          </div>

          <div className="bg-gradient-to-r from-orange-600/20 to-red-600/20 rounded-lg p-6 border-2 border-orange-500">
            <h3 className="text-xl font-bold text-orange-300 mb-3">💡 Sfat pentru Practică</h3>
            <p className="text-gray-200">
              Laboratoarele interactive sunt concepute pentru a-ți consolida cunoștințele prin practică hands-on.
              Încearcă să rezolvi fiecare problemă singur înainte de a privi soluția. Folosește-le împreună cu
              secțiunea <strong>BIBLIA GIGA</strong> pentru pregătire completă!
            </p>
          </div>

          <div className="bg-gray-900 rounded-lg p-6 border border-gray-700">
            <h3 className="text-xl font-bold text-white mb-3">Resurse Suplimentare</h3>
            <p className="text-gray-300 mb-4">
              Pentru a practica coding katas și algoritmi în mod interactiv, recomandăm:
            </p>
            <ul className="space-y-2 text-gray-300">
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>LeetCode:</strong> Platformă excelentă pentru pregătirea interviurilor tehnice</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>HackerRank:</strong> Practică cu probleme de diverse dificultăți</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Codewars:</strong> Coding challenges cu community support</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-cyan-400 font-bold">•</span>
                <span><strong>Exercism:</strong> Învață prin practică cu mentorship</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
}
