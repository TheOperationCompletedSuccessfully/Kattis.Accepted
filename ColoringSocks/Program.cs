using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace ColoringSocks
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 20, 2 ^ 7);

            var s = scanner.NextUInt();
            var capacity = scanner.NextUInt();
            var k = scanner.NextUInt();
            var pq = new PriorityQueue<int, int>();
            var data = new Dictionary<int, int>();
            for (int i = 0; i < s; i++)
            {
                var next = scanner.NextUInt(i==0);
                if(data.TryGetValue(next, out int value))
                {
                    data[next] = ++value;
                }
                else
                {
                    data.Add(next, 1);
                    pq.Enqueue(next,next);
                }

            }
            var prev = pq.Dequeue();
            var answer = data[prev]/capacity;
            var rem = data[prev]%capacity;
            while (pq.Count > 0)
            {
                var next = pq.Dequeue();
                var amount = data[next];
                if(next-prev>k)
                {
                    answer += (rem>0?1:0) + amount / capacity;
                    rem = amount % capacity;
                    prev = next;
                    continue;
                }
                if(rem+amount<=capacity)
                {
                    rem+= amount;
                    prev = next;
                    continue;
                }
                answer += (rem + amount) / capacity;
                rem = (rem + amount) % capacity;
                prev = next;
            }
            if(rem>0)
            {
                answer++;
            }
            scanner.streamWriter.WriteLine(answer);
            scanner.streamWriter.Flush();
        }
    }
}