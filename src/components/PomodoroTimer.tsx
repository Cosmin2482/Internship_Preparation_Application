import { useState, useEffect, useRef } from 'react';
import { Play, Pause, RotateCcw, Clock } from 'lucide-react';

export function PomodoroTimer() {
  const [minutes, setMinutes] = useState(25);
  const [seconds, setSeconds] = useState(0);
  const [isActive, setIsActive] = useState(false);
  const [isBreak, setIsBreak] = useState(false);
  const intervalRef = useRef<number | null>(null);

  useEffect(() => {
    if (isActive) {
      intervalRef.current = window.setInterval(() => {
        if (seconds === 0) {
          if (minutes === 0) {
            // Timer finished
            setIsActive(false);
            if (isBreak) {
              setMinutes(25);
              setIsBreak(false);
            } else {
              setMinutes(5);
              setIsBreak(true);
            }
            // Play notification sound (optional)
            return;
          }
          setMinutes(minutes - 1);
          setSeconds(59);
        } else {
          setSeconds(seconds - 1);
        }
      }, 1000);
    } else if (intervalRef.current) {
      clearInterval(intervalRef.current);
    }

    return () => {
      if (intervalRef.current) clearInterval(intervalRef.current);
    };
  }, [isActive, minutes, seconds, isBreak]);

  const toggle = () => setIsActive(!isActive);

  const reset = () => {
    setIsActive(false);
    setMinutes(isBreak ? 5 : 25);
    setSeconds(0);
  };

  const formatTime = (m: number, s: number) => {
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  };

  return (
    <div className="bg-gray-800 rounded-xl p-6 border border-gray-700">
      <div className="flex items-center gap-2 mb-4">
        <Clock className="text-cyan-400" size={24} />
        <h3 className="text-xl font-bold text-white">Pomodoro Timer</h3>
      </div>

      <div className={`text-6xl font-mono font-bold text-center mb-6 ${isBreak ? 'text-green-400' : 'text-cyan-400'}`}>
        {formatTime(minutes, seconds)}
      </div>

      <p className="text-center text-sm text-gray-400 mb-6">
        {isBreak ? 'Break Time' : 'Focus Time'}
      </p>

      <div className="flex gap-3 justify-center">
        <button
          onClick={toggle}
          className="bg-cyan-600 hover:bg-cyan-500 text-white p-3 rounded-lg transition-colors"
        >
          {isActive ? <Pause size={24} /> : <Play size={24} />}
        </button>
        <button
          onClick={reset}
          className="bg-gray-700 hover:bg-gray-600 text-white p-3 rounded-lg transition-colors"
        >
          <RotateCcw size={24} />
        </button>
      </div>
    </div>
  );
}
