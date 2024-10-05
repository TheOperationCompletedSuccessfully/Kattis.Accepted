using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace BiasedStandings
{
    class Program
    {
        static void Main(string[] args)
        {

            using (var scanner = new ZevaScanner(2 ^ 21, 2 ^ 8))
            {
                var caseNumber = scanner.NextUInt();


                for (int c = 0; c < caseNumber; c++)
                {
                    var n = scanner.NextUInt(true);
                    long result = 0;
                    var data = new List<int>();
                    for (int i = 0; i < n; i++)
                    {
                        scanner.NextUInt(true);
                        var newItem = scanner.NextUInt();
                        data.Add(newItem);
                    }
                    var orderedData = data.Order().ToArray();
                    for (int i = 0; i < n; i++)
                    {
                        result += Math.Abs(orderedData[i] - 1 - i);
                    }
                    scanner.streamWriter.WriteLine(result);
                }
                scanner.streamWriter.Flush();
            }
        }
    }
}