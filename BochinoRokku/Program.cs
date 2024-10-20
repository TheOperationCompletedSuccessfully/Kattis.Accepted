using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace BocchinoRokku
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 22, 2 ^ 22))
            {
                var n = scanner.NextUInt();
                var data = new List<int>();

                for (int i = 0; i < n; i++)
                {
                    var next = scanner.NextUInt(i == 0);
                    data.Add(next);
                }

                var result = data.Order().ToArray().Select((value, index) => new { value, index })
                                  .ToDictionary(pair => pair.value, pair => pair.index);

                for (int i = 0; i < data.Count; i++)
                {
                    scanner.streamWriter.Write(i == 0 ? result[data[i]] : $" {result[data[i]]}");
                }
                scanner.streamWriter.WriteLine();
                scanner.streamWriter.Flush();
            }
        }
    }
}