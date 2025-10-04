import { useState, useEffect } from 'react';
import { supabase } from './lib/supabase';
import { Category, Term, QuizQuestion } from './types';
import { Sidebar } from './components/Sidebar';
import { TermDetail } from './components/TermDetail';
import { Labs } from './components/Labs';
import { HRTools } from './components/HRTools';
import { AITutor } from './components/AITutor';
import { PomodoroTimer } from './components/PomodoroTimer';
import { Loader, Download, FileText, Globe } from 'lucide-react';

type View = 'term' | 'labs' | 'hr';

function App() {
  const [categories, setCategories] = useState<Category[]>([]);
  const [terms, setTerms] = useState<Term[]>([]);
  const [quizQuestions, setQuizQuestions] = useState<QuizQuestion[]>([]);
  const [selectedTermId, setSelectedTermId] = useState<string | null>(null);
  const [view, setView] = useState<View>('term');
  const [loading, setLoading] = useState(true);
  const [tutorOpen, setTutorOpen] = useState(false);
  const [showPomodoro, setShowPomodoro] = useState(false);
  const [language, setLanguage] = useState<'en' | 'ro'>('en');

  const selectedTerm = terms.find(t => t.id === selectedTermId) || null;
  const selectedTermQuestions = quizQuestions.filter(q => q.term_id === selectedTermId);

  useEffect(() => {
    loadData();
    return setupKeyboardShortcuts();
  }, [language]);

  const loadData = async () => {
    try {
      setLoading(true);

      const [categoriesRes, termsRes, quizRes] = await Promise.all([
        supabase.from('categories').select('*').eq('language', language).order('order_index'),
        supabase.from('terms').select('*').eq('language', language).order('order_index'),
        supabase.from('quiz_questions').select('*').eq('language', language)
      ]);

      if (categoriesRes.data) setCategories(categoriesRes.data);
      if (termsRes.data) setTerms(termsRes.data);
      if (quizRes.data) setQuizQuestions(quizRes.data);

      if (termsRes.data && termsRes.data.length > 0) {
        setSelectedTermId(termsRes.data[0].id);
      }
    } catch (error) {
      console.error('Error loading data:', error);
    } finally {
      setLoading(false);
    }
  };

  const setupKeyboardShortcuts = () => {
    const handleKeyPress = (e: KeyboardEvent) => {
      if (e.key === 't' || e.key === 'T') {
        if (!['INPUT', 'TEXTAREA'].includes((e.target as HTMLElement).tagName)) {
          e.preventDefault();
          setTutorOpen(prev => !prev);
        }
      }
      if (e.key === 'p' || e.key === 'P') {
        if (!['INPUT', 'TEXTAREA'].includes((e.target as HTMLElement).tagName)) {
          e.preventDefault();
          setShowPomodoro(prev => !prev);
        }
      }
    };

    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  };

  const handleTermSelect = (termId: string) => {
    setSelectedTermId(termId);
    setView('term');
  };

  const exportNotes = () => {
    if (!selectedTerm) return;

    const markdown = `# ${selectedTerm.term}

## ELI5
${selectedTerm.eli5}

## Formal Definition
${selectedTerm.formal_definition}

## Interview Answer
${selectedTerm.interview_answer}

## Common Pitfalls
${selectedTerm.pitfalls.map((p, i) => `${i + 1}. ${p}`).join('\n')}

## Code Examples

### C#
\`\`\`csharp
${selectedTerm.code_examples.csharp || 'N/A'}
\`\`\`

### TypeScript
\`\`\`typescript
${selectedTerm.code_examples.typescript || 'N/A'}
\`\`\`

## Diagram
\`\`\`
${selectedTerm.diagram}
\`\`\`
`;

    const blob = new Blob([markdown], { type: 'text/markdown' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${selectedTerm.term.replace(/\s+/g, '-')}-notes.md`;
    a.click();
    URL.revokeObjectURL(url);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-950 flex items-center justify-center">
        <div className="text-center">
          <Loader className="animate-spin text-cyan-400 mx-auto mb-4" size={48} />
          <p className="text-gray-400">Loading your study materials...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-950 text-gray-100">
      <Sidebar
        categories={categories}
        terms={terms}
        selectedTermId={selectedTermId}
        onTermSelect={handleTermSelect}
        onLabSelect={() => setView('labs')}
        onHRToolsSelect={() => setView('hr')}
      />

      <main className="lg:ml-80 min-h-screen">
        <div className="p-6">
          <div className="flex justify-between items-center mb-6">
            <div className="flex gap-3 items-center">
              {/* Language Switcher */}
              <div className="flex items-center gap-2 bg-gray-800 border border-gray-700 rounded-lg p-1">
                <button
                  onClick={() => setLanguage('en')}
                  className={`flex items-center gap-2 px-3 py-1.5 rounded transition-colors ${
                    language === 'en'
                      ? 'bg-cyan-600 text-white'
                      : 'text-gray-400 hover:text-gray-200'
                  }`}
                  title="English"
                >
                  <Globe size={16} />
                  EN
                </button>
                <button
                  onClick={() => setLanguage('ro')}
                  className={`flex items-center gap-2 px-3 py-1.5 rounded transition-colors ${
                    language === 'ro'
                      ? 'bg-cyan-600 text-white'
                      : 'text-gray-400 hover:text-gray-200'
                  }`}
                  title="Română"
                >
                  <Globe size={16} />
                  RO
                </button>
              </div>
              {view === 'term' && selectedTerm && (
                <button
                  onClick={exportNotes}
                  className="flex items-center gap-2 bg-gray-800 hover:bg-gray-700 text-gray-300 px-4 py-2 rounded-lg transition-colors border border-gray-700"
                >
                  <Download size={18} />
                  {language === 'en' ? 'Export Notes' : 'Exportă Notițe'}
                </button>
              )}
              <button
                onClick={() => setShowPomodoro(!showPomodoro)}
                className="flex items-center gap-2 bg-gray-800 hover:bg-gray-700 text-gray-300 px-4 py-2 rounded-lg transition-colors border border-gray-700"
              >
                <FileText size={18} />
                {showPomodoro ? (language === 'en' ? 'Hide' : 'Ascunde') : (language === 'en' ? 'Show' : 'Arată')} Pomodoro
              </button>
            </div>

            {terms.length === 0 && (
              <div className="text-yellow-400 text-sm">
                {language === 'en' ? 'No content yet. Database needs seeding.' : 'Niciun conținut încă. Baza de date necesită populare.'}
              </div>
            )}
          </div>

          {showPomodoro && (
            <div className="mb-6 max-w-md">
              <PomodoroTimer />
            </div>
          )}

          {view === 'term' && selectedTerm && (
            <TermDetail term={selectedTerm} quizQuestions={selectedTermQuestions} />
          )}

          {view === 'labs' && <Labs />}

          {view === 'hr' && <HRTools />}

          {view === 'term' && !selectedTerm && terms.length === 0 && (
            <div className="max-w-3xl mx-auto bg-gray-800 rounded-xl p-12 text-center border border-gray-700">
              <h2 className="text-3xl font-bold text-white mb-4">
                {language === 'en' ? 'Welcome to Internship Prep' : 'Bine ai venit la Pregătire Internship'}
              </h2>
              <p className="text-gray-400 mb-6">
                {language === 'en'
                  ? 'Your comprehensive study guide is ready. The database needs to be seeded with content.'
                  : 'Ghidul tău complet de studiu este pregătit. Baza de date necesită conținut.'}
              </p>
              <p className="text-sm text-gray-500">
                {language === 'en'
                  ? 'Seed the database with study terms to get started.'
                  : 'Populează baza de date cu termeni pentru a începe.'}
              </p>
            </div>
          )}
        </div>
      </main>

      <AITutor
        isOpen={tutorOpen}
        onClose={() => setTutorOpen(false)}
        currentTerm={selectedTerm}
      />

      <div className="fixed bottom-4 right-4 bg-gray-800 border border-gray-700 rounded-lg p-3 text-xs text-gray-400 shadow-lg">
        <p className="mb-1 font-bold text-cyan-400">
          {language === 'en' ? 'Keyboard Shortcuts:' : 'Scurtături Tastatură:'}
        </p>
        <p><kbd className="bg-gray-700 px-1 rounded">T</kbd> - {language === 'en' ? 'Toggle AI Tutor' : 'Deschide/Închide AI Tutor'}</p>
        <p><kbd className="bg-gray-700 px-1 rounded">P</kbd> - {language === 'en' ? 'Toggle Pomodoro' : 'Arată/Ascunde Pomodoro'}</p>
      </div>
    </div>
  );
}

export default App;
