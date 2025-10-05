import { useState, useEffect } from 'react';
import { supabase } from './lib/supabase';
import { Category, Term, QuizQuestion } from './types';
import { Sidebar } from './components/Sidebar';
import { TermDetail } from './components/TermDetail';
import { Labs } from './components/Labs';
import { HRTools } from './components/HRTools';
import { AITutor } from './components/AITutor';
import { PomodoroTimer } from './components/PomodoroTimer';
import { AIFeatures } from './components/AIFeatures';
import { InterviewTips } from './components/InterviewTips';
import { QuizPractice } from './components/QuizPractice';
import { BibliaGiga } from './components/BibliaGiga';
import { ApiKeyWarning } from './components/ApiKeyWarning';
import { UserGuide } from './components/UserGuide';
import { Loader, Download, FileText, HelpCircle } from 'lucide-react';

type View = 'term' | 'labs' | 'hr' | 'ai-tools' | 'tips' | 'quiz' | 'biblia-giga';

function App() {
  const [categories, setCategories] = useState<Category[]>([]);
  const [terms, setTerms] = useState<Term[]>([]);
  const [quizQuestions, setQuizQuestions] = useState<QuizQuestion[]>([]);
  const [selectedTermId, setSelectedTermId] = useState<string | null>(null);
  const [view, setView] = useState<View>('term');
  const [loading, setLoading] = useState(true);
  const [showPomodoro, setShowPomodoro] = useState(false);
  const [showUserGuide, setShowUserGuide] = useState(false);

  const selectedTerm = terms.find(t => t.id === selectedTermId) || null;
  const selectedTermQuestions = quizQuestions.filter(q => q.term_id === selectedTermId);

  useEffect(() => {
    loadData();
    return setupKeyboardShortcuts();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);

      const [categoriesRes, termsRes, quizRes] = await Promise.all([
        supabase.from('categories').select('*').order('order_index'),
        supabase.from('terms').select('*').order('order_index'),
        supabase.from('quiz_questions').select('*')
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
      <ApiKeyWarning />
      <Sidebar
        categories={categories}
        terms={terms}
        selectedTermId={selectedTermId}
        onTermSelect={handleTermSelect}
        onLabSelect={() => setView('labs')}
        onHRToolsSelect={() => setView('hr')}
        onAIToolsSelect={() => setView('ai-tools')}
        onTipsSelect={() => setView('tips')}
        onQuizSelect={() => setView('quiz')}
        onBibliaGigaSelect={() => setView('biblia-giga')}
      />

      <main className="lg:ml-80 min-h-screen">
        <div className="p-6">
          <div className="flex justify-between items-center mb-6">
            <div className="flex gap-3">
              {view === 'term' && selectedTerm && (
                <button
                  onClick={exportNotes}
                  className="flex items-center gap-2 bg-gray-800 hover:bg-gray-700 text-gray-300 px-4 py-2 rounded-lg transition-colors border border-gray-700"
                >
                  <Download size={18} />
                  Export Notes
                </button>
              )}
              <button
                onClick={() => setShowPomodoro(!showPomodoro)}
                className="flex items-center gap-2 bg-gray-800 hover:bg-gray-700 text-gray-300 px-4 py-2 rounded-lg transition-colors border border-gray-700"
              >
                <FileText size={18} />
                {showPomodoro ? 'Hide' : 'Show'} Pomodoro
              </button>
              <button
                onClick={() => setShowUserGuide(true)}
                className="flex items-center gap-2 bg-cyan-600 hover:bg-cyan-500 text-white px-4 py-2 rounded-lg transition-colors border border-cyan-500"
              >
                <HelpCircle size={18} />
                User Guide
              </button>
            </div>

            {terms.length === 0 && (
              <div className="text-yellow-400 text-sm">
                No content yet. Database needs seeding.
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

          {view === 'ai-tools' && <AIFeatures />}

          {view === 'tips' && <InterviewTips />}

          {view === 'quiz' && <QuizPractice />}

          {view === 'biblia-giga' && <BibliaGiga />}

          {view === 'term' && !selectedTerm && terms.length === 0 && (
            <div className="max-w-3xl mx-auto bg-gray-800 rounded-xl p-12 text-center border border-gray-700">
              <h2 className="text-3xl font-bold text-white mb-4">Welcome to Internship Prep</h2>
              <p className="text-gray-400 mb-6">
                Your comprehensive study guide is ready. The database needs to be seeded with content.
              </p>
              <p className="text-sm text-gray-500">
                Seed the database with study terms to get started.
              </p>
            </div>
          )}
        </div>
      </main>

      <AITutor currentTerm={selectedTerm} />

      {showUserGuide && <UserGuide onClose={() => setShowUserGuide(false)} />}
    </div>
  );
}

export default App;
