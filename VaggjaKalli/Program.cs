using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace VaggjaKalli
{
    //idea is to create  array of sum of -
    //foreach interva of length m+2 check
    //whether # are the ends
    //and find max of sum
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 9, 2 ^ 5);
            var n = scanner.NextUInt();
            var m = scanner.NextUInt();
            int firstWall = 0;
            do
            {
                firstWall = scanner.NextByte();
            }
            while (firstWall != 35);

            int freeSpace = 0;
            int bestSpace = -1;

            var queue = new Queue<int>();
            queue.Enqueue(35);
            for (int i = 0; i < m; i++)
            {
                var nextData = scanner.NextByte();
                if (nextData == 45)
                {
                    freeSpace++;
                }
                queue.Enqueue(nextData);
            }
            for (int i = 0; i < n - m - 1; i++)
            {
                var nextData = scanner.NextByte();
                var prevData = queue.Dequeue();
                if (nextData == 35 && prevData == 35)
                {
                    bestSpace = Math.Max(bestSpace, freeSpace);
                }
                else
                {
                    var toAdd = (nextData - prevData) / 10;
                    freeSpace += toAdd;
                }
                queue.Enqueue(nextData);
            }

            if(bestSpace < 0)
            {
                scanner.streamWriter.WriteLine("Neibb");
            }
            else
            {
                scanner.streamWriter.WriteLine(m-bestSpace);
            }
            
            scanner.streamWriter.Flush();
        }
    }
}