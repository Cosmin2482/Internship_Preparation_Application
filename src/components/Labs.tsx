import { useState } from 'react';
import { ThresholdExplorer } from './labs/ThresholdExplorer';
import { KNNPlayground } from './labs/KNNPlayground';
import { SQLPractice } from './labs/SQLPractice';
import { CodeKata } from './labs/CodeKata';
import { Beaker, Grid3x3, Database, Terminal } from 'lucide-react';

export function Labs() {
  const [activeLab, setActiveLab] = useState<string>('threshold');

  const labs = [
    { id: 'threshold', name: 'Threshold & Metrics Explorer', icon: Grid3x3, component: ThresholdExplorer },
    { id: 'knn', name: 'kNN Playground', icon: Grid3x3, component: KNNPlayground },
    { id: 'sql', name: 'SQL Practice', icon: Database, component: SQLPractice },
    { id: 'kata', name: 'Code Kata', icon: Terminal, component: CodeKata },
  ];

  const ActiveComponent = labs.find(lab => lab.id === activeLab)?.component;

  return (
    <div className="max-w-7xl mx-auto space-y-6">
      <div className="bg-gradient-to-r from-cyan-600 to-blue-600 rounded-xl p-8 text-white">
        <div className="flex items-center gap-3">
          <Beaker size={40} />
          <div>
            <h1 className="text-4xl font-bold mb-2">Interactive Labs</h1>
            <p className="text-cyan-100">Hands-on practice to reinforce concepts</p>
          </div>
        </div>
      </div>

      <div className="flex gap-2 flex-wrap">
        {labs.map((lab) => {
          const Icon = lab.icon;
          return (
            <button
              key={lab.id}
              onClick={() => setActiveLab(lab.id)}
              className={`flex items-center gap-2 px-4 py-3 rounded-lg font-medium transition-all ${
                activeLab === lab.id
                  ? 'bg-cyan-600 text-white shadow-lg'
                  : 'bg-gray-800 text-gray-300 hover:bg-gray-700 border border-gray-700'
              }`}
            >
              <Icon size={20} />
              {lab.name}
            </button>
          );
        })}
      </div>

      <div className="bg-gray-800 rounded-xl p-6 border border-gray-700 min-h-[600px]">
        {ActiveComponent && <ActiveComponent />}
      </div>
    </div>
  );
}
