import { useState, useEffect } from 'react';
import { Term } from '../types';
import { X, Send, Sparkles } from 'lucide-react';

interface AITutorProps {
  isOpen: boolean;
  onClose: () => void;
  currentTerm: Term | null;
}

interface Message {
  role: 'user' | 'assistant';
  content: string;
}

export function AITutor({ isOpen, onClose, currentTerm }: AITutorProps) {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');

  useEffect(() => {
    if (isOpen && currentTerm) {
      setMessages([
        {
          role: 'assistant',
          content: `Hi! I'm your AI tutor. I can help explain "${currentTerm.term}" in different ways. Try asking:\n• "Explain this like I'm 5"\n• "Give me the formal definition"\n• "How should I answer this in an interview?"\n• "Show me the diagram"\n• "What are common mistakes?"`
        }
      ]);
    }
  }, [isOpen, currentTerm]);

  const handleSend = () => {
    if (!input.trim() || !currentTerm) return;

    const userMessage: Message = { role: 'user', content: input };
    setMessages(prev => [...prev, userMessage]);

    // Generate response based on term data
    let response = '';
    const lowerInput = input.toLowerCase();

    if (lowerInput.includes('eli5') || lowerInput.includes('simple') || lowerInput.includes('like i\'m 5')) {
      response = `**ELI5 Explanation:**\n\n${currentTerm.eli5}`;
    } else if (lowerInput.includes('formal') || lowerInput.includes('definition') || lowerInput.includes('technical')) {
      response = `**Formal Definition:**\n\n${currentTerm.formal_definition}`;
    } else if (lowerInput.includes('interview') || lowerInput.includes('answer')) {
      response = `**Interview Answer:**\n\n${currentTerm.interview_answer}`;
    } else if (lowerInput.includes('diagram') || lowerInput.includes('visual') || lowerInput.includes('picture')) {
      response = `**Visual Diagram:**\n\n\`\`\`\n${currentTerm.diagram}\n\`\`\``;
    } else if (lowerInput.includes('pitfall') || lowerInput.includes('mistake') || lowerInput.includes('avoid') || lowerInput.includes('common')) {
      response = `**Common Pitfalls:**\n\n${currentTerm.pitfalls.map((p, i) => `${i + 1}. ${p}`).join('\n\n')}`;
    } else if (lowerInput.includes('code') || lowerInput.includes('example')) {
      const examples = [];
      if (currentTerm.code_examples.csharp) {
        examples.push(`**C# Example:**\n\n\`\`\`csharp\n${currentTerm.code_examples.csharp}\n\`\`\``);
      }
      if (currentTerm.code_examples.typescript) {
        examples.push(`**TypeScript Example:**\n\n\`\`\`typescript\n${currentTerm.code_examples.typescript}\n\`\`\``);
      }
      response = examples.join('\n\n');
    } else {
      response = `I can help you with "${currentTerm.term}"! Try asking for:\n• An ELI5 explanation\n• The formal definition\n• Interview tips\n• Code examples\n• Common pitfalls\n• A diagram`;
    }

    const assistantMessage: Message = { role: 'assistant', content: response };
    setMessages(prev => [...prev, assistantMessage]);
    setInput('');
  };

  if (!isOpen) return null;

  return (
    <div className="fixed top-0 right-0 h-full w-full lg:w-[500px] bg-gray-900 border-l border-gray-700 z-50 flex flex-col shadow-2xl">
      <div className="flex items-center justify-between p-4 border-b border-gray-700 bg-gradient-to-r from-cyan-600 to-blue-600">
        <div className="flex items-center gap-2 text-white">
          <Sparkles size={24} />
          <h2 className="text-xl font-bold">AI Tutor</h2>
        </div>
        <button
          onClick={onClose}
          className="text-white hover:bg-white/20 p-2 rounded-lg transition-colors"
        >
          <X size={24} />
        </button>
      </div>

      {currentTerm && (
        <div className="p-3 border-b border-gray-700 bg-gray-800">
          <p className="text-sm text-gray-400">Current topic:</p>
          <p className="font-bold text-white">{currentTerm.term}</p>
        </div>
      )}

      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {messages.map((msg, idx) => (
          <div
            key={idx}
            className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}
          >
            <div
              className={`max-w-[85%] rounded-lg p-3 ${
                msg.role === 'user'
                  ? 'bg-cyan-600 text-white'
                  : 'bg-gray-800 text-gray-200 border border-gray-700'
              }`}
            >
              <p className="text-sm whitespace-pre-wrap">{msg.content}</p>
            </div>
          </div>
        ))}
      </div>

      <div className="p-4 border-t border-gray-700 bg-gray-800">
        <div className="flex gap-2">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && handleSend()}
            placeholder="Ask me anything about this topic..."
            className="flex-1 bg-gray-900 text-gray-200 px-4 py-2 rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none"
          />
          <button
            onClick={handleSend}
            disabled={!input.trim()}
            className="bg-cyan-600 hover:bg-cyan-500 disabled:bg-gray-700 disabled:cursor-not-allowed text-white p-2 rounded-lg transition-colors"
          >
            <Send size={20} />
          </button>
        </div>
        <p className="text-xs text-gray-500 mt-2">
          Press T to toggle tutor • Powered by local term data
        </p>
      </div>
    </div>
  );
}
