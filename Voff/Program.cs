using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Voff
{
    class Program
    {
        static void Main(string[] args)
        {

            using var scanner = new ZevaScanner(2 ^ 21, 2 ^ 7);
            var n = scanner.NextUInt();
            var k = scanner.NextUInt();
            var dogs = new Queue<int>();
            dogs.Enqueue(1);
            var result = 1;
            for (int i = 0; i < n; i++)
            {
                var nextBark = scanner.NextUInt(i == 0);
                if (dogs.Peek() <= nextBark)
                {
                    dogs.Dequeue();
                    dogs.Enqueue(nextBark + k);
                }
                else
                {
                    dogs.Enqueue(nextBark + k);
                    result = Math.Max(result, dogs.Count);
                }
            }

            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
        }
    }
}