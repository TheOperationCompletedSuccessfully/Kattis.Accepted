using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace GeezerScripts
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 22, 2 ^ 7);
            var a = scanner.NextUInt();
            var h = scanner.NextUInt();
            var n = scanner.NextUInt(true);
            var m = scanner.NextUInt();
            //var random = new Random(DateTime.Now.Millisecond);

            var passages = new Dictionary<int, List<Passage>>();
            bool metEnd = false;
            for (int i = 0; i < m; i++)
            {
                var node1 = scanner.NextUInt(true);//1+random.Next(1, 4*n-1)/4;
                var node2 = scanner.NextUInt();//1+random.Next(1, 4*n-1)/4;
                var monsterAttack = scanner.NextUInt();//1;
                var monsterLife = scanner.NextUInt();//random.Next(1, 4);
                var times = Math.DivRem(monsterLife, a, out int rem);
                var damage = (long)monsterAttack * Math.Max(0,(times - 1)) + (rem == 0||a>=monsterLife ? 0 : monsterAttack);
                //no sense to add if it is impassable
                if (damage < h)
                {
                    var passage1 = new Passage { From = node1, To = node2, Damage = damage };
                    //var passage2 = new Passage { From = node2, To = node1, Damage = damage };
                    if (passages.TryGetValue(node1, out List<Passage> passageValue1))
                    {
                        passageValue1.Add(passage1);
                    }
                    else
                    {
                        passages.Add(node1, [passage1]);
                    }
                    if (node2 == n)
                    {
                        metEnd = true;
                    }

                    //one way passages, strange if I comment out the passage2
                    //even more tests fail with RTE
                    //if (passages.TryGetValue(node2, out List<Passage> passageValue2))
                    //{
                    //    passageValue2.Add(passage2);
                    //}
                    //else
                    //{
                    //    passages.Add(node2, [passage2]);
                    //}
                }


            }

            if(!metEnd)
            {
                scanner.streamWriter.WriteLine("Oh no");
                scanner.streamWriter.Flush();
                return;
            }

            var visited = new HashSet<int>();
            var pq = new PriorityQueue<Path, long>();
            pq.Enqueue(new Path { Location = 1, Health = h }, 0 - h);

            var enqueued = new Dictionary<int, long>();
            enqueued.Add(1, h);

            while (pq.Count > 0 && pq.Peek().Location != n)
            {
                var next = pq.Dequeue();
                if (next.Visited.Contains(next.Location) || !passages.ContainsKey(next.Location))
                {
                    continue;
                }

                foreach (var passage in passages[next.Location])
                {
                    var remainingHealth = next.Health - passage.Damage;
                    if (remainingHealth>0)
                    {
                        if (!enqueued.TryGetValue(passage.To, out long value) || value < remainingHealth)
                        {
                            var newPath = new Path { Location = passage.To, Visited = new HashSet<int>(next.Visited), Health = remainingHealth };
                            newPath.Visited.Add(next.Location);
                            pq.Enqueue(newPath, 0 - newPath.Health);
                            if(!enqueued.TryAdd(passage.To, remainingHealth))
                            {
                                enqueued[passage.To] = remainingHealth;
                            }
                        }
                    }
                }

            }

            if (pq.Count == 0)
            {
                scanner.streamWriter.WriteLine("Oh no");
            }
            else
            {
                scanner.streamWriter.WriteLine(pq.Peek().Health);
            }
            scanner.streamWriter.Flush();
        }

        public class Path
        {
            public int Location { get; set; }
            public HashSet<int> Visited = [];
            public long Health { get; set; }
        }

        public class Passage
        {
            public int From {  get; set; }
            public int To { get; set; }
            public long Damage { get; set; }
        }

    }
}
