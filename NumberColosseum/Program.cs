using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace NumberColosseum
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 23, 2 ^ 23);
            var totalContestants = scanner.NextUInt();
            var contestants = new Stack<int>();

            for (int i = 0; i < totalContestants; i++)
            {
                var next = scanner.NextInt(i == 0);
                if (contestants.Count == 0)
                {
                    contestants.Push(next);
                    continue;
                }
                if (next > 0 && contestants.Peek() > 0)
                {
                    contestants.Push(next);
                    continue;
                }
                if (next < 0 && contestants.Peek() < 0)
                {
                    contestants.Push(next);
                    continue;
                }
                while (contestants.Count > 0 && Math.Abs(next) > Math.Abs(contestants.Peek()))
                {
                    next += contestants.Pop();
                }
                if (contestants.Count > 0)
                {
                    var data = contestants.Pop();
                    data += next;
                    if (data != 0)
                    {
                        contestants.Push(data);
                    }
                }
                else
                {
                    contestants.Push(next);
                }
            }
            if (contestants.Count == 0)
            {
                scanner.streamWriter.WriteLine("Tie!");
            }
            else
            {
                scanner.streamWriter.WriteLine(contestants.Peek() > 0 ? "Positives win!" : "Negatives win!");
                scanner.streamWriter.WriteLine(string.Join(" ", contestants.Reverse()));
            }
            scanner.streamWriter.Flush();
        }
    }
}