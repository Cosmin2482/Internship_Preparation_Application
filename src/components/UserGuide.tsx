import { X, BookOpen, Clock, Target, Zap, CheckCircle, AlertCircle } from 'lucide-react';

interface UserGuideProps {
  onClose: () => void;
}

export function UserGuide({ onClose }: UserGuideProps) {
  return (
    <div className="fixed inset-0 bg-black/80 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div className="bg-gray-900 rounded-xl max-w-4xl w-full max-h-[90vh] overflow-y-auto border border-gray-700 shadow-2xl">
        <div className="sticky top-0 bg-gray-900 border-b border-gray-700 p-6 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <BookOpen className="text-cyan-400" size={28} />
            <h2 className="text-2xl font-bold text-white">User Guide - Master the Platform</h2>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-gray-800 rounded-lg transition-colors"
          >
            <X className="text-gray-400" size={24} />
          </button>
        </div>

        <div className="p-6 space-y-8">
          <section className="bg-gradient-to-r from-cyan-900/30 to-blue-900/30 border border-cyan-800/50 rounded-lg p-6">
            <div className="flex items-start gap-3">
              <Target className="text-cyan-400 shrink-0 mt-1" size={24} />
              <div>
                <h3 className="text-xl font-bold text-cyan-400 mb-3">Welcome to Your Study Platform</h3>
                <p className="text-gray-300 leading-relaxed">
                  This comprehensive study platform is designed to help you master technical concepts for your interviews.
                  It combines structured learning, AI-powered practice, hands-on labs, and time management tools to maximize your preparation efficiency.
                </p>
              </div>
            </div>
          </section>

          <section>
            <div className="flex items-center gap-2 mb-4">
              <Zap className="text-yellow-400" size={24} />
              <h3 className="text-xl font-bold text-white">Recommended Study Approach</h3>
            </div>
            <div className="space-y-4">
              <div className="bg-gray-800 rounded-lg p-5 border border-gray-700">
                <div className="flex items-start gap-3">
                  <span className="flex items-center justify-center w-8 h-8 rounded-full bg-cyan-600 text-white font-bold shrink-0">1</span>
                  <div>
                    <h4 className="font-semibold text-white mb-2">Start with High-Priority Categories</h4>
                    <p className="text-gray-300 text-sm leading-relaxed">
                      In the sidebar, focus on categories marked as <span className="text-cyan-400 font-medium">high priority</span>.
                      These include OOP, C#, HTTP/REST, SQL, and .NET fundamentals - the core topics most frequently asked in interviews.
                    </p>
                  </div>
                </div>
              </div>

              <div className="bg-gray-800 rounded-lg p-5 border border-gray-700">
                <div className="flex items-start gap-3">
                  <span className="flex items-center justify-center w-8 h-8 rounded-full bg-cyan-600 text-white font-bold shrink-0">2</span>
                  <div>
                    <h4 className="font-semibold text-white mb-2">Read & Understand Each Term</h4>
                    <p className="text-gray-300 text-sm leading-relaxed">
                      Click on terms in the sidebar to view detailed explanations. Read carefully, take notes, and use the
                      <span className="text-cyan-400 font-medium"> AI Tutor</span> (purple button, bottom right) to ask clarifying questions.
                      The AI can explain concepts in different ways, provide examples, or simplify complex ideas.
                    </p>
                  </div>
                </div>
              </div>

              <div className="bg-gray-800 rounded-lg p-5 border border-gray-700">
                <div className="flex items-start gap-3">
                  <span className="flex items-center justify-center w-8 h-8 rounded-full bg-cyan-600 text-white font-bold shrink-0">3</span>
                  <div>
                    <h4 className="font-semibold text-white mb-2">Practice with Quiz Questions</h4>
                    <p className="text-gray-300 text-sm leading-relaxed">
                      After studying terms, test your understanding in the <span className="text-cyan-400 font-medium">Quiz Practice</span> section.
                      Answer questions in your own words - the AI will evaluate your understanding and provide personalized feedback,
                      just like a real interviewer would.
                    </p>
                  </div>
                </div>
              </div>

              <div className="bg-gray-800 rounded-lg p-5 border border-gray-700">
                <div className="flex items-start gap-3">
                  <span className="flex items-center justify-center w-8 h-8 rounded-full bg-cyan-600 text-white font-bold shrink-0">4</span>
                  <div>
                    <h4 className="font-semibold text-white mb-2">Complete Hands-On Labs</h4>
                    <p className="text-gray-300 text-sm leading-relaxed">
                      The <span className="text-cyan-400 font-medium">Labs</span> section contains practical coding exercises.
                      These help you apply theoretical knowledge and build real implementations. Complete labs for OOP, HTTP,
                      .NET, and Angular to strengthen practical skills.
                    </p>
                  </div>
                </div>
              </div>

              <div className="bg-gray-800 rounded-lg p-5 border border-gray-700">
                <div className="flex items-start gap-3">
                  <span className="flex items-center justify-center w-8 h-8 rounded-full bg-cyan-600 text-white font-bold shrink-0">5</span>
                  <div>
                    <h4 className="font-semibold text-white mb-2">Prepare for HR & Behavioral Questions</h4>
                    <p className="text-gray-300 text-sm leading-relaxed">
                      Visit <span className="text-cyan-400 font-medium">HR Tools</span> to practice common behavioral questions.
                      Prepare your STAR method responses and review the <span className="text-cyan-400 font-medium">Interview Tips</span>
                      section for best practices on presentation and communication.
                    </p>
                  </div>
                </div>
              </div>

              <div className="bg-gray-800 rounded-lg p-5 border border-gray-700">
                <div className="flex items-start gap-3">
                  <span className="flex items-center justify-center w-8 h-8 rounded-full bg-cyan-600 text-white font-bold shrink-0">6</span>
                  <div>
                    <h4 className="font-semibold text-white mb-2">Use Biblia Giga for Comprehensive Review</h4>
                    <p className="text-gray-300 text-sm leading-relaxed">
                      The <span className="text-cyan-400 font-medium">Biblia Giga</span> section contains curated interview questions
                      organized by category. This is your final review before interviews - practice answering these without looking at the answers first.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <section>
            <div className="flex items-center gap-2 mb-4">
              <Clock className="text-blue-400" size={24} />
              <h3 className="text-xl font-bold text-white">Time Management & Study Schedule</h3>
            </div>
            <div className="bg-gray-800 rounded-lg p-5 border border-gray-700 space-y-4">
              <div>
                <h4 className="font-semibold text-white mb-2">Use the Pomodoro Timer</h4>
                <p className="text-gray-300 text-sm leading-relaxed mb-3">
                  Click <span className="text-cyan-400 font-medium">Show Pomodoro</span> to enable the timer.
                  Study in focused 25-minute sessions with 5-minute breaks. This prevents burnout and maximizes retention.
                </p>
              </div>

              <div className="bg-gray-900 rounded-lg p-4 space-y-3">
                <p className="text-white font-medium">Recommended Study Timeline:</p>
                <div className="space-y-2 text-sm">
                  <div className="flex justify-between items-center">
                    <span className="text-gray-300">High-Priority Categories (OOP, C#, HTTP, SQL, .NET)</span>
                    <span className="text-cyan-400 font-medium">7-10 days</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-gray-300">Medium-Priority Categories (React, JavaScript, Testing)</span>
                    <span className="text-cyan-400 font-medium">5-7 days</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-gray-300">Hands-On Labs</span>
                    <span className="text-cyan-400 font-medium">3-5 days</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-gray-300">Quiz Practice & Review</span>
                    <span className="text-cyan-400 font-medium">2-3 days</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-gray-300">HR Questions & Behavioral Prep</span>
                    <span className="text-cyan-400 font-medium">2-3 days</span>
                  </div>
                  <div className="flex justify-between items-center border-t border-gray-700 pt-2 mt-2">
                    <span className="text-white font-semibold">Total Estimated Time</span>
                    <span className="text-green-400 font-bold">3-4 weeks</span>
                  </div>
                </div>
              </div>

              <div className="bg-blue-900/20 border border-blue-800 rounded-lg p-4">
                <p className="text-blue-300 text-sm">
                  <span className="font-semibold">Pro Tip:</span> Study 2-3 hours per day with regular breaks.
                  Consistency is more important than cramming. Review previously studied material every few days to strengthen retention.
                </p>
              </div>
            </div>
          </section>

          <section>
            <div className="flex items-center gap-2 mb-4">
              <CheckCircle className="text-green-400" size={24} />
              <h3 className="text-xl font-bold text-white">Platform Features Overview</h3>
            </div>
            <div className="grid md:grid-cols-2 gap-4">
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">Terms Library</h4>
                <p className="text-gray-300 text-sm">Browse 150+ technical terms with detailed explanations, organized by category and priority.</p>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">AI Tutor</h4>
                <p className="text-gray-300 text-sm">Ask questions, get explanations, and request examples from your personal AI tutor.</p>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">Quiz Practice</h4>
                <p className="text-gray-300 text-sm">Answer questions in your own words and receive AI-powered feedback like a real interviewer.</p>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">Hands-On Labs</h4>
                <p className="text-gray-300 text-sm">Complete practical coding exercises to apply theoretical knowledge.</p>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">HR Tools</h4>
                <p className="text-gray-300 text-sm">Prepare for behavioral questions with STAR method guidance and common interview questions.</p>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">Interview Tips</h4>
                <p className="text-gray-300 text-sm">Learn best practices for interviews, communication strategies, and presentation skills.</p>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">Biblia Giga</h4>
                <p className="text-gray-300 text-sm">Comprehensive collection of curated interview questions for final review.</p>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 border border-gray-700">
                <h4 className="font-semibold text-cyan-400 mb-2">Pomodoro Timer</h4>
                <p className="text-gray-300 text-sm">Built-in timer to manage study sessions and maintain focus with regular breaks.</p>
              </div>
            </div>
          </section>

          <section>
            <div className="flex items-center gap-2 mb-4">
              <AlertCircle className="text-orange-400" size={24} />
              <h3 className="text-xl font-bold text-white">Pro Tips for Maximum Efficiency</h3>
            </div>
            <div className="bg-gray-800 rounded-lg p-5 border border-gray-700 space-y-3">
              <div className="flex items-start gap-3">
                <span className="text-cyan-400 font-bold">•</span>
                <p className="text-gray-300 text-sm">
                  <span className="text-white font-medium">Active Learning:</span> Don't just read - explain concepts out loud,
                  write your own examples, and teach the material to someone else (or pretend to).
                </p>
              </div>
              <div className="flex items-start gap-3">
                <span className="text-cyan-400 font-bold">•</span>
                <p className="text-gray-300 text-sm">
                  <span className="text-white font-medium">Spaced Repetition:</span> Review material multiple times over several days.
                  Return to difficult topics after 1 day, 3 days, and 1 week to strengthen long-term memory.
                </p>
              </div>
              <div className="flex items-start gap-3">
                <span className="text-cyan-400 font-bold">•</span>
                <p className="text-gray-300 text-sm">
                  <span className="text-white font-medium">Export Notes:</span> Use the "Export Notes" button to download your study materials.
                  Create your own condensed cheat sheets for quick review.
                </p>
              </div>
              <div className="flex items-start gap-3">
                <span className="text-cyan-400 font-bold">•</span>
                <p className="text-gray-300 text-sm">
                  <span className="text-white font-medium">Simulate Interview Conditions:</span> Practice answering quiz questions
                  without looking at notes. Time yourself and practice speaking answers out loud.
                </p>
              </div>
              <div className="flex items-start gap-3">
                <span className="text-cyan-400 font-bold">•</span>
                <p className="text-gray-300 text-sm">
                  <span className="text-white font-medium">Focus on Understanding, Not Memorization:</span> Interviewers can tell
                  when you've memorized vs. understood. Use the AI Tutor to ask "why" and "how" questions until concepts click.
                </p>
              </div>
              <div className="flex items-start gap-3">
                <span className="text-cyan-400 font-bold">•</span>
                <p className="text-gray-300 text-sm">
                  <span className="text-white font-medium">Stay Consistent:</span> 2 hours daily for 3 weeks is better than
                  14 hours in 3 days. Your brain needs time to consolidate information.
                </p>
              </div>
            </div>
          </section>

          <section className="bg-gradient-to-r from-green-900/30 to-cyan-900/30 border border-green-800/50 rounded-lg p-6">
            <div className="flex items-start gap-3">
              <CheckCircle className="text-green-400 shrink-0 mt-1" size={24} />
              <div>
                <h3 className="text-xl font-bold text-green-400 mb-3">You're Ready to Succeed</h3>
                <p className="text-gray-300 leading-relaxed mb-3">
                  This platform contains everything you need to prepare thoroughly for your technical interviews.
                  Follow the recommended approach, stay consistent, and use all the tools available to you.
                </p>
                <p className="text-gray-300 leading-relaxed">
                  Remember: The goal isn't to memorize everything perfectly, but to understand concepts well enough
                  to explain them clearly and apply them in real scenarios. Good luck!
                </p>
              </div>
            </div>
          </section>
        </div>

        <div className="sticky bottom-0 bg-gray-900 border-t border-gray-700 p-6">
          <button
            onClick={onClose}
            className="w-full px-6 py-3 bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 text-white font-medium rounded-lg transition-all"
          >
            Got it, let's start learning!
          </button>
        </div>
      </div>
    </div>
  );
}
