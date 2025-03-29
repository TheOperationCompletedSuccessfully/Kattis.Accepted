using System;
using System.Collections.Generic;
using Zeva;

namespace BingItOn
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 22, 2 ^ 17);
            var knownWords = new Dictionary<Tuple<long, long, long, long>, int>();
            var n = scanner.NextUInt();

            int j = 0;
            Span<long> l = stackalloc long[4];
            for (int i = 0; i < n; i++)
            {
                j = 0;
                
                int data = scanner.streamReader.Read();
                while (data < 97 && data >= 0)
                {
                    data = scanner.streamReader.Read();
                }
                if(i>0)
                {
                    l.Clear();
                }
                
                while (data >= 97)
                {
                    l[j / 8] += 27 * l[j / 8] + (data - 96);
                    data = scanner.streamReader.Read();
                    j++;

                    var k = new Tuple<long, long, long, long>(l[0], l[1], l[2], l[3]);
                    if (knownWords.TryGetValue(k, out int value))
                    {
                        knownWords[k] = ++value;
                    }
                    else
                    {
                        knownWords.Add(k, 1);
                    }
                }

                var key = new Tuple<long, long, long, long>(l[0], l[1], l[2], l[3]);

                scanner.streamWriter.WriteLine(knownWords[key] - 1);
            }

            scanner.streamWriter.Flush();

        }
    }
}
