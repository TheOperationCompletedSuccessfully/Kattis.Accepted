using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Zeva;

namespace BasicProgramming1
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 22, 2 ^ 30);
            var n = scanner.NextUInt();
            var t = scanner.NextUInt();

            switch (t)
            {
                case 1:
                    scanner.streamWriter.WriteLine(7);
                    break;
                case 2:
                    var first = scanner.NextUInt(true);
                    var second = scanner.NextUInt();
                    scanner.streamWriter.WriteLine(first == second ? "Equal" : first > second ? "Bigger" : "Smaller");
                    break;
                case 3:
                    var f = scanner.NextUInt(true);
                    var s = scanner.NextUInt();
                    var th = scanner.NextUInt();
                    var result = new List<int> { f, s, th };
                    scanner.streamWriter.WriteLine(result.OrderBy(tt => tt).ToArray()[1]);
                    break;
                case 4:
                    long sum = 0;
                    for (int i = 0; i < n; i++)
                    {
                        var next = scanner.NextUInt(i == 0);
                        sum += next;
                    }
                    scanner.streamWriter.WriteLine(sum);
                    break;
                case 5:
                    long evenSum = 0;
                    var even = new HashSet<int>();
                    var odd = new HashSet<int>();
                    for (int i = 0; i < n; i++)
                    {
                        var next = scanner.NextUInt(i == 0);
                        if (even.Contains(next))
                        {
                            evenSum += next;
                            continue;
                        }
                        if (odd.Contains(next))
                        {
                            continue;
                        }
                        Math.DivRem(next, 2, out int rem);
                        if (rem == 0)
                        {
                            evenSum += next;
                            even.Add(next);
                        }
                        else
                        {
                            odd.Add(next);
                        }
                    }
                    scanner.streamWriter.WriteLine(evenSum);
                    break;
                case 6:
                    var builder = new StringBuilder(n);
                    for (int i = 0; i < n; i++)
                    {
                        var next = scanner.NextUInt(i == 0);
                        builder.Append((char)(97 + (next % 26)));
                    }
                    scanner.streamWriter.WriteLine(builder.ToString());
                    break;
                case 7:
                    var data = new int[n];
                    for (int i = 0; i < n; i++)
                    {
                        data[i] = scanner.NextUInt(i == 0);
                    }
                    var visited = new HashSet<int>
                    {
                        0
                    };
                    var bFound = false;
                    var nextIndex = data[0];
                    while (!bFound)
                    {
                        if (nextIndex >= data.Length)
                        {
                            bFound = true;
                            scanner.streamWriter.WriteLine("Out");
                            continue;
                        }
                        if (nextIndex == data.Length - 1)
                        {
                            bFound = true;
                            scanner.streamWriter.WriteLine("Done");
                            continue;
                        }
                        if (visited.Contains(nextIndex))
                        {
                            bFound = true;
                            scanner.streamWriter.WriteLine("Cyclic");
                            continue;
                        }
                        visited.Add(nextIndex);
                        nextIndex = data[nextIndex];
                    }
                    break;
            }
            scanner.streamWriter.Flush();
        }
    }
}
