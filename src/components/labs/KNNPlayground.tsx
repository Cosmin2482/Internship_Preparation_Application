import { useState, useRef, useEffect } from 'react';

interface Point {
  x: number;
  y: number;
  class: 'red' | 'blue';
}

export function KNNPlayground() {
  const [points, setPoints] = useState<Point[]>([]);
  const [k, setK] = useState(3);
  const [testPoint, setTestPoint] = useState<{ x: number; y: number } | null>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);

  const handleCanvasClick = (e: React.MouseEvent<HTMLCanvasElement>) => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const rect = canvas.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    if (e.shiftKey) {
      setTestPoint({ x, y });
    } else {
      const newClass = e.altKey ? 'blue' : 'red';
      setPoints([...points, { x, y, class: newClass }]);
    }
  };

  const clearCanvas = () => {
    setPoints([]);
    setTestPoint(null);
  };

  const predictClass = (tx: number, ty: number): 'red' | 'blue' | null => {
    if (points.length === 0) return null;

    const distances = points.map(p => ({
      point: p,
      distance: Math.sqrt((p.x - tx) ** 2 + (p.y - ty) ** 2)
    }));

    distances.sort((a, b) => a.distance - b.distance);
    const nearest = distances.slice(0, Math.min(k, points.length));

    const votes = nearest.reduce((acc, { point }) => {
      acc[point.class] = (acc[point.class] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);

    return votes.red > (votes.blue || 0) ? 'red' : 'blue';
  };

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Draw decision boundary background
    if (points.length > 0) {
      const gridSize = 10;
      for (let x = 0; x < canvas.width; x += gridSize) {
        for (let y = 0; y < canvas.height; y += gridSize) {
          const predicted = predictClass(x + gridSize / 2, y + gridSize / 2);
          if (predicted) {
            ctx.fillStyle = predicted === 'red' ? 'rgba(239, 68, 68, 0.1)' : 'rgba(59, 130, 246, 0.1)';
            ctx.fillRect(x, y, gridSize, gridSize);
          }
        }
      }
    }

    // Draw points
    points.forEach(point => {
      ctx.fillStyle = point.class === 'red' ? '#ef4444' : '#3b82f6';
      ctx.beginPath();
      ctx.arc(point.x, point.y, 8, 0, Math.PI * 2);
      ctx.fill();
      ctx.strokeStyle = '#fff';
      ctx.lineWidth = 2;
      ctx.stroke();
    });

    // Draw test point
    if (testPoint) {
      const predicted = predictClass(testPoint.x, testPoint.y);
      ctx.fillStyle = predicted === 'red' ? '#ef4444' : '#3b82f6';
      ctx.beginPath();
      ctx.arc(testPoint.x, testPoint.y, 12, 0, Math.PI * 2);
      ctx.fill();
      ctx.strokeStyle = '#fbbf24';
      ctx.lineWidth = 3;
      ctx.stroke();

      // Draw lines to k nearest neighbors
      const distances = points.map(p => ({
        point: p,
        distance: Math.sqrt((p.x - testPoint.x) ** 2 + (p.y - testPoint.y) ** 2)
      }));
      distances.sort((a, b) => a.distance - b.distance);
      const nearest = distances.slice(0, Math.min(k, points.length));

      nearest.forEach(({ point }) => {
        ctx.strokeStyle = 'rgba(251, 191, 36, 0.5)';
        ctx.lineWidth = 2;
        ctx.beginPath();
        ctx.moveTo(testPoint.x, testPoint.y);
        ctx.lineTo(point.x, point.y);
        ctx.stroke();
      });
    }
  }, [points, k, testPoint]);

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-2xl font-bold text-white mb-2">kNN Playground</h3>
        <p className="text-gray-400">
          Click to add red points, Alt+Click for blue points, Shift+Click to test a point.
        </p>
      </div>

      <div className="grid md:grid-cols-[1fr_300px] gap-6">
        <div>
          <canvas
            ref={canvasRef}
            width={600}
            height={400}
            onClick={handleCanvasClick}
            className="border-2 border-gray-600 rounded-lg cursor-crosshair bg-gray-900 w-full"
            style={{ maxWidth: '600px', height: 'auto', aspectRatio: '600/400' }}
          />
        </div>

        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">
              k = {k}
            </label>
            <input
              type="range"
              min="1"
              max="15"
              value={k}
              onChange={(e) => setK(parseInt(e.target.value))}
              className="w-full"
            />
            <p className="text-xs text-gray-500 mt-1">
              Number of nearest neighbors to consider
            </p>
          </div>

          <div className="bg-gray-900 rounded-lg p-4 space-y-2">
            <h4 className="font-bold text-white mb-2">Legend</h4>
            <div className="flex items-center gap-2 text-sm">
              <div className="w-4 h-4 rounded-full bg-red-500"></div>
              <span className="text-gray-300">Red class (Click)</span>
            </div>
            <div className="flex items-center gap-2 text-sm">
              <div className="w-4 h-4 rounded-full bg-blue-500"></div>
              <span className="text-gray-300">Blue class (Alt+Click)</span>
            </div>
            <div className="flex items-center gap-2 text-sm">
              <div className="w-4 h-4 rounded-full bg-blue-500 border-2 border-yellow-400"></div>
              <span className="text-gray-300">Test point (Shift+Click)</span>
            </div>
          </div>

          <button
            onClick={clearCanvas}
            className="w-full bg-red-600 hover:bg-red-500 text-white font-bold py-2 rounded-lg transition-colors"
          >
            Clear All
          </button>

          <div className="bg-gray-900 rounded-lg p-4">
            <h4 className="font-bold text-white mb-2">Stats</h4>
            <div className="text-sm space-y-1">
              <div className="flex justify-between">
                <span className="text-gray-400">Total points:</span>
                <span className="text-white">{points.length}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-400">Red points:</span>
                <span className="text-white">
                  {points.filter(p => p.class === 'red').length}
                </span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-400">Blue points:</span>
                <span className="text-white">
                  {points.filter(p => p.class === 'blue').length}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-blue-900/30 border border-blue-500 rounded-lg p-4">
        <h4 className="font-bold text-blue-300 mb-2">💡 How it works</h4>
        <ul className="text-sm text-gray-300 space-y-1">
          <li>• kNN classifies by finding the k closest training points</li>
          <li>• The test point gets the majority class from those k neighbors</li>
          <li>• Small k → more sensitive to noise; Large k → smoother boundaries</li>
          <li>• Distance is calculated using Euclidean distance formula</li>
        </ul>
      </div>
    </div>
  );
}
