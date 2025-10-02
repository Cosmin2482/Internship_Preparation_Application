import { useState } from 'react';
import { QuizQuestion } from '../types';
import { CheckCircle, XCircle, HelpCircle } from 'lucide-react';

interface QuizSectionProps {
  questions: QuizQuestion[];
}

export function QuizSection({ questions }: QuizSectionProps) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [showExplanation, setShowExplanation] = useState(false);

  const currentQuestion = questions[currentIndex];

  const handleAnswerSelect = (index: number) => {
    setSelectedAnswer(index);
    setShowExplanation(true);
  };

  const handleNext = () => {
    setCurrentIndex((prev) => (prev + 1) % questions.length);
    setSelectedAnswer(null);
    setShowExplanation(false);
  };

  const isCorrect = selectedAnswer === currentQuestion.correct_index;

  return (
    <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
      <div className="flex items-center gap-3 mb-6">
        <HelpCircle className="text-pink-400" size={24} />
        <h2 className="text-2xl font-bold text-white">Quiz Time</h2>
        <span className="ml-auto text-sm text-gray-400">
          Question {currentIndex + 1} of {questions.length}
        </span>
      </div>

      <div className="mb-6">
        <p className="text-lg text-gray-200 mb-4">{currentQuestion.question}</p>

        <div className="space-y-3">
          {currentQuestion.choices.map((choice, index) => {
            const isSelected = selectedAnswer === index;
            const isCorrectAnswer = index === currentQuestion.correct_index;
            const showCorrect = showExplanation && isCorrectAnswer;
            const showIncorrect = showExplanation && isSelected && !isCorrect;

            return (
              <button
                key={index}
                onClick={() => !showExplanation && handleAnswerSelect(index)}
                disabled={showExplanation}
                className={`w-full text-left p-4 rounded-lg border-2 transition-all ${
                  showCorrect
                    ? 'border-green-500 bg-green-900/30'
                    : showIncorrect
                    ? 'border-red-500 bg-red-900/30'
                    : isSelected
                    ? 'border-cyan-500 bg-cyan-900/30'
                    : 'border-gray-600 bg-gray-700 hover:border-gray-500'
                } ${showExplanation ? 'cursor-default' : 'cursor-pointer'}`}
              >
                <div className="flex items-center justify-between">
                  <span className="text-gray-200">{choice}</span>
                  {showCorrect && (
                    <CheckCircle className="text-green-400" size={20} />
                  )}
                  {showIncorrect && <XCircle className="text-red-400" size={20} />}
                </div>
              </button>
            );
          })}
        </div>
      </div>

      {showExplanation && (
        <div
          className={`p-4 rounded-lg mb-4 ${
            isCorrect ? 'bg-green-900/30 border border-green-500' : 'bg-red-900/30 border border-red-500'
          }`}
        >
          <p className={`font-bold mb-2 ${isCorrect ? 'text-green-400' : 'text-red-400'}`}>
            {isCorrect ? 'Correct!' : 'Incorrect'}
          </p>
          <p className="text-gray-300">{currentQuestion.explanation}</p>
        </div>
      )}

      {showExplanation && (
        <button
          onClick={handleNext}
          className="w-full bg-cyan-600 hover:bg-cyan-500 text-white font-bold py-3 rounded-lg transition-colors"
        >
          Next Question
        </button>
      )}
    </section>
  );
}
