import { useState } from 'react';
import { Term, QuizQuestion } from '../types';
import { Lightbulb, BookOpen, Briefcase, AlertTriangle, Code, GitBranch } from 'lucide-react';
import { QuizSection } from './QuizSection';

interface TermDetailProps {
  term: Term;
  quizQuestions: QuizQuestion[];
}

export function TermDetail({ term, quizQuestions }: TermDetailProps) {
  const [activeTab, setActiveTab] = useState<'csharp' | 'typescript'>('csharp');

  return (
    <div className="max-w-5xl mx-auto space-y-6">
      <div className="bg-gradient-to-r from-cyan-600 to-blue-600 rounded-xl p-8 text-white">
        <h1 className="text-4xl font-bold mb-2">{term.term}</h1>
        <p className="text-cyan-100 text-sm">
          Study this concept thoroughly for your interview
        </p>
      </div>

      {/* ELI5 */}
      <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
        <div className="flex items-center gap-3 mb-4">
          <Lightbulb className="text-yellow-400" size={24} />
          <h2 className="text-2xl font-bold text-white">ELI5 (Explain Like I'm 5)</h2>
        </div>
        <p className="text-gray-300 leading-relaxed text-lg">{term.eli5}</p>
      </section>

      {/* Formal Definition */}
      <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
        <div className="flex items-center gap-3 mb-4">
          <BookOpen className="text-blue-400" size={24} />
          <h2 className="text-2xl font-bold text-white">Formal Definition</h2>
        </div>
        <p className="text-gray-300 leading-relaxed">{term.formal_definition}</p>
      </section>

      {/* Interview Answer */}
      <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
        <div className="flex items-center gap-3 mb-4">
          <Briefcase className="text-green-400" size={24} />
          <h2 className="text-2xl font-bold text-white">Interview Answer (30-60s)</h2>
        </div>
        <p className="text-gray-300 leading-relaxed">{term.interview_answer}</p>
      </section>

      {/* Diagram */}
      {term.diagram && (
        <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
          <div className="flex items-center gap-3 mb-4">
            <GitBranch className="text-purple-400" size={24} />
            <h2 className="text-2xl font-bold text-white">Visual Diagram</h2>
          </div>
          <pre className="text-gray-300 font-mono text-sm bg-gray-900 p-4 rounded-lg overflow-x-auto whitespace-pre">
            {term.diagram}
          </pre>
        </section>
      )}

      {/* Code Examples */}
      {(term.code_examples.csharp || term.code_examples.typescript) && (
        <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
          <div className="flex items-center gap-3 mb-4">
            <Code className="text-cyan-400" size={24} />
            <h2 className="text-2xl font-bold text-white">Code Examples</h2>
          </div>

          <div className="flex gap-2 mb-4">
            {term.code_examples.csharp && (
              <button
                onClick={() => setActiveTab('csharp')}
                className={`px-4 py-2 rounded-lg font-medium transition-colors ${
                  activeTab === 'csharp'
                    ? 'bg-cyan-600 text-white'
                    : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
                }`}
              >
                C#
              </button>
            )}
            {term.code_examples.typescript && (
              <button
                onClick={() => setActiveTab('typescript')}
                className={`px-4 py-2 rounded-lg font-medium transition-colors ${
                  activeTab === 'typescript'
                    ? 'bg-cyan-600 text-white'
                    : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
                }`}
              >
                TypeScript
              </button>
            )}
          </div>

          <pre className="text-gray-300 font-mono text-sm bg-gray-900 p-4 rounded-lg overflow-x-auto">
            {activeTab === 'csharp'
              ? term.code_examples.csharp
              : term.code_examples.typescript}
          </pre>
        </section>
      )}

      {/* Pitfalls */}
      {term.pitfalls && term.pitfalls.length > 0 && (
        <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
          <div className="flex items-center gap-3 mb-4">
            <AlertTriangle className="text-orange-400" size={24} />
            <h2 className="text-2xl font-bold text-white">Common Pitfalls</h2>
          </div>
          <ul className="space-y-3">
            {term.pitfalls.map((pitfall, idx) => (
              <li key={idx} className="flex gap-3 items-start">
                <span className="text-orange-400 font-bold min-w-[24px]">
                  {idx + 1}.
                </span>
                <span className="text-gray-300">{pitfall}</span>
              </li>
            ))}
          </ul>
        </section>
      )}

      {/* Quiz */}
      {quizQuestions.length > 0 && (
        <QuizSection questions={quizQuestions} />
      )}
    </div>
  );
}
