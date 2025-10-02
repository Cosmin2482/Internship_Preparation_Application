import { useState } from 'react';
import { Briefcase, Copy, CheckCircle } from 'lucide-react';
import { STARStory } from '../types';

const HR_QUESTIONS = [
  {
    question: 'Tell me about a time you faced a conflict with a team member',
    scaffold: [
      'Describe the disagreement and why it arose',
      'Explain how you approached the conversation',
      'Detail the resolution and what you learned',
      'Highlight the positive outcome for the team'
    ]
  },
  {
    question: 'Describe your biggest failure and what you learned',
    scaffold: [
      'Set context for the situation and stakes',
      'Explain what went wrong and why',
      'Detail the immediate actions you took',
      'Share long-term lessons and how you\'ve applied them'
    ]
  },
  {
    question: 'Tell me about the hardest bug you\'ve debugged',
    scaffold: [
      'Describe the symptom and impact',
      'Explain your debugging approach and tools used',
      'Detail the root cause discovered',
      'Share prevention measures you implemented'
    ]
  },
  {
    question: 'How do you handle tight deadlines and pressure?',
    scaffold: [
      'Give a specific example of a high-pressure situation',
      'Explain your prioritization strategy',
      'Detail communication with stakeholders',
      'Share the successful outcome'
    ]
  },
  {
    question: 'Describe a time you had to learn something quickly',
    scaffold: [
      'Set context for why rapid learning was needed',
      'Explain your learning strategy and resources',
      'Detail how you applied the new knowledge',
      'Share the measurable impact'
    ]
  }
];

export function HRTools() {
  const [story, setStory] = useState<STARStory>({
    situation: '',
    task: '',
    action: '',
    result: ''
  });
  const [generatedStory, setGeneratedStory] = useState('');
  const [copied, setCopied] = useState(false);

  const generateStory = () => {
    const formatted = `**Situation:** ${story.situation}

**Task:** ${story.task}

**Action:** ${story.action}

**Result:** ${story.result}`;

    setGeneratedStory(formatted);
  };

  const copyToClipboard = () => {
    navigator.clipboard.writeText(generatedStory);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <div className="max-w-5xl mx-auto space-y-6">
      <div className="bg-gradient-to-r from-purple-600 to-pink-600 rounded-xl p-8 text-white">
        <div className="flex items-center gap-3">
          <Briefcase size={40} />
          <div>
            <h1 className="text-4xl font-bold mb-2">HR & Interview Tools</h1>
            <p className="text-purple-100">Prepare winning answers using the STAR method</p>
          </div>
        </div>
      </div>

      <div className="grid lg:grid-cols-2 gap-6">
        <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
          <h2 className="text-2xl font-bold text-white mb-4">STAR Story Builder</h2>
          <p className="text-gray-400 text-sm mb-6">
            Build compelling interview stories using the STAR (Situation, Task, Action, Result) framework.
          </p>

          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">
                Situation
              </label>
              <textarea
                value={story.situation}
                onChange={(e) => setStory({ ...story, situation: e.target.value })}
                placeholder="Describe the context and background..."
                className="w-full bg-gray-900 text-gray-200 p-3 rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none resize-y"
                rows={3}
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">
                Task
              </label>
              <textarea
                value={story.task}
                onChange={(e) => setStory({ ...story, task: e.target.value })}
                placeholder="What was your responsibility or goal?"
                className="w-full bg-gray-900 text-gray-200 p-3 rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none resize-y"
                rows={3}
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">
                Action
              </label>
              <textarea
                value={story.action}
                onChange={(e) => setStory({ ...story, action: e.target.value })}
                placeholder="What specific steps did you take?"
                className="w-full bg-gray-900 text-gray-200 p-3 rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none resize-y"
                rows={3}
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">
                Result
              </label>
              <textarea
                value={story.result}
                onChange={(e) => setStory({ ...story, result: e.target.value })}
                placeholder="What was the outcome? Use metrics if possible."
                className="w-full bg-gray-900 text-gray-200 p-3 rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none resize-y"
                rows={3}
              />
            </div>

            <button
              onClick={generateStory}
              disabled={!story.situation || !story.task || !story.action || !story.result}
              className="w-full bg-purple-600 hover:bg-purple-500 disabled:bg-gray-700 disabled:cursor-not-allowed text-white font-bold py-3 rounded-lg transition-colors"
            >
              Generate STAR Story
            </button>

            {generatedStory && (
              <div className="bg-gray-900 rounded-lg p-4 border border-gray-600">
                <div className="flex items-center justify-between mb-3">
                  <h3 className="font-bold text-white">Your STAR Story</h3>
                  <button
                    onClick={copyToClipboard}
                    className="flex items-center gap-2 text-sm bg-gray-700 hover:bg-gray-600 text-gray-300 px-3 py-1 rounded transition-colors"
                  >
                    {copied ? (
                      <>
                        <CheckCircle size={16} />
                        Copied!
                      </>
                    ) : (
                      <>
                        <Copy size={16} />
                        Copy
                      </>
                    )}
                  </button>
                </div>
                <pre className="text-gray-300 text-sm whitespace-pre-wrap">
                  {generatedStory}
                </pre>
              </div>
            )}
          </div>
        </section>

        <section className="bg-gray-800 rounded-xl p-6 border border-gray-700 space-y-6">
          <div>
            <h2 className="text-2xl font-bold text-white mb-4">Common HR Questions</h2>
            <p className="text-gray-400 text-sm mb-6">
              Prepare answers for these frequently asked behavioral questions.
            </p>
          </div>

          <div className="space-y-4">
            {HR_QUESTIONS.map((item, idx) => (
              <div key={idx} className="bg-gray-900 rounded-lg p-4 border border-gray-700">
                <h3 className="font-bold text-white mb-3 text-sm">{item.question}</h3>
                <ul className="space-y-2">
                  {item.scaffold.map((point, pidx) => (
                    <li key={pidx} className="flex gap-2 items-start text-sm">
                      <span className="text-purple-400 font-bold min-w-[20px]">{pidx + 1}.</span>
                      <span className="text-gray-300">{point}</span>
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>

          <div className="bg-blue-900/30 border border-blue-500 rounded-lg p-4">
            <h4 className="font-bold text-blue-300 mb-2">💡 Interview Tips</h4>
            <ul className="text-sm text-gray-300 space-y-1">
              <li>• Use STAR for every behavioral question</li>
              <li>• Quantify results with metrics when possible</li>
              <li>• Prepare 5-7 versatile stories you can adapt</li>
              <li>• Practice out loud to get timing right (60-90s each)</li>
              <li>• Focus on YOUR actions, not just the team's</li>
            </ul>
          </div>
        </section>
      </div>

      <section className="bg-gray-800 rounded-xl p-6 border border-gray-700">
        <h2 className="text-2xl font-bold text-white mb-4">Scrum & Agile Talking Points</h2>
        <div className="grid md:grid-cols-2 gap-6">
          <div>
            <h3 className="font-bold text-cyan-400 mb-3">Key Ceremonies</h3>
            <ul className="space-y-2 text-sm text-gray-300">
              <li><strong>Daily Stand-up:</strong> 15-min sync on progress, plans, blockers</li>
              <li><strong>Sprint Planning:</strong> Team commits to work for the sprint</li>
              <li><strong>Sprint Review:</strong> Demo completed work to stakeholders</li>
              <li><strong>Retrospective:</strong> Reflect on process improvements</li>
              <li><strong>Backlog Refinement:</strong> Clarify and estimate upcoming work</li>
            </ul>
          </div>
          <div>
            <h3 className="font-bold text-cyan-400 mb-3">How to Talk About Your Role</h3>
            <ul className="space-y-2 text-sm text-gray-300">
              <li>• "I participated in daily stand-ups and sprint planning"</li>
              <li>• "I estimated tasks using story points based on complexity"</li>
              <li>• "I collaborated with the team during code reviews"</li>
              <li>• "I contributed ideas in retrospectives to improve our process"</li>
              <li>• "I worked in 2-week sprints with clear deliverables"</li>
            </ul>
          </div>
        </div>
      </section>
    </div>
  );
}
