import { BookOpen, CheckCircle, Lightbulb, AlertTriangle, Star } from 'lucide-react';

export function InterviewTips() {
  return (
    <div className="space-y-6">
      <div className="bg-gradient-to-r from-cyan-600 to-blue-600 text-white rounded-xl p-6">
        <div className="flex items-center gap-3 mb-4">
          <Star className="w-8 h-8" />
          <h1 className="text-3xl font-bold">Nice to Know for Your Interview</h1>
        </div>
        <p className="text-cyan-50">
          Essential tips, strategies, and advice to help you excel in your Trimble software engineering internship interview.
        </p>
      </div>

      {/* General Interview Strategy */}
      <div className="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl p-6">
        <div className="flex items-center gap-2 mb-4">
          <BookOpen className="w-6 h-6 text-cyan-500" />
          <h2 className="text-2xl font-bold">General Interview Strategy</h2>
        </div>
        <div className="space-y-4">
          <div>
            <h3 className="font-semibold text-lg mb-2">Before the Interview</h3>
            <ul className="list-disc list-inside space-y-2 text-gray-700 dark:text-gray-300">
              <li><strong>Review Your Resume:</strong> Be ready to explain every project, technology, and responsibility listed.</li>
              <li><strong>Research the Company:</strong> Know Trimble's products, values, and recent news. Show genuine interest.</li>
              <li><strong>Prepare STAR Stories:</strong> Have 4-5 stories ready demonstrating problem-solving, teamwork, and technical skills.</li>
              <li><strong>Practice Out Loud:</strong> Don't just think through answers - actually speak them to practice articulation.</li>
              <li><strong>Set Up Your Environment:</strong> Test your camera, microphone, and internet connection beforehand.</li>
            </ul>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2">During the Interview</h3>
            <ul className="list-disc list-inside space-y-2 text-gray-700 dark:text-gray-300">
              <li><strong>Think Out Loud:</strong> Explain your thought process while solving problems - interviewers want to see how you think.</li>
              <li><strong>Ask Clarifying Questions:</strong> Don't assume requirements. Asking questions shows thoroughness and communication skills.</li>
              <li><strong>Take Your Time:</strong> It's okay to pause and think before answering. Better to think than ramble.</li>
              <li><strong>Be Honest:</strong> If you don't know something, say so. Then explain your approach to learning it.</li>
              <li><strong>Show Enthusiasm:</strong> Genuine passion for software engineering stands out more than perfect technical knowledge.</li>
            </ul>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2">After the Interview</h3>
            <ul className="list-disc list-inside space-y-2 text-gray-700 dark:text-gray-300">
              <li><strong>Send a Thank You Email:</strong> Within 24 hours, thank the interviewer and reiterate your interest.</li>
              <li><strong>Reflect and Learn:</strong> Write down questions you struggled with and learn those topics thoroughly.</li>
              <li><strong>Stay Positive:</strong> Every interview is practice, regardless of the outcome.</li>
            </ul>
          </div>
        </div>
      </div>

      {/* Technical Interview Tips */}
      <div className="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl p-6">
        <div className="flex items-center gap-2 mb-4">
          <CheckCircle className="w-6 h-6 text-green-500" />
          <h2 className="text-2xl font-bold">Technical Interview Tips</h2>
        </div>
        <div className="grid md:grid-cols-2 gap-6">
          <div>
            <h3 className="font-semibold text-lg mb-2 text-green-600 dark:text-green-400">DO:</h3>
            <ul className="space-y-2 text-gray-700 dark:text-gray-300">
              <li className="flex items-start gap-2">
                <span className="text-green-500">✓</span>
                <span>Start with clarifying questions about requirements and constraints</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-green-500">✓</span>
                <span>Discuss trade-offs (time vs space complexity, readability vs performance)</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-green-500">✓</span>
                <span>Write clean, readable code with meaningful variable names</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-green-500">✓</span>
                <span>Test your solution with edge cases (empty input, null, large numbers)</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-green-500">✓</span>
                <span>Explain Big-O complexity of your solution</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-green-500">✓</span>
                <span>Suggest optimizations or alternative approaches</span>
              </li>
            </ul>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2 text-red-600 dark:text-red-400">DON'T:</h3>
            <ul className="space-y-2 text-gray-700 dark:text-gray-300">
              <li className="flex items-start gap-2">
                <span className="text-red-500">✗</span>
                <span>Jump into coding immediately without understanding the problem</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-red-500">✗</span>
                <span>Stay silent while coding - explain what you're doing</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-red-500">✗</span>
                <span>Give up easily - interviewers want to see persistence</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-red-500">✗</span>
                <span>Ignore hints from the interviewer - they're trying to help</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-red-500">✗</span>
                <span>Write code without considering error handling</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-red-500">✗</span>
                <span>Claim to know something you don't - be honest about gaps</span>
              </li>
            </ul>
          </div>
        </div>
      </div>

      {/* Common Phrases That Impress */}
      <div className="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl p-6">
        <div className="flex items-center gap-2 mb-4">
          <Lightbulb className="w-6 h-6 text-yellow-500" />
          <h2 className="text-2xl font-bold">Phrases That Impress Interviewers</h2>
        </div>
        <div className="space-y-3">
          <div className="p-3 bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 rounded">
            <p className="font-semibold text-cyan-700 dark:text-cyan-300">
              "I choose override for polymorphism; new is just hiding (binding to reference type), so I avoid it."
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
              Shows deep understanding of OOP mechanics
            </p>
          </div>

          <div className="p-3 bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 rounded">
            <p className="font-semibold text-cyan-700 dark:text-cyan-300">
              "PUT is idempotent - the same request repeated leaves the same state; POST creates a new resource each time."
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
              Demonstrates REST API expertise
            </p>
          </div>

          <div className="p-3 bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 rounded">
            <p className="font-semibold text-cyan-700 dark:text-cyan-300">
              "I use 422 for validation errors, 409 for state conflicts (e.g., concurrency), not 400 for everything."
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
              Shows attention to proper HTTP status code usage
            </p>
          </div>

          <div className="p-3 bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 rounded">
            <p className="font-semibold text-cyan-700 dark:text-cyan-300">
              "In EF Core, I use AsNoTracking for read-only queries to improve performance; tracking only when modifying."
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
              Demonstrates performance awareness
            </p>
          </div>

          <div className="p-3 bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 rounded">
            <p className="font-semibold text-cyan-700 dark:text-cyan-300">
              "I write tests using AAA pattern; mock dependencies through interfaces to isolate the unit."
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
              Shows testing best practices knowledge
            </p>
          </div>
        </div>
      </div>

      {/* Behavioral Interview Tips */}
      <div className="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl p-6">
        <div className="flex items-center gap-2 mb-4">
          <AlertTriangle className="w-6 h-6 text-orange-500" />
          <h2 className="text-2xl font-bold">Behavioral Interview Tips</h2>
        </div>
        <div className="space-y-4">
          <div>
            <h3 className="font-semibold text-lg mb-2">STAR Method Framework</h3>
            <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4">
              <div className="p-4 bg-gradient-to-br from-purple-50 to-purple-100 dark:from-purple-950 dark:to-purple-900 rounded-lg">
                <h4 className="font-bold text-purple-700 dark:text-purple-300 mb-2">Situation</h4>
                <p className="text-sm text-gray-700 dark:text-gray-300">
                  Set the context. What was happening? Where and when?
                </p>
              </div>
              <div className="p-4 bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-950 dark:to-blue-900 rounded-lg">
                <h4 className="font-bold text-blue-700 dark:text-blue-300 mb-2">Task</h4>
                <p className="text-sm text-gray-700 dark:text-gray-300">
                  What was your responsibility? What needed to be done?
                </p>
              </div>
              <div className="p-4 bg-gradient-to-br from-green-50 to-green-100 dark:from-green-950 dark:to-green-900 rounded-lg">
                <h4 className="font-bold text-green-700 dark:text-green-300 mb-2">Action</h4>
                <p className="text-sm text-gray-700 dark:text-gray-300">
                  What specific steps did YOU take? Focus on your contributions.
                </p>
              </div>
              <div className="p-4 bg-gradient-to-br from-yellow-50 to-yellow-100 dark:from-yellow-950 dark:to-yellow-900 rounded-lg">
                <h4 className="font-bold text-yellow-700 dark:text-yellow-300 mb-2">Result</h4>
                <p className="text-sm text-gray-700 dark:text-gray-300">
                  What was the outcome? Quantify when possible (e.g., "reduced bugs by 30%").
                </p>
              </div>
            </div>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2">Common Behavioral Questions</h3>
            <ul className="list-disc list-inside space-y-2 text-gray-700 dark:text-gray-300">
              <li>Tell me about a challenging bug you fixed and how you approached it.</li>
              <li>Describe a time when you disagreed with a team member. How did you resolve it?</li>
              <li>Give an example of when you had to learn a new technology quickly.</li>
              <li>Tell me about a project you're proud of and your specific contributions.</li>
              <li>Describe a situation where you had to ask for help. What did you learn?</li>
              <li>Tell me about a time you failed. What did you learn from it?</li>
            </ul>
          </div>

          <div className="bg-yellow-50 dark:bg-yellow-950 border-l-4 border-yellow-500 p-4 rounded">
            <p className="font-semibold text-yellow-800 dark:text-yellow-200 mb-2">Pro Tip:</p>
            <p className="text-gray-700 dark:text-gray-300">
              Prepare 4-5 STAR stories that can be adapted to different questions. Include stories about:
              technical challenges, teamwork, learning, failure/growth, and going above and beyond.
              Practice them out loud before the interview.
            </p>
          </div>
        </div>
      </div>

      {/* Day-Before Checklist */}
      <div className="bg-gradient-to-r from-green-600 to-teal-600 text-white rounded-xl p-6">
        <h2 className="text-2xl font-bold mb-4">Day-Before-Interview Checklist</h2>
        <div className="grid md:grid-cols-2 gap-4">
          <div>
            <h3 className="font-semibold mb-2">Technical Review (30-60 min)</h3>
            <ul className="space-y-1 text-sm">
              <li>✓ Review OOP four pillars (Encapsulation, Abstraction, Inheritance, Polymorphism)</li>
              <li>✓ Memorize HTTP methods (GET, POST, PUT, PATCH, DELETE) and status codes</li>
              <li>✓ Review SOLID principles briefly</li>
              <li>✓ Practice one coding kata (FizzBuzz, Two Sum, or Reverse String)</li>
              <li>✓ Review SQL JOINs (INNER, LEFT, RIGHT)</li>
              <li>✓ Understand async/await and Task in C#</li>
            </ul>
          </div>
          <div>
            <h3 className="font-semibold mb-2">Practical Preparation</h3>
            <ul className="space-y-1 text-sm">
              <li>✓ Test your internet connection, camera, and microphone</li>
              <li>✓ Prepare a quiet, well-lit space for the interview</li>
              <li>✓ Have a glass of water nearby</li>
              <li>✓ Review your resume and be ready to explain every project</li>
              <li>✓ Prepare 2-3 questions to ask the interviewer</li>
              <li>✓ Get a good night's sleep (8 hours)</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
}
