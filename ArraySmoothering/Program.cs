using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace ArraySmoothering
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 22, 2 ^ 6);
            var n = scanner.NextUInt();
            var k = scanner.NextUInt();

            if (n == k)
            {
                scanner.streamWriter.WriteLine("0");
                scanner.streamWriter.Flush();
                return;
            }
            var stats = new Dictionary<int, int>();

            for (int i = 0; i < n; i++)
            {
                var next = scanner.NextUInt(i == 0);
                if (stats.TryGetValue(next, out int statValue))
                {
                    stats[next] = ++statValue;
                }
                else
                {
                    stats.Add(next, 1);
                }
            }

            var resultingStats = stats.OrderByDescending(kvp => kvp.Value).ToArray();

            var prevValue = resultingStats[0];
            if (k == 0)
            {
                scanner.streamWriter.WriteLine(prevValue.Value);
                scanner.streamWriter.Flush();
                return;
            }
            var accumulated = 0;
            var lastIndex = 0;
            for (int i = 1; i < resultingStats.Length && accumulated < k; i++)
            {
                var diff = i * (prevValue.Value - resultingStats[i].Value);
                accumulated += diff;
                prevValue = resultingStats[i];
                lastIndex = i;
            }
            int result;
            if(accumulated < k)
            {
                var amend = (k - accumulated) / resultingStats.Length;
                result = resultingStats[resultingStats.Length - 1].Value - amend;
            }
            else
            {
                var overflow = Math.Max(0, accumulated - k);
                var toAmend = overflow / lastIndex + (overflow % lastIndex > 0 ? 1 : 0);
                result = prevValue.Value + toAmend;
            }

            
            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
        }
    }
}
