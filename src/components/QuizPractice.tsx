import { useState, useEffect } from 'react';
import { ArrowRight, RefreshCw, BookOpen, MessageSquare } from 'lucide-react';

interface QuizQuestion {
  id: string;
  question: string;
  choices: string[];
  correct_index: number;
  explanation: string;
  term: string;
}

const GEMINI_API_KEY = import.meta.env.VITE_GEMINI_API_KEY;
const GEMINI_MODEL = 'gemini-2.5-flash';

export function QuizPractice() {
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [userAnswer, setUserAnswer] = useState('');
  const [isChecking, setIsChecking] = useState(false);
  const [feedback, setFeedback] = useState<{
    isCorrect: boolean | null;
    aiResponse: string;
    modelAnswer: string;
    explanation: string;
  } | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchQuestions();
  }, []);

  const fetchQuestions = async () => {
    setLoading(true);
    try {
      const { createClient } = await import('@supabase/supabase-js');
      const supabase = createClient(
        import.meta.env.VITE_SUPABASE_URL,
        import.meta.env.VITE_SUPABASE_ANON_KEY
      );

      const { data, error } = await supabase
        .from('quiz_questions')
        .select(`
          id,
          question,
          choices,
          correct_index,
          explanation,
          term:terms(term)
        `);

      if (error) throw error;

      const formatted = data.map((q: any) => ({
        id: q.id,
        question: q.question,
        choices: q.choices,
        correct_index: q.correct_index,
        explanation: q.explanation,
        term: q.term.term
      }));

      setQuestions(formatted.sort(() => Math.random() - 0.5));
    } catch (err) {
      console.error('Error fetching questions:', err);
    } finally {
      setLoading(false);
    }
  };

  const checkAnswerWithAI = async () => {
    if (!userAnswer.trim() || !questions[currentIndex]) return;

    setIsChecking(true);
    const currentQ = questions[currentIndex];
    const correctAnswer = currentQ.choices[currentQ.correct_index];

    try {
      // Sanitize inputs to prevent JSON issues
      const sanitize = (text: string) => text.replace(/[\n\r]/g, ' ').replace(/"/g, "'").trim();

      const prompt = `You are a friendly technical interviewer helping a candidate prepare. You're evaluating this answer:

QUESTION: ${sanitize(currentQ.question)}
EXPECTED ANSWER: ${sanitize(correctAnswer)}
CANDIDATE'S ANSWER: ${sanitize(userAnswer)}

Act like an interviewer: Give conversational feedback on their answer. Mention what they got right, what's missing or incorrect, and what the complete answer should include. Be encouraging but honest. Keep it to 3-4 sentences max.`;

      const response = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            contents: [{ parts: [{ text: prompt }] }],
            generationConfig: {
              temperature: 0.3,
              maxOutputTokens: 500,
              candidateCount: 1
            }
          })
        }
      );

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`API Error: ${response.status} - ${errorText}`);
      }

      const result = await response.json();
      console.log('Full Gemini response:', JSON.stringify(result, null, 2));

      // Check if response was blocked or filtered
      if (result.promptFeedback?.blockReason) {
        throw new Error(`Content blocked: ${result.promptFeedback.blockReason}`);
      }

      const aiText = result.candidates?.[0]?.content?.parts?.[0]?.text || '';
      const finishReason = result.candidates?.[0]?.finishReason;

      // Check if we have no text at all
      if (!aiText) {
        console.error('Empty response from AI. Full result:', result);
        console.error('Finish reason:', finishReason);

        // Only throw error if we truly have no content
        if (finishReason === 'SAFETY' || finishReason === 'RECITATION') {
          throw new Error(`Content blocked: ${finishReason}`);
        }

        throw new Error('No response from AI - empty text content');
      }

      // If we have text but hit MAX_TOKENS, just use what we got
      console.log('Raw AI response:', aiText);
      if (finishReason === 'MAX_TOKENS') {
        console.warn('Response was truncated due to MAX_TOKENS, but using what we received');
      }

      setFeedback({
        isCorrect: null, // No strict correct/incorrect - just conversational feedback
        aiResponse: aiText.trim() || 'No feedback received. Please try again.',
        modelAnswer: correctAnswer,
        explanation: currentQ.explanation
      });
    } catch (error) {
      console.error('Error checking answer:', error);
      const errorMsg = error instanceof Error ? error.message : 'Unknown error';
      setFeedback({
        isCorrect: false,
        aiResponse: `Error: ${errorMsg}. Please check your internet connection and API key configuration.`,
        modelAnswer: correctAnswer,
        explanation: currentQ.explanation
      });
    } finally {
      setIsChecking(false);
    }
  };

  const nextQuestion = () => {
    setCurrentIndex((prev) => (prev + 1) % questions.length);
    setUserAnswer('');
    setFeedback(null);
  };

  const resetQuiz = () => {
    setQuestions((prev) => [...prev].sort(() => Math.random() - 0.5));
    setCurrentIndex(0);
    setUserAnswer('');
    setFeedback(null);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-cyan-500"></div>
      </div>
    );
  }

  if (questions.length === 0) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-400">No quiz questions available.</p>
      </div>
    );
  }

  const currentQ = questions[currentIndex];

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <BookOpen className="text-cyan-400" size={32} />
          <div>
            <h2 className="text-2xl font-bold text-white">Quiz Practice</h2>
            <p className="text-sm text-gray-400">Answer in your own words</p>
          </div>
        </div>
        <button
          onClick={resetQuiz}
          className="flex items-center gap-2 px-4 py-2 bg-gray-800 hover:bg-gray-700 rounded-lg transition-colors"
        >
          <RefreshCw size={16} />
          Shuffle
        </button>
      </div>

      <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
        <div className="flex items-center justify-between mb-4">
          <span className="text-sm text-gray-400">
            Question {currentIndex + 1} of {questions.length}
          </span>
          <span className="px-3 py-1 bg-cyan-600 text-white text-xs font-medium rounded-full">
            {currentQ.term}
          </span>
        </div>

        <h3 className="text-xl font-semibold text-white mb-6">
          {currentQ.question}
        </h3>

        {!feedback ? (
          <div className="space-y-4">
            <textarea
              value={userAnswer}
              onChange={(e) => setUserAnswer(e.target.value)}
              placeholder="Type your answer here..."
              className="w-full h-32 bg-gray-900 border border-gray-700 rounded-lg p-4 text-white placeholder-gray-500 focus:ring-2 focus:ring-cyan-500 focus:border-transparent"
              disabled={isChecking}
            />
            <button
              onClick={checkAnswerWithAI}
              disabled={!userAnswer.trim() || isChecking}
              className="w-full px-6 py-3 bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 disabled:from-gray-700 disabled:to-gray-700 disabled:cursor-not-allowed text-white font-medium rounded-lg transition-all"
            >
              {isChecking ? 'Checking with AI...' : 'Check Answer'}
            </button>
          </div>
        ) : (
          <div className="space-y-4">
            <div className="flex items-start gap-3 p-4 rounded-lg bg-blue-900/20 border border-blue-800">
              <MessageSquare className="text-blue-400 shrink-0 mt-1" size={24} />
              <div className="flex-1">
                <h4 className="font-semibold mb-2 text-blue-400">
                  Interviewer Feedback
                </h4>
                <p className="text-gray-300 text-sm mb-3 leading-relaxed">
                  {feedback.aiResponse}
                </p>
                <div className="space-y-2 text-sm">
                  <div>
                    <span className="text-gray-400">Your Answer: </span>
                    <span className="text-white">{userAnswer}</span>
                  </div>
                  <div>
                    <span className="text-gray-400">Expected Answer: </span>
                    <span className="text-cyan-400 font-medium">{feedback.modelAnswer}</span>
                  </div>
                  <div>
                    <span className="text-gray-400">Additional Context: </span>
                    <span className="text-gray-300">{feedback.explanation}</span>
                  </div>
                </div>
              </div>
            </div>

            <button
              onClick={nextQuestion}
              className="w-full flex items-center justify-center gap-2 px-6 py-3 bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 text-white font-medium rounded-lg transition-all"
            >
              Next Question
              <ArrowRight size={18} />
            </button>
          </div>
        )}
      </div>

      <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
        <p className="text-sm text-gray-400 text-center">
          Answer in your own words. AI will evaluate if your understanding is correct, even if wording differs.
        </p>
      </div>
    </div>
  );
}
