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

      {/* Cheat Sheet - Keep This Open During Interview */}
      <div className="bg-gradient-to-br from-orange-600 to-red-600 text-white rounded-xl p-6 border-4 border-yellow-400">
        <h2 className="text-2xl font-bold mb-4 flex items-center gap-2">
          <Star className="w-6 h-6" />
          CHEAT SHEET - Your Quick Reference
        </h2>

        <div className="space-y-6">
          {/* About This App */}
          <div className="bg-white/10 rounded-lg p-4">
            <h3 className="font-bold text-lg mb-2">Built This Study App (MENTION THIS!)</h3>
            <p className="text-sm mb-2">
              "I built a comprehensive interview prep platform to prepare for this internship using:"
            </p>
            <ul className="text-sm space-y-1 ml-4">
              <li>• React + TypeScript + Tailwind CSS (frontend)</li>
              <li>• Supabase (PostgreSQL database with 168 terms, 626 quiz questions)</li>
              <li>• Gemini AI API integration for adaptive learning</li>
              <li>• 11 interactive coding labs (FizzBuzz, Two Sum, Binary Search, etc.)</li>
              <li>• Priority-based learning system (99% priority terms first)</li>
            </ul>
            <p className="text-sm mt-2 italic">
              This shows self-motivation, full-stack skills, and genuine interest in the role!
            </p>
          </div>

          {/* When You Get Lost or Anxious */}
          <div className="bg-white/10 rounded-lg p-4">
            <h3 className="font-bold text-lg mb-2">When Your Mind Blocks or You Get Lost:</h3>
            <div className="space-y-3 text-sm">
              <div>
                <p className="font-semibold">1. Buy Time (Use These Phrases):</p>
                <ul className="ml-4 space-y-1">
                  <li>• "That's an interesting question. Let me think about this for a moment..."</li>
                  <li>• "Can I clarify the requirements before I answer?"</li>
                  <li>• "Let me break this down step by step..."</li>
                  <li>• "I want to make sure I understand correctly - you're asking about [restate question]?"</li>
                </ul>
              </div>

              <div>
                <p className="font-semibold">2. Reset Your Thinking:</p>
                <ul className="ml-4 space-y-1">
                  <li>• Take a deep breath (literally - 3 seconds)</li>
                  <li>• Ask for the question to be repeated: "Could you rephrase that?"</li>
                  <li>• Start with what you DO know: "I know that [basic concept]..."</li>
                  <li>• Think out loud: "My thought process is..."</li>
                </ul>
              </div>

              <div>
                <p className="font-semibold">3. When You Don't Know Something:</p>
                <ul className="ml-4 space-y-1">
                  <li>• BE HONEST: "I haven't worked with [X] yet, but here's my understanding..."</li>
                  <li>• Show learning ability: "I would start by checking the official documentation..."</li>
                  <li>• Connect to what you know: "It's similar to [related concept], right?"</li>
                  <li>• Express enthusiasm: "That sounds fascinating. I'd love to learn it during the internship."</li>
                </ul>
              </div>

              <div>
                <p className="font-semibold">4. Anxiety Management Techniques:</p>
                <ul className="ml-4 space-y-1">
                  <li>• Remember: They WANT you to succeed. They're not trying to trick you.</li>
                  <li>• It's an internship, not a senior role. They expect gaps in knowledge.</li>
                  <li>• Pause and breathe. Silence is okay - it shows you're thinking.</li>
                  <li>• Drink water to reset (keep a glass nearby)</li>
                  <li>• If stuck on coding: Start with pseudocode or describe the approach verbally</li>
                </ul>
              </div>
            </div>
          </div>

          {/* Key Technical Points to Mention */}
          <div className="bg-white/10 rounded-lg p-4">
            <h3 className="font-bold text-lg mb-2">Key Technical Points (High Impact):</h3>
            <div className="grid md:grid-cols-2 gap-3 text-sm">
              <div>
                <p className="font-semibold">OOP:</p>
                <p>"I choose override for polymorphism; new is just hiding."</p>
              </div>
              <div>
                <p className="font-semibold">HTTP:</p>
                <p>"PUT is idempotent; POST creates new resources each time."</p>
              </div>
              <div>
                <p className="font-semibold">Status Codes:</p>
                <p>"I use 422 for validation, 409 for conflicts, not 400 for everything."</p>
              </div>
              <div>
                <p className="font-semibold">EF Core:</p>
                <p>"I use AsNoTracking for read-only queries to improve performance."</p>
              </div>
              <div>
                <p className="font-semibold">Testing:</p>
                <p>"I write tests using AAA pattern and mock dependencies through interfaces."</p>
              </div>
              <div>
                <p className="font-semibold">SQL:</p>
                <p>"INNER JOIN for intersection; LEFT JOIN when I need all left rows even without matches."</p>
              </div>
            </div>
          </div>

          {/* Confidence Boosters */}
          <div className="bg-white/10 rounded-lg p-4">
            <h3 className="font-bold text-lg mb-2">Remember These (Confidence Boosters):</h3>
            <ul className="text-sm space-y-2">
              <li>✅ You have 6+ months experience at Stefanini and Valahia Apex</li>
              <li>✅ You've built multiple full-stack projects (Movie DB, School Management)</li>
              <li>✅ You already know Scrum from Stefanini daily standups</li>
              <li>✅ You're studying AI/ML at Georgia Tech - shows advanced learning</li>
              <li>✅ You built THIS study app - proof of initiative and full-stack skills</li>
              <li>✅ You know Angular, .NET, React, SQL, C#, TypeScript - exactly what they need</li>
            </ul>
          </div>

          {/* Emergency Responses */}
          <div className="bg-white/10 rounded-lg p-4">
            <h3 className="font-bold text-lg mb-2">Emergency Phrases When Completely Stuck:</h3>
            <div className="space-y-2 text-sm">
              <p><strong>Technical Question:</strong> "I'm not familiar with that specific implementation, but my approach would be to check the official documentation first, then try a small proof-of-concept to understand it better."</p>
              <p><strong>Coding Problem:</strong> "Let me start by clarifying the requirements and edge cases. Then I'll describe my approach before coding."</p>
              <p><strong>System Design:</strong> "I'd break this into components: frontend (React/Angular), backend API (.NET), database (SQL), and then discuss how they communicate via REST."</p>
              <p><strong>Behavioral:</strong> "At Stefanini, we had a similar situation where... [use STAR method: Situation, Task, Action, Result]"</p>
            </div>
          </div>
        </div>
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

      {/* Trimble-Specific Topics */}
      <div className="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl p-6">
        <div className="flex items-center gap-2 mb-4">
          <Star className="w-6 h-6 text-cyan-500" />
          <h2 className="text-2xl font-bold">Trimble-Specific Topics</h2>
        </div>
        <div className="space-y-6">
          <div>
            <h3 className="font-semibold text-lg mb-2 text-cyan-600 dark:text-cyan-400">1. Scrum/Agile Methodology (99% Priority)</h3>
            <p className="text-gray-700 dark:text-gray-300 mb-2">
              <strong>What it is:</strong> Agile framework with 2-week sprints, daily standups, sprint planning, reviews, and retrospectives.
            </p>
            <div className="bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 p-3 rounded mb-2">
              <p className="text-sm text-gray-700 dark:text-gray-300">
                <strong>How to Answer:</strong> "Scrum is an Agile framework using 2-week sprints. Teams plan work using user stories (format: As a [role], I want [goal] so that [benefit]). We have daily 15-minute standups to sync on progress and blockers. Sprint reviews demo working features to stakeholders. Retrospectives help us improve our process. I'm excited to learn this in a real team environment at Trimble."
              </p>
            </div>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2 text-cyan-600 dark:text-cyan-400">2. CI/CD & Azure DevOps (99% Priority)</h3>
            <p className="text-gray-700 dark:text-gray-300 mb-2">
              <strong>What it is:</strong> Automated build, test, and deployment on every commit using Azure DevOps Pipelines.
            </p>
            <div className="bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 p-3 rounded mb-2">
              <p className="text-sm text-gray-700 dark:text-gray-300">
                <strong>How to Answer:</strong> "CI/CD automates testing and deployment. When I push code to Git, a pipeline automatically builds the project, runs tests, and if everything passes, deploys to Azure App Service. This catches bugs early and allows safe, frequent releases. I'm familiar with the concept and eager to learn Azure DevOps pipelines hands-on."
              </p>
            </div>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2 text-cyan-600 dark:text-cyan-400">3. Azure Cloud Services (99% Priority)</h3>
            <p className="text-gray-700 dark:text-gray-300 mb-2">
              <strong>Trimble uses:</strong> Azure App Service (hosting), Azure SQL Database, Azure Blob Storage (3D models, files), Azure Active Directory.
            </p>
            <div className="bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 p-3 rounded mb-2">
              <p className="text-sm text-gray-700 dark:text-gray-300">
                <strong>How to Answer:</strong> "Cloud computing means renting resources from providers like Microsoft Azure. For a web app, I would use Azure App Service to host it, Azure SQL for the database, and Azure Blob Storage for files like 3D models. Benefits include automatic scaling, 99.9% uptime, and pay-per-use pricing. I'm ready to learn Azure services in depth during the internship."
              </p>
            </div>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2 text-cyan-600 dark:text-cyan-400">4. Git Workflows (Important)</h3>
            <p className="text-gray-700 dark:text-gray-300 mb-2">
              <strong>What Trimble expects:</strong> Feature branching, Pull Requests with code review, clear commit messages, merge conflict resolution.
            </p>
            <div className="bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 p-3 rounded mb-2">
              <p className="text-sm text-gray-700 dark:text-gray-300">
                <strong>How to Answer:</strong> "In a team, I create a feature branch for my work, commit changes with clear messages like 'feat: add 3D viewer component', then push and open a Pull Request. Team members review my code, suggest improvements, and once approved and CI tests pass, we merge to main. This ensures code quality and prevents conflicts."
              </p>
            </div>
          </div>

          <div>
            <h3 className="font-semibold text-lg mb-2 text-cyan-600 dark:text-cyan-400">5. BIM & 3D Visualization (Trimble-Specific)</h3>
            <p className="text-gray-700 dark:text-gray-300 mb-2">
              <strong>What BIM is:</strong> Building Information Modeling - 3D models of buildings/construction (file formats: .ifc, .dwg, .rvt).
            </p>
            <div className="bg-cyan-50 dark:bg-cyan-950 border-l-4 border-cyan-500 p-3 rounded mb-2">
              <p className="text-sm text-gray-700 dark:text-gray-300">
                <strong>How to Answer:</strong> "I know BIM stands for Building Information Modeling, used in construction to create 3D models of buildings. I'm excited to learn how software like Trimble's tools help engineers and architects visualize and collaborate on construction projects. The combination of software engineering and construction technology is fascinating."
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* CV-Based Interview Questions */}
      <div className="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl p-6">
        <div className="flex items-center gap-2 mb-4">
          <BookOpen className="w-6 h-6 text-orange-500" />
          <h2 className="text-2xl font-bold">Your CV-Based Questions & Answers</h2>
        </div>
        <p className="text-gray-600 dark:text-gray-400 mb-4">
          Based on your experience at Valahia Apex and Stefanini, here are questions you might get:
        </p>
        <div className="space-y-4">
          <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <p className="font-semibold text-gray-900 dark:text-white mb-2">
              Q: "Tell me about your experience at Stefanini. What did you work on?"
            </p>
            <p className="text-gray-700 dark:text-gray-300 text-sm">
              <strong>A:</strong> "At Stefanini, I worked as a Software Developer building ServiceNow workflows and UI components. I automated incident handling with inbound email flows, which reduced ticket resolution time. I participated daily in Agile ceremonies - scrum, retrospectives, and sprint planning - which taught me the value of team communication and iterative development. I delivered high-priority features like auto-refresh dashboards and user management. One achievement I'm proud of is identifying and fixing bugs before deployment, saving the team time and resources."
            </p>
          </div>

          <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <p className="font-semibold text-gray-900 dark:text-white mb-2">
              Q: "You mention Ansible and automation at Valahia Apex. Can you explain what you did?"
            </p>
            <p className="text-gray-700 dark:text-gray-300 text-sm">
              <strong>A:</strong> "At Valahia Apex, I automated IT workflows using Ansible playbooks, which reduced manual work significantly. I also optimized RouterOS routing and firewall rules, improving network performance by 15%. I designed Python scripts for automation and monitoring tasks, boosting team efficiency. Additionally, I gained hands-on experience in server room design and infrastructure planning, which gave me insight into how software solutions integrate with physical hardware."
            </p>
          </div>

          <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <p className="font-semibold text-gray-900 dark:text-white mb-2">
              Q: "Tell me about your Movie Database project. What technologies did you use?"
            </p>
            <p className="text-gray-700 dark:text-gray-300 text-sm">
              <strong>A:</strong> "I built a full-stack Movie Database using Angular for the frontend and .NET for the backend. The platform manages 1,000+ movie records with a dynamic search system and review functionality. I implemented RESTful APIs for CRUD operations, used Entity Framework Core for database access, and designed a responsive UI with Angular. This project taught me end-to-end application development, from database design to user interface, and strengthened my understanding of the MVC architecture pattern."
            </p>
          </div>

          <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <p className="font-semibold text-gray-900 dark:text-white mb-2">
              Q: "I see you're completing Georgia Tech's Introduction to Analytics Modeling. What are you learning?"
            </p>
            <p className="text-gray-700 dark:text-gray-300 text-sm">
              <strong>A:</strong> "I'm currently completing a 16-week course on analytics modeling from Georgia Tech, focusing on AI, machine learning, and scalable architectures. I'm learning about classification models, LLMs, and how AI agents collaborate through agentic workflows. I've also been self-studying and building hands-on projects with AI tools. This aligns with Trimble's focus on embracing AI for productivity - I'm comfortable using AI-assisted coding tools like Copilot, Cursor, and ChatGPT to accelerate development while ensuring I understand the underlying code."
            </p>
          </div>

          <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <p className="font-semibold text-gray-900 dark:text-white mb-2">
              Q: "You have experience with multiple frameworks - Angular, React, WPF. Which do you prefer and why?"
            </p>
            <p className="text-gray-700 dark:text-gray-300 text-sm">
              <strong>A:</strong> "Each framework has strengths for different use cases. I prefer Angular for large-scale enterprise applications because of its robust structure, TypeScript integration, and dependency injection. React is excellent for rapid prototyping and when you need fine-grained control over rendering. WPF is powerful for Windows desktop applications with rich UI requirements using MVVM pattern. I'm flexible and can adapt to whatever framework the team uses at Trimble - what matters most is writing clean, maintainable code that follows the framework's best practices."
            </p>
          </div>

          <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <p className="font-semibold text-gray-900 dark:text-white mb-2">
              Q: "What's your experience with databases? I see you've worked with SQL Server, PostgreSQL, MongoDB."
            </p>
            <p className="text-gray-700 dark:text-gray-300 text-sm">
              <strong>A:</strong> "I have strong database experience across both SQL and NoSQL. For my Movie Database and School Management projects, I used Microsoft SQL Server with Entity Framework Core, designing normalized schemas with proper foreign keys and indexes. I've worked with complex JOIN queries, stored procedures, and query optimization. I've also used PostgreSQL in academic projects and MongoDB for my Dinamo București fan website where document-based storage made sense for flexible content. I understand when to use relational vs document databases based on data structure and query patterns."
            </p>
          </div>

          <div className="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
            <p className="font-semibold text-gray-900 dark:text-white mb-2">
              Q: "Why do you want to intern at Trimble? What interests you about this position?"
            </p>
            <p className="text-gray-700 dark:text-gray-300 text-sm">
              <strong>A:</strong> "I'm excited about Trimble because you're solving real-world problems in construction and engineering through software. The combination of cutting-edge technology like 3D visualization, BIM, and cloud computing with tangible impact on building better infrastructure is fascinating. The rotational program structure is perfect for me - working with Angular, .NET, and learning from senior engineers aligns with my goal of becoming a strong full-stack developer. I'm also drawn to Trimble's embrace of AI and modern development practices. As a self-motivated learner who's already built multiple full-stack projects, I'm ready to contribute and grow within a collaborative team environment."
            </p>
          </div>
        </div>
      </div>

      {/* What You've Already Mastered */}
      <div className="bg-gradient-to-r from-green-600 to-teal-600 text-white rounded-xl p-6">
        <h2 className="text-2xl font-bold mb-4">What You've Already Mastered</h2>
        <p className="mb-4">Your study app already covers 90% of what Trimble needs:</p>
        <div className="grid md:grid-cols-2 gap-3 text-sm">
          <div>✅ C# & C++ fundamentals</div>
          <div>✅ SQL (joins, queries, database design)</div>
          <div>✅ TypeScript</div>
          <div>✅ React & Angular</div>
          <div>✅ OOP (Encapsulation, Inheritance, Polymorphism, Abstraction)</div>
          <div>✅ Testing (Unit tests, AAA pattern, Mocks)</div>
          <div>✅ .NET Core (DbContext, EF Core, Middleware)</div>
          <div>✅ HTTP/REST APIs</div>
          <div>✅ Architecture patterns (MVC, Repository, Service layers)</div>
          <div>✅ Algorithms & Data Structures</div>
          <div>✅ Git basics</div>
          <div>✅ 11 coding labs for practice</div>
        </div>
        <p className="mt-4 font-semibold">The missing 10% (Scrum, Azure, CI/CD) are things they EXPECT to teach you!</p>
      </div>

      {/* Day-Before Checklist */}
      <div className="bg-gradient-to-r from-orange-600 to-red-600 text-white rounded-xl p-6">
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
