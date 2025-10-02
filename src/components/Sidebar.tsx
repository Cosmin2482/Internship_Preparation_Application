import { useState, useEffect } from 'react';
import { Menu, X, BookOpen } from 'lucide-react';
import { Category, Term } from '../types';

interface SidebarProps {
  categories: Category[];
  terms: Term[];
  selectedTermId: string | null;
  onTermSelect: (termId: string) => void;
  onLabSelect: () => void;
  onHRToolsSelect: () => void;
}

export function Sidebar({
  categories,
  terms,
  selectedTermId,
  onTermSelect,
  onLabSelect,
  onHRToolsSelect
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
              onClick={onLabSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 transition-all font-medium"
            >
              🧪 Interactive Labs
            </button>
          </div>

          <div className="mb-6">
            <button
              onClick={onHRToolsSelect}
              className="w-full text-left px-4 py-3 rounded-lg bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-500 hover:to-pink-500 transition-all font-medium"
            >
              💼 HR & STAR Builder
            </button>
          </div>

          <div className="space-y-2">
            {categories.map((category) => {
              const categoryTerms = (termsByCategory[category.id] || []).sort(
                (a, b) => a.order_index - b.order_index
              );
              const isExpanded = expandedCategory === category.id;

              return (
                <div key={category.id}>
                  <button
                    onClick={() =>
                      setExpandedCategory(isExpanded ? null : category.id)
                    }
                    className="w-full text-left px-4 py-2 rounded-lg hover:bg-gray-800 transition-colors font-medium text-sm flex items-center justify-between"
                  >
                    <span>{category.name}</span>
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
                          className={`w-full text-left px-3 py-2 rounded-lg text-sm transition-colors ${
                            selectedTermId === term.id
                              ? 'bg-cyan-600 text-white'
                              : 'text-gray-300 hover:bg-gray-800'
                          }`}
                        >
                          {term.term}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </nav>

        <div className="p-4 border-t border-gray-700 text-xs text-gray-500">
          <p>Keyboard shortcuts:</p>
          <ul className="mt-2 space-y-1">
            <li><kbd className="px-1 bg-gray-800 rounded">T</kbd> - AI Tutor</li>
            <li><kbd className="px-1 bg-gray-800 rounded">/</kbd> - Search</li>
          </ul>
        </div>
      </aside>
    </>
  );
}
