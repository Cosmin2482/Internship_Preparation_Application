import { useState } from 'react';
import { Menu, X, BookOpen, Sparkles, Star, Brain, BookMarked } from 'lucide-react';
import { Category, Term } from '../types';

interface SidebarProps {
  categories: Category[];
  terms: Term[];
  selectedTermId: string | null;
  onTermSelect: (termId: string) => void;
  onLabSelect: () => void;
  onHRToolsSelect: () => void;
  onAIToolsSelect: () => void;
  onTipsSelect: () => void;
  onQuizSelect: () => void;
  onBibliaGigaSelect: () => void;
}

export function Sidebar({
  categories,
  terms,
  selectedTermId,
  onTermSelect,
  onLabSelect,
  onHRToolsSelect,
  onAIToolsSelect,
  onTipsSelect,
  onQuizSelect,
  onBibliaGigaSelect
}: SidebarProps) {
  const [isOpen, setIsOpen] = useState(true);
  const [expandedCategory, setExpandedCategory] = useState<string | null>(null);

  const termsByCategory = terms.reduce((acc, term) => {
    if (!acc[term.category_id]) acc[term.category_id] = [];
    acc[term.category_id].push(term);
    return acc;
  }, {} as Record<string, Term[]>);

  return (
    <>
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="fixed top-4 left-4 z-50 lg:hidden bg-gray-800 text-white p-2 rounded-lg shadow-lg"
      >
        {isOpen ? <X size={24} /> : <Menu size={24} />}
      </button>

      <aside
        className={`fixed top-0 left-0 h-full bg-gray-900 text-gray-100 border-r border-gray-700 transition-transform duration-300 z-40 overflow-y-auto ${
          isOpen ? 'translate-x-0' : '-translate-x-full'
        } lg:translate-x-0 w-80`}
      >
        <div className="p-6 border-b border-gray-700">
          <div className="flex items-center gap-3">
            <BookOpen className="text-cyan-400" size={32} />
            <div>
              <h1 className="text-xl font-bold">Internship Prep</h1>
              <p className="text-xs text-gray-400">Complete Study Guide</p>
            </div>
          </div>
        </div>

        <nav className="p-4">
          <div className="mb-6">
            <button
              onClick={onBibliaGigaSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-orange-600 to-red-600 hover:from-orange-500 hover:to-red-500 transition-all font-medium flex items-center gap-2 border-2 border-yellow-400 shadow-lg"
            >
              <BookMarked size={20} />
              <span className="font-bold">BIBLIA GIGA</span>
            </button>
          </div>

          <div className="mb-6">
            <button
              onClick={onLabSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 transition-all font-medium"
            >
              🧪 Interactive Labs
            </button>
          </div>

          <div className="mb-6">
            <button
              onClick={onHRToolsSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-green-600 to-teal-600 hover:from-green-500 hover:to-teal-500 transition-all font-medium"
            >
              💼 HR & STAR Builder
            </button>
          </div>

          <div className="mb-6">
            <button
              onClick={onQuizSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-500 hover:to-pink-500 transition-all font-medium flex items-center gap-2"
            >
              <Brain size={18} />
              Quiz Practice
            </button>
          </div>

          <div className="mb-6">
            <button
              onClick={onAIToolsSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 transition-all font-medium flex items-center gap-2"
            >
              <Sparkles size={18} />
              AI Study Tools
            </button>
          </div>

          <div className="mb-6">
            <button
              onClick={onTipsSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-orange-600 to-red-600 hover:from-orange-500 hover:to-red-500 transition-all font-medium flex items-center gap-2"
            >
              <Star size={18} />
              Interview Tips
            </button>
          </div>

          <div className="space-y-2">
            {categories.map((category) => {
              // Sort terms by priority first, then order_index
              const priorityOrder = { '99%': 1, 'high': 2, 'likely': 3, 'medium': 4, 'low': 5 };
              const categoryTerms = (termsByCategory[category.id] || []).sort((a, b) => {
                const aPriority = priorityOrder[a.priority as keyof typeof priorityOrder] || 4;
                const bPriority = priorityOrder[b.priority as keyof typeof priorityOrder] || 4;
                if (aPriority !== bPriority) return aPriority - bPriority;
                return a.order_index - b.order_index;
              });
              const isExpanded = expandedCategory === category.id;

              return (
                <div key={category.id}>
                  <button
                    onClick={() =>
                      setExpandedCategory(isExpanded ? null : category.id)
                    }
                    className="w-full text-left px-4 py-2 rounded-lg hover:bg-gray-800 transition-colors font-medium text-sm flex items-center justify-between"
                  >
                    <div className="flex items-center gap-2">
                      <span>{category.name}</span>
                      {category.priority === '99%' && (
                        <span className="text-xs px-2 py-0.5 rounded bg-red-600 text-white font-bold">99%</span>
                      )}
                      {category.priority === 'likely' && (
                        <span className="text-xs px-2 py-0.5 rounded bg-orange-600 text-white">Likely</span>
                      )}
                      {category.priority === 'medium' && (
                        <span className="text-xs px-2 py-0.5 rounded bg-yellow-600 text-white">Medium</span>
                      )}
                      {category.priority === 'low' && (
                        <span className="text-xs px-2 py-0.5 rounded bg-gray-600 text-white">Low</span>
                      )}
                    </div>
                    <span className="text-gray-500 text-xs">
                      {categoryTerms.length}
                    </span>
                  </button>

                  {isExpanded && (
                    <div className="ml-4 mt-1 space-y-1">
                      {categoryTerms.map((term) => (
                        <button
                          key={term.id}
                          onClick={() => onTermSelect(term.id)}
                          className={`w-full text-left px-3 py-2 rounded-lg text-sm transition-colors flex items-center justify-between gap-2 ${
                            selectedTermId === term.id
                              ? 'bg-cyan-600 text-white'
                              : 'text-gray-300 hover:bg-gray-800'
                          }`}
                        >
                          <span className="flex-1">{term.term}</span>
                          {term.priority === '99%' && (
                            <span className="text-xs px-1.5 py-0.5 rounded bg-red-600 text-white font-bold shrink-0">99%</span>
                          )}
                          {term.priority === 'high' && (
                            <span className="text-xs px-1.5 py-0.5 rounded bg-red-500 text-white font-bold shrink-0">High</span>
                          )}
                          {term.priority === 'likely' && (
                            <span className="text-xs px-1.5 py-0.5 rounded bg-orange-500 text-white shrink-0">Likely</span>
                          )}
                          {term.priority === 'medium' && (
                            <span className="text-xs px-1.5 py-0.5 rounded bg-yellow-600 text-white shrink-0">Medium</span>
                          )}
                          {term.priority === 'low' && (
                            <span className="text-xs px-1.5 py-0.5 rounded bg-gray-600 text-white shrink-0">Low</span>
                          )}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </nav>
      </aside>
    </>
  );
}
