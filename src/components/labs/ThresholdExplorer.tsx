import { useState, useMemo } from 'react';

export function ThresholdExplorer() {
  const [threshold, setThreshold] = useState(0.5);
  const [posMean, setPosMean] = useState(0.7);
  const [negMean, setNegMean] = useState(0.3);
  const [std, setStd] = useState(0.15);
  const [positiveRate, setPositiveRate] = useState(0.3);

  const metrics = useMemo(() => {
    const totalSamples = 1000;
    const actualPositives = Math.round(totalSamples * positiveRate);
    const actualNegatives = totalSamples - actualPositives;

    const normalCDF = (x: number, mean: number, std: number) => {
      return 0.5 * (1 + erf((x - mean) / (std * Math.sqrt(2))));
    };

    const erf = (x: number) => {
      const sign = x >= 0 ? 1 : -1;
      x = Math.abs(x);
      const a1 = 0.254829592;
      const a2 = -0.284496736;
      const a3 = 1.421413741;
      const a4 = -1.453152027;
      const a5 = 1.061405429;
      const p = 0.3275911;
      const t = 1 / (1 + p * x);
      const y = 1 - ((((a5 * t + a4) * t + a3) * t + a2) * t + a1) * t * Math.exp(-x * x);
      return sign * y;
    };

    const probPosAboveThreshold = 1 - normalCDF(threshold, posMean, std);
    const probNegAboveThreshold = 1 - normalCDF(threshold, negMean, std);

    const TP = Math.round(actualPositives * probPosAboveThreshold);
    const FN = actualPositives - TP;
    const FP = Math.round(actualNegatives * probNegAboveThreshold);
    const TN = actualNegatives - FP;

    const precision = TP + FP > 0 ? TP / (TP + FP) : 0;
    const recall = TP + FN > 0 ? TP / (TP + FN) : 0;
    const f1 = precision + recall > 0 ? 2 * (precision * recall) / (precision + recall) : 0;
    const accuracy = (TP + TN) / totalSamples;
    const tpr = recall;
    const fpr = FP / (FP + TN);

    return { TP, FN, FP, TN, precision, recall, f1, accuracy, tpr, fpr };
  }, [threshold, posMean, negMean, std, positiveRate]);

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-2xl font-bold text-white mb-2">Threshold & Metrics Explorer</h3>
        <p className="text-gray-400">
          Adjust the threshold and distribution parameters to see how classification metrics change.
          This helps understand the precision-recall trade-off.
        </p>
      </div>

      <div className="grid md:grid-cols-2 gap-6">
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Threshold: {threshold.toFixed(2)}
            </label>
            <input
              type="range"
              min="0"
              max="1"
              step="0.01"
              value={threshold}
              onChange={(e) => setThreshold(parseFloat(e.target.value))}
              className="w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Positive Class Mean: {posMean.toFixed(2)}
            </label>
            <input
              type="range"
              min="0"
              max="1"
              step="0.01"
              value={posMean}
              onChange={(e) => setPosMean(parseFloat(e.target.value))}
              className="w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Negative Class Mean: {negMean.toFixed(2)}
            </label>
            <input
              type="range"
              min="0"
              max="1"
              step="0.01"
              value={negMean}
              onChange={(e) => setNegMean(parseFloat(e.target.value))}
              className="w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Standard Deviation: {std.toFixed(2)}
            </label>
            <input
              type="range"
              min="0.05"
              max="0.3"
              step="0.01"
              value={std}
              onChange={(e) => setStd(parseFloat(e.target.value))}
              className="w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              Positive Class Rate: {(positiveRate * 100).toFixed(0)}%
            </label>
            <input
              type="range"
              min="0.1"
              max="0.9"
              step="0.05"
              value={positiveRate}
              onChange={(e) => setPositiveRate(parseFloat(e.target.value))}
              className="w-full"
            />
          </div>
        </div>

        <div className="space-y-4">
          <div className="bg-gray-900 rounded-lg p-4">
            <h4 className="font-bold text-white mb-3">Confusion Matrix</h4>
            <div className="grid grid-cols-2 gap-2 text-center">
              <div className="bg-green-900/30 border border-green-500 p-4 rounded">
                <div className="text-xs text-green-400 mb-1">True Positive</div>
                <div className="text-2xl font-bold text-white">{metrics.TP}</div>
              </div>
              <div className="bg-red-900/30 border border-red-500 p-4 rounded">
                <div className="text-xs text-red-400 mb-1">False Positive</div>
                <div className="text-2xl font-bold text-white">{metrics.FP}</div>
              </div>
              <div className="bg-red-900/30 border border-red-500 p-4 rounded">
                <div className="text-xs text-red-400 mb-1">False Negative</div>
                <div className="text-2xl font-bold text-white">{metrics.FN}</div>
              </div>
              <div className="bg-green-900/30 border border-green-500 p-4 rounded">
                <div className="text-xs text-green-400 mb-1">True Negative</div>
                <div className="text-2xl font-bold text-white">{metrics.TN}</div>
              </div>
            </div>
          </div>

          <div className="bg-gray-900 rounded-lg p-4 space-y-2">
            <h4 className="font-bold text-white mb-3">Metrics</h4>
            <div className="flex justify-between text-sm">
              <span className="text-gray-400">Precision:</span>
              <span className="text-white font-mono">{metrics.precision.toFixed(3)}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-400">Recall (TPR):</span>
              <span className="text-white font-mono">{metrics.recall.toFixed(3)}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-400">F1 Score:</span>
              <span className="text-white font-mono">{metrics.f1.toFixed(3)}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-400">Accuracy:</span>
              <span className="text-white font-mono">{metrics.accuracy.toFixed(3)}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-400">FPR:</span>
              <span className="text-white font-mono">{metrics.fpr.toFixed(3)}</span>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-blue-900/30 border border-blue-500 rounded-lg p-4">
        <h4 className="font-bold text-blue-300 mb-2">💡 Key Insights</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• Lower threshold → More predictions as positive → Higher recall, lower precision</li>
          <li>• Higher threshold → Fewer predictions as positive → Lower recall, higher precision</li>
          <li>• F1 score balances precision and recall (harmonic mean)</li>
          <li>• In imbalanced datasets, accuracy can be misleading</li>
        </ul>
      </div>
    </div>
  );
}
