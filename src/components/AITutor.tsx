import { useState, useRef, useEffect } from 'react';
import { Term } from '../types';
import { Send, Sparkles, Minimize2 } from 'lucide-react';

interface AITutorProps {
  currentTerm: Term | null;
}

interface Message {
  role: 'user' | 'assistant';
  content: string;
}

const GEMINI_API_KEY = 'AIzaSyCykwCFKnZxkXtVwzI9utzJr0Z4JCGn0TE';
const GEMINI_API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

export function AITutor({ currentTerm }: AITutorProps) {
  const [isMinimized, setIsMinimized] = useState(true);
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  useEffect(() => {
    if (!isMinimized && messages.length === 0 && currentTerm) {
      setMessages([
        {
          role: 'assistant',
          content: `Hi! I'm your AI tutor powered by Gemini. I can help you understand "${currentTerm.term}" in depth. I have access to the full context including ELI5 explanations, formal definitions, interview tips, code examples, and common pitfalls. Ask me anything!`
        }
      ]);
    }
  }, [isMinimized, currentTerm]);

  const buildSystemPrompt = () => {
    if (!currentTerm) return '';

    return `You are an expert technical interviewer and educator helping a student prepare for a software engineering internship interview at Trimble. The student is studying the concept: "${currentTerm.term}".

Here is all the information about this concept:

**ELI5 (Simple Explanation):**
${currentTerm.eli5}

**Formal Definition:**
${currentTerm.formal_definition}

**Interview Answer (How to explain in an interview):**
${currentTerm.interview_answer}

**Common Pitfalls:**
${currentTerm.pitfalls.map((p, i) => `${i + 1}. ${p}`).join('\n')}

**Code Examples:**
C#:
${currentTerm.code_examples.csharp || 'N/A'}

TypeScript:
${currentTerm.code_examples.typescript || 'N/A'}

**Visual Diagram:**
${currentTerm.diagram}

Your role:
- Answer questions about this concept clearly and accurately
- Help the student understand deeply, not just memorize
- Provide practical examples and real-world scenarios
- Explain how this would come up in an interview
- Point out connections to other concepts
- Be encouraging and supportive
- If asked for code, provide clean, well-commented examples
- If the student seems confused, break it down further
- Always relate answers back to interview preparation

Keep responses concise but thorough. Use analogies when helpful. Be conversational and friendly.`;
  };

  const handleSend = async () => {
    if (!input.trim() || !currentTerm || isLoading) return;

    const userMessage: Message = { role: 'user', content: input };
    setMessages(prev => [...prev, userMessage]);
    setInput('');
    setIsLoading(true);

    try {
      const systemPrompt = buildSystemPrompt();
      const conversationContext = messages
        .map(m => `${m.role === 'user' ? 'Student' : 'Tutor'}: ${m.content}`)
        .join('\n\n');

      const fullPrompt = `${systemPrompt}

Previous conversation:
${conversationContext}

Student's question: ${input.trim()}

Provide a helpful, clear response:`;

      const response = await fetch(`${GEMINI_API_URL}?key=${GEMINI_API_KEY}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          contents: [{
            parts: [{
              text: fullPrompt
            }]
          }]
        })
      });

      if (!response.ok) {
        throw new Error('Failed to get response from Gemini');
      }

      const data = await response.json();
      const aiResponse = data.candidates[0]?.content?.parts[0]?.text || 'Sorry, I could not generate a response.';

      const assistantMessage: Message = { role: 'assistant', content: aiResponse };
      setMessages(prev => [...prev, assistantMessage]);
    } catch (error) {
      console.error('Error calling Gemini API:', error);
      const errorMessage: Message = {
        role: 'assistant',
        content: 'Sorry, I encountered an error. Please try again.'
      };
      setMessages(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  if (isMinimized) {
    return (
      <button
        onClick={() => setIsMinimized(false)}
        className="fixed bottom-4 left-4 bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 text-white p-4 rounded-full shadow-lg transition-all transform hover:scale-105 z-40"
        title="Open AI Tutor"
      >
        <Sparkles size={24} />
      </button>
    );
  }

  return (
    <div className="fixed bottom-4 left-4 w-[420px] h-[600px] bg-gray-900 border border-gray-700 rounded-xl shadow-2xl flex flex-col z-40">
      <div className="flex items-center justify-between p-4 border-b border-gray-700 bg-gradient-to-r from-cyan-600 to-blue-600 rounded-t-xl">
        <div className="flex items-center gap-2 text-white">
          <Sparkles size={20} />
          <h2 className="text-lg font-bold">AI Tutor</h2>
          <span className="text-xs bg-white/20 px-2 py-0.5 rounded">Gemini</span>
        </div>
        <button
          onClick={() => setIsMinimized(true)}
          className="text-white hover:bg-white/20 p-1.5 rounded-lg transition-colors"
          title="Minimize"
        >
          <Minimize2 size={18} />
        </button>
      </div>

      {currentTerm && (
        <div className="px-4 py-2 border-b border-gray-700 bg-gray-800">
          <p className="text-xs text-gray-400">Studying:</p>
          <p className="text-sm font-semibold text-white">{currentTerm.term}</p>
        </div>
      )}

      <div className="flex-1 overflow-y-auto p-4 space-y-3">
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
              <p className="text-sm whitespace-pre-wrap break-words">{msg.content}</p>
            </div>
          </div>
        ))}
        {isLoading && (
          <div className="flex justify-start">
            <div className="bg-gray-800 text-gray-400 border border-gray-700 rounded-lg p-3">
              <div className="flex gap-1">
                <div className="w-2 h-2 bg-cyan-500 rounded-full animate-bounce" style={{ animationDelay: '0ms' }}></div>
                <div className="w-2 h-2 bg-cyan-500 rounded-full animate-bounce" style={{ animationDelay: '150ms' }}></div>
                <div className="w-2 h-2 bg-cyan-500 rounded-full animate-bounce" style={{ animationDelay: '300ms' }}></div>
              </div>
            </div>
          </div>
        )}
        <div ref={messagesEndRef} />
      </div>

      <div className="p-3 border-t border-gray-700 bg-gray-800 rounded-b-xl">
        <div className="flex gap-2">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && !e.shiftKey && handleSend()}
            placeholder="Ask anything about this topic..."
            className="flex-1 bg-gray-900 text-gray-200 px-3 py-2 text-sm rounded-lg border border-gray-600 focus:border-cyan-500 focus:outline-none"
            disabled={isLoading}
          />
          <button
            onClick={handleSend}
            disabled={!input.trim() || isLoading}
            className="bg-cyan-600 hover:bg-cyan-500 disabled:bg-gray-700 disabled:cursor-not-allowed text-white p-2 rounded-lg transition-colors"
          >
            <Send size={18} />
          </button>
        </div>
        <p className="text-xs text-gray-500 mt-1.5">
          Powered by Google Gemini AI
        </p>
      </div>
    </div>
  );
}
