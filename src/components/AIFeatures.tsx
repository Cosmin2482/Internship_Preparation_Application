import { useState } from 'react';
import { Sparkles, MessageSquare, Brain, Loader2 } from 'lucide-react';

const GEMINI_API_KEY = import.meta.env.VITE_GEMINI_API_KEY;
const GEMINI_MODEL = 'gemini-2.5-flash';

interface QuizQuestion {
  question: string;
  answer: string;
}

interface BehavioralQuestion {
  question: string;
  star_analysis: {
    Situation: string;
    Task: string;
    Action: string;
    Result: string;
  };
}

export function AIFeatures() {
  const [activeTab, setActiveTab] = useState<'quiz' | 'explain' | 'behavioral'>('quiz');
  const [loading, setLoading] = useState(false);
  const [quizTopic, setQuizTopic] = useState('OOP C#');
  const [quizQuestions, setQuizQuestions] = useState<QuizQuestion[]>([]);
  const [conceptInput, setConceptInput] = useState('');
  const [conceptExplanation, setConceptExplanation] = useState('');
  const [roleInput, setRoleInput] = useState('');
  const [behavioralQuestion, setBehavioralQuestion] = useState<BehavioralQuestion | null>(null);

  const generateQuiz = async () => {
    setLoading(true);
    try {
      const response = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            contents: [{ parts: [{ text: `Generate 3 interview questions about: ${quizTopic}` }] }],
            systemInstruction: {
              parts: [{
                text: `You are a specialist in technical interviews. Generate 3 interview questions of internship level on the subject "${quizTopic}". Each question should be short answer or definition/explanation type. Respond exclusively in Romanian and use the specified JSON format.`
              }]
            },
            generationConfig: {
              responseMimeType: 'application/json',
              responseSchema: {
                type: 'ARRAY',
                items: {
                  type: 'OBJECT',
                  properties: {
                    question: { type: 'STRING', description: 'The interview question based on the topic.' },
                    answer: { type: 'STRING', description: 'The concise, correct, and detailed answer in Romanian.' }
                  },
                  propertyOrdering: ['question', 'answer']
                }
              }
            }
          })
        }
      );

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`API Error: ${response.status} - ${errorText}`);
      }

      const result = await response.json();
      const jsonText = result.candidates?.[0]?.content?.parts?.[0]?.text;
      if (jsonText) {
        const questions = JSON.parse(jsonText);
        setQuizQuestions(questions);
      } else {
        throw new Error('No response from AI');
      }
    } catch (error) {
      console.error('Quiz generation error:', error);
      alert(`Error generating quiz: ${error instanceof Error ? error.message : 'Unknown error'}. Please check your API key configuration.`);
    } finally {
      setLoading(false);
    }
  };

  const explainConcept = async () => {
    if (!conceptInput.trim()) return;
    setLoading(true);
    try {
      const response = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            contents: [{ parts: [{ text: `Explain using code examples or analogies, the technical term: "${conceptInput}".` }] }],
            systemInstruction: {
              parts: [{
                text: 'You are a programming professor specialized in interviews. Explain concisely and in detail the requested technical concept, using C# / .NET / SQL / JavaScript language. The response must be in Romanian and contain a single professionally formatted text section (no introductions or conclusions, just the explanation).'
              }]
            }
          })
        }
      );

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`API Error: ${response.status} - ${errorText}`);
      }

      const result = await response.json();
      const text = result.candidates?.[0]?.content?.parts?.[0]?.text;
      if (!text) {
        throw new Error('No response from AI');
      }
      setConceptExplanation(text);
    } catch (error) {
      console.error('Concept explanation error:', error);
      setConceptExplanation(`Error: ${error instanceof Error ? error.message : 'Could not generate explanation'}. Please check your API key configuration.`);
    } finally {
      setLoading(false);
    }
  };

  const simulateBehavioral = async () => {
    const role = roleInput.trim() || 'C# Intern / Trimble';
    setLoading(true);
    try {
      const response = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            contents: [{ parts: [{ text: `Generate a behavioral interview question for the role of ${role}.` }] }],
            systemInstruction: {
              parts: [{
                text: `You are a top HR specialist. Generate a relevant behavioral interview question for the role of "${role}". After the question, provide a concise analysis of the expected answer, structured using the STAR method (Situation, Task, Action, Result). Respond exclusively in Romanian and use the specified JSON format.`
              }]
            },
            generationConfig: {
              responseMimeType: 'application/json',
              responseSchema: {
                type: 'OBJECT',
                properties: {
                  question: { type: 'STRING', description: 'The behavioral interview question.' },
                  star_analysis: {
                    type: 'OBJECT',
                    description: 'Analysis of the expected answer structure using the STAR method in Romanian.',
                    properties: {
                      Situation: { type: 'STRING' },
                      Task: { type: 'STRING' },
                      Action: { type: 'STRING' },
                      Result: { type: 'STRING' }
                    }
                  }
                }
              }
            }
          })
        }
      );

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`API Error: ${response.status} - ${errorText}`);
      }

      const result = await response.json();
      const jsonText = result.candidates?.[0]?.content?.parts?.[0]?.text;
      if (jsonText) {
        const data = JSON.parse(jsonText);
        setBehavioralQuestion(data);
      } else {
        throw new Error('No response from AI');
      }
    } catch (error) {
      console.error('Behavioral simulation error:', error);
      alert(`Error generating question: ${error instanceof Error ? error.message : 'Unknown error'}. Please check your API key configuration.`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl p-6">
      <div className="flex items-center gap-2 mb-6">
        <Sparkles className="w-6 h-6 text-cyan-500" />
        <h2 className="text-2xl font-bold">AI-Powered Study Tools</h2>
      </div>

      <div className="flex gap-2 mb-6">
        <button
          onClick={() => setActiveTab('quiz')}
          className={`px-4 py-2 rounded-lg font-medium transition-colors ${
            activeTab === 'quiz'
              ? 'bg-cyan-600 text-white'
              : 'bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700'
          }`}
        >
          Quiz Generator
        </button>
        <button
          onClick={() => setActiveTab('explain')}
          className={`px-4 py-2 rounded-lg font-medium transition-colors ${
            activeTab === 'explain'
              ? 'bg-green-600 text-white'
              : 'bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700'
          }`}
        >
          Concept Explainer
        </button>
        <button
          onClick={() => setActiveTab('behavioral')}
          className={`px-4 py-2 rounded-lg font-medium transition-colors ${
            activeTab === 'behavioral'
              ? 'bg-yellow-600 text-white'
              : 'bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700'
          }`}
        >
          Behavioral Practice
        </button>
      </div>

      {activeTab === 'quiz' && (
        <div>
          <label className="block text-sm font-medium mb-2">Choose a major topic:</label>
          <select
            value={quizTopic}
            onChange={(e) => setQuizTopic(e.target.value)}
            className="w-full p-2 rounded-lg bg-gray-100 dark:bg-gray-800 border border-gray-300 dark:border-gray-600 mb-3"
          >
            <option value="OOP C#">OOP (C# focus)</option>
            <option value="HTTP/REST">HTTP & REST</option>
            <option value="CRUD & SQL">CRUD & SQL</option>
            <option value=".NET & EF Core">.NET & EF Core</option>
            <option value="Unit Testing">Unit Testing</option>
            <option value="React/Angular/TS">JavaScript/TypeScript + React/Angular</option>
          </select>
          <button
            onClick={generateQuiz}
            disabled={loading}
            className="w-full py-2 bg-cyan-600 hover:bg-cyan-700 disabled:bg-gray-400 text-white font-semibold rounded-lg transition-colors flex items-center justify-center gap-2"
          >
            {loading ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Generating...
              </>
            ) : (
              'Generate Quiz (3 Questions)'
            )}
          </button>
          {quizQuestions.length > 0 && (
            <div className="mt-4 space-y-4">
              {quizQuestions.map((q, i) => (
                <div key={i} className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
                  <h4 className="font-semibold text-cyan-600 dark:text-cyan-400 mb-2">
                    {i + 1}. {q.question}
                  </h4>
                  <details className="mt-2">
                    <summary className="cursor-pointer text-green-600 dark:text-green-400 font-semibold">
                      Show Answer
                    </summary>
                    <p className="mt-2 pl-4 text-sm">{q.answer}</p>
                  </details>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {activeTab === 'explain' && (
        <div>
          <label className="block text-sm font-medium mb-2">
            Enter a technical term (e.g., 'Idempotency', 'AsNoTracking'):
          </label>
          <input
            type="text"
            value={conceptInput}
            onChange={(e) => setConceptInput(e.target.value)}
            placeholder="Ex: Deadlock or LEFT JOIN"
            className="w-full p-2 rounded-lg bg-gray-100 dark:bg-gray-800 border border-gray-300 dark:border-gray-600 mb-3"
          />
          <button
            onClick={explainConcept}
            disabled={loading || !conceptInput.trim()}
            className="w-full py-2 bg-green-600 hover:bg-green-700 disabled:bg-gray-400 text-white font-semibold rounded-lg transition-colors flex items-center justify-center gap-2"
          >
            {loading ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Explaining...
              </>
            ) : (
              <>
                <Brain className="w-4 h-4" />
                Explain Concept
              </>
            )}
          </button>
          {conceptExplanation && (
            <div className="mt-4 p-4 bg-gray-50 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
              <p className="whitespace-pre-wrap">{conceptExplanation}</p>
            </div>
          )}
        </div>
      )}

      {activeTab === 'behavioral' && (
        <div>
          <label className="block text-sm font-medium mb-2">
            Enter a role/company (e.g., 'C# Intern / Trimble'):
          </label>
          <input
            type="text"
            value={roleInput}
            onChange={(e) => setRoleInput(e.target.value)}
            placeholder="Ex: C# Intern / Trimble"
            className="w-full p-2 rounded-lg bg-gray-100 dark:bg-gray-800 border border-gray-300 dark:border-gray-600 mb-3"
          />
          <button
            onClick={simulateBehavioral}
            disabled={loading}
            className="w-full py-2 bg-yellow-600 hover:bg-yellow-700 disabled:bg-gray-400 text-white font-semibold rounded-lg transition-colors flex items-center justify-center gap-2"
          >
            {loading ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Generating...
              </>
            ) : (
              <>
                <MessageSquare className="w-4 h-4" />
                Generate Question & STAR Structure
              </>
            )}
          </button>
          {behavioralQuestion && (
            <div className="mt-4 p-4 bg-gray-50 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
              <h4 className="text-xl font-bold text-yellow-600 dark:text-yellow-400 mb-2">
                {behavioralQuestion.question}
              </h4>
              <div className="border-t border-gray-300 dark:border-gray-600 my-3"></div>
              <h5 className="text-lg font-semibold mb-2">STAR Method Structure:</h5>
              <ul className="space-y-2">
                <li className="border-l-3 border-yellow-500 pl-2">
                  <span className="font-bold text-yellow-600 dark:text-yellow-400">S - Situation:</span> {behavioralQuestion.star_analysis.Situation}
                </li>
                <li className="border-l-3 border-yellow-500 pl-2">
                  <span className="font-bold text-yellow-600 dark:text-yellow-400">T - Task:</span> {behavioralQuestion.star_analysis.Task}
                </li>
                <li className="border-l-3 border-yellow-500 pl-2">
                  <span className="font-bold text-yellow-600 dark:text-yellow-400">A - Action:</span> {behavioralQuestion.star_analysis.Action}
                </li>
                <li className="border-l-3 border-yellow-500 pl-2">
                  <span className="font-bold text-yellow-600 dark:text-yellow-400">R - Result:</span> {behavioralQuestion.star_analysis.Result}
                </li>
              </ul>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
