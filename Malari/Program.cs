using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Malari
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 20, 2 ^ 19);

            var n = scanner.NextUInt();
            var m = scanner.NextUInt();

            var pq = new PriorityQueue<Interval, long>();
            for(int i=0;i<m;i++)
            {
                var nextFrom = scanner.NextULong(true);
                var nextTo = scanner.NextULong();
                var interval = new Interval { From =  nextFrom, To = nextTo };
                pq.Enqueue(interval, interval.From);
            }
            
            var prev = pq.Dequeue();
            long result = 0;
            while (pq.Count > 0) 
            {
                var next = pq.Dequeue();
                 if (next.From >= prev.From && next.To <= prev.To)
                {
                    continue;
                }
                if (next.From <= prev.To && next.To >= prev.To)
                {
                    prev = new Interval { From = prev.From, To = next.To };
                }
                else
                {
                    result += prev.Count;
                    prev = next;
                }
            }
            result += prev.Count;
            scanner.streamWriter.WriteLine(result);
            if(result>n/2)
            {
                scanner.streamWriter.WriteLine("The Mexicans took our jobs! Sad!");
            }
            else
            {
                scanner.streamWriter.WriteLine("The Mexicans are Lazy! Sad!");
            }
            scanner.streamWriter.Flush();
        }
    }

    public class Interval
    {
        public long From { get; set; }
        public long To { get; set; }
        public long Count => To - From + 1; 
    }
}