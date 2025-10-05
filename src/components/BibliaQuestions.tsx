import { useState, useEffect } from 'react';
import { ChevronRight, Eye, EyeOff, BookOpen } from 'lucide-react';
import { supabase } from '../lib/supabase';

interface BibliaQuestion {
  id: string;
  question: string;
  correct_answer: string;
  category: string;
  difficulty: string;
  order_index: number;
}

export function BibliaQuestions() {
  const [questions, setQuestions] = useState<BibliaQuestion[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [showAnswer, setShowAnswer] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadQuestions();
  }, []);

  const loadQuestions = async () => {
    setLoading(true);
    const { data, error } = await supabase
      .from('biblia_questions')
      .select('*')
      .order('order_index', { ascending: true });

    if (error) {
      console.error('Error loading questions:', error);
    } else {
      setQuestions(data || []);
    }
    setLoading(false);
  };

  const handleNext = () => {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setShowAnswer(false);
    }
  };

  const handlePrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
      setShowAnswer(false);
    }
  };

  const toggleAnswer = () => {
    setShowAnswer(!showAnswer);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center py-12">
        <div className="text-white text-lg">Se incarca intrebarile...</div>
      </div>
    );
  }

  if (questions.length === 0) {
    return (
      <div className="flex items-center justify-center py-12">
        <div className="text-white text-lg">Nu sunt intrebari disponibile.</div>
      </div>
    );
  }

  const currentQuestion = questions[currentIndex];

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'easy':
        return 'bg-green-600';
      case 'medium':
        return 'bg-yellow-600';
      case 'hard':
        return 'bg-red-600';
      default:
        return 'bg-gray-600';
    }
  };

  const getDifficultyLabel = (difficulty: string) => {
    switch (difficulty) {
      case 'easy':
        return 'Usor';
      case 'medium':
        return 'Mediu';
      case 'hard':
        return 'Dificil';
      default:
        return difficulty;
    }
  };

  return (
    <div className="space-y-6">
      <div className="bg-gradient-to-r from-cyan-600 to-blue-600 rounded-xl p-6 border border-cyan-400">
        <div className="flex items-center gap-3 mb-3">
          <BookOpen className="text-white" size={32} />
          <h2 className="text-3xl font-bold text-white">Intrebari de Interviu Interactive</h2>
        </div>
        <p className="text-white text-lg">
          {questions.length} intrebari din toate categoriile. Studiaza fiecare intrebare, incearca sa raspunzi mental,
          apoi verifica raspunsul corect.
        </p>
      </div>

      <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-3">
            <span className="text-gray-400 text-sm font-medium">
              Intrebarea {currentIndex + 1} din {questions.length}
            </span>
            <span className={`${getDifficultyColor(currentQuestion.difficulty)} px-3 py-1 rounded-full text-white text-xs font-semibold`}>
              {getDifficultyLabel(currentQuestion.difficulty)}
            </span>
            <span className="bg-purple-600 px-3 py-1 rounded-full text-white text-xs font-semibold">
              {currentQuestion.category}
            </span>
          </div>
          <div className="text-gray-400 text-sm">
            {Math.round(((currentIndex + 1) / questions.length) * 100)}% completat
          </div>
        </div>

        <div className="mb-6">
          <div className="w-full bg-gray-700 rounded-full h-2">
            <div
              className="bg-cyan-500 h-2 rounded-full transition-all duration-300"
              style={{ width: `${((currentIndex + 1) / questions.length) * 100}%` }}
            />
          </div>
        </div>

        <div className="bg-gray-900 rounded-lg p-6 border border-gray-700 mb-6">
          <h3 className="text-xl font-bold text-white mb-4">Intrebare:</h3>
          <p className="text-gray-200 text-lg leading-relaxed">{currentQuestion.question}</p>
        </div>

        <div className="mb-6">
          <button
            onClick={toggleAnswer}
            className={`w-full flex items-center justify-center gap-2 px-6 py-4 rounded-lg font-semibold text-lg transition-all ${
              showAnswer
                ? 'bg-gray-700 hover:bg-gray-600 text-white'
                : 'bg-gradient-to-r from-orange-600 to-red-600 hover:from-orange-500 hover:to-red-500 text-white'
            }`}
          >
            {showAnswer ? (
              <>
                <EyeOff size={24} />
                Ascunde raspunsul
              </>
            ) : (
              <>
                <Eye size={24} />
                Arata raspunsul corect
              </>
            )}
          </button>
        </div>

        {showAnswer && (
          <div className="bg-gradient-to-r from-green-900/50 to-teal-900/50 rounded-lg p-6 border-2 border-green-500 mb-6 animate-fadeIn">
            <h3 className="text-xl font-bold text-green-300 mb-4 flex items-center gap-2">
              <Eye size={24} />
              Raspuns Corect:
            </h3>
            <p className="text-gray-100 text-lg leading-relaxed whitespace-pre-line">{currentQuestion.correct_answer}</p>
          </div>
        )}

        <div className="flex gap-4">
          <button
            onClick={handlePrevious}
            disabled={currentIndex === 0}
            className="flex-1 px-6 py-3 bg-gray-700 hover:bg-gray-600 disabled:bg-gray-800 disabled:text-gray-600 disabled:cursor-not-allowed text-white rounded-lg font-semibold transition-all flex items-center justify-center gap-2"
          >
            <ChevronRight size={20} className="rotate-180" />
            Inapoi
          </button>
          <button
            onClick={handleNext}
            disabled={currentIndex === questions.length - 1}
            className="flex-1 px-6 py-3 bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 disabled:from-gray-700 disabled:to-gray-700 disabled:text-gray-600 disabled:cursor-not-allowed text-white rounded-lg font-semibold transition-all flex items-center justify-center gap-2"
          >
            Urmatoarea
            <ChevronRight size={20} />
          </button>
        </div>
      </div>

      <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
        <h3 className="text-xl font-bold text-white mb-4">Categorii disponibile:</h3>
        <div className="flex flex-wrap gap-2">
          {Array.from(new Set(questions.map(q => q.category))).map((category) => {
            const count = questions.filter(q => q.category === category).length;
            return (
              <span
                key={category}
                className="bg-purple-600/20 border border-purple-500 px-4 py-2 rounded-lg text-purple-300 text-sm"
              >
                {category} ({count})
              </span>
            );
          })}
        </div>
      </div>
    </div>
  );
}
