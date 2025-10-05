import { AlertTriangle, ExternalLink, X } from 'lucide-react';
import { useState } from 'react';

export function ApiKeyWarning() {
  const [isDismissed, setIsDismissed] = useState(() => {
    return localStorage.getItem('apiKeyWarningDismissed') === 'true';
  });

  const apiKey = import.meta.env.VITE_GEMINI_API_KEY;
  const isConfigured = apiKey && apiKey !== 'YOUR_API_KEY_HERE' && apiKey.startsWith('AIza');

  const handleDismiss = () => {
    setIsDismissed(true);
    localStorage.setItem('apiKeyWarningDismissed', 'true');
  };

  if (isConfigured || isDismissed) {
    return null;
  }

  return (
    <div className="fixed top-4 left-1/2 transform -translate-x-1/2 z-50 max-w-3xl w-full mx-4">
      <div className="bg-gradient-to-r from-orange-600 to-red-600 text-white rounded-xl shadow-2xl border-2 border-orange-400 overflow-hidden animate-slideDown">
        <div className="p-4 flex items-start gap-4">
          <AlertTriangle className="shrink-0 mt-1" size={28} />
          <div className="flex-1">
            <h3 className="text-xl font-bold mb-2">
              ⚠️ Google Gemini API Key Lipsește!
            </h3>
            <p className="text-white/90 mb-3 leading-relaxed">
              Funcționalitățile AI (AI Tutor, Quiz Practice, AI Features) <strong>NU vor funcționa</strong> fără un API key.
              Obține unul GRATUIT în doar 2 minute!
            </p>
            <div className="flex flex-wrap gap-3">
              <a
                href="https://aistudio.google.com/apikey"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 px-4 py-2 bg-white text-orange-600 font-semibold rounded-lg hover:bg-orange-50 transition-colors"
              >
                <ExternalLink size={18} />
                Obține API Key (Gratuit)
              </a>
              <a
                href="/GEMINI_API_KEY_SETUP.md"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 px-4 py-2 bg-orange-700 hover:bg-orange-800 text-white font-semibold rounded-lg transition-colors"
              >
                📖 Ghid Pas cu Pas
              </a>
            </div>
            <div className="mt-3 text-sm bg-white/10 rounded-lg p-2">
              <p className="font-mono">
                📝 După obținere, adaugă în <code className="bg-black/20 px-1 rounded">.env</code>:
              </p>
              <p className="font-mono mt-1 bg-black/20 px-2 py-1 rounded">
                VITE_GEMINI_API_KEY=TauApiKeyAici
              </p>
            </div>
          </div>
          <button
            onClick={handleDismiss}
            className="shrink-0 p-1 hover:bg-white/20 rounded-lg transition-colors"
            title="Închide (poți redeschide din Settings)"
          >
            <X size={20} />
          </button>
        </div>
      </div>
    </div>
  );
}
