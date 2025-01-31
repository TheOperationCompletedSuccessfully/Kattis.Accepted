using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace CakeyMcCakeFace2
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 16, 2 ^ 7);
            var entryDetectorTriggered = scanner.NextUInt();
            var exitDetectorTriggered = scanner.NextUInt(true);

            var entryEntries = new List<int>();
            var exitValues = new List<int>();
            var min = 1_000_000_000;
            for (int i = 0; i < entryDetectorTriggered; i++)
            {
                var next = scanner.NextUInt(i == 0);
                entryEntries.Add(next);
                min = Math.Min(min, next);
            }
            for (int i = 0; i < exitDetectorTriggered; i++)
            {
                var nextExitTime = scanner.NextUInt(i == 0);
                if (nextExitTime > min)
                {
                    exitValues.Add(nextExitTime);
                }
            }
            var grouped = Enumerable.Range(0, entryDetectorTriggered * exitValues.Count).Select(x => exitValues[x / entryDetectorTriggered] - entryEntries[x % entryDetectorTriggered]).Where(m => m >= 0).GroupBy(x => x);
            var answer = grouped.MaxBy(x => 1_000_000_000 * x.LongCount() + (1_000_000_000 - x.Key));

            if (answer != null)
            {
                scanner.streamWriter.WriteLine(answer.Key);
            }
            else
            {
                scanner.streamWriter.WriteLine(0);
            }
            scanner.streamWriter.Flush();
        }
    }
}
