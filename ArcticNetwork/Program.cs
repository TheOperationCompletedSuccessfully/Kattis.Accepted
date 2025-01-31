using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;


namespace ArcticNetwork
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 20, 2 ^ 7);
            var cases = scanner.NextUInt();
           
            for (var caseNumber = 0; caseNumber < cases; caseNumber++)
            {
                var satelliteChannels = scanner.NextUInt(true);
                var p = scanner.NextUInt();
                var unchosen = Enumerable.Range(0, p).ToHashSet();
                var chosenGroups = new List<HashSet<int>>();
                var chosen = new HashSet<int>();
                var pq = new PriorityQueue<Edge, double>();
                var coords = new Dictionary<int, Tuple<int, int>>();
                for (int i = 0; i < p; i++)
                {
                    var nextX = scanner.NextUInt(true);
                    var nextY = scanner.NextUInt();
                    coords.Add(i, new Tuple<int, int>(nextX, nextY));
                    for (int j = 0; j < i; j++)
                    {
                        var nextWeight = CalcCoords(coords[j].Item1, coords[j].Item2, coords[i].Item1, coords[i].Item2);
                        var nextEdge = new Edge { From = j, To = i, Weight = nextWeight };
                        pq.Enqueue(nextEdge, nextWeight);
                    }
                }

                var chosenEdges = new List<Edge>();
                var next = pq.Dequeue();
                chosen.Add(next.From);
                chosen.Add(next.To);
                chosenEdges.Add(next);
                unchosen.Remove(next.From);
                unchosen.Remove(next.To);
                chosenGroups.Add([next.From, next.To]);

                while (pq.Count > 0 && unchosen.Count + chosenGroups.Count > satelliteChannels)
                {
                    next = ProcessNextQueueItem(unchosen, chosenGroups, chosen, pq, chosenEdges);
                }

                scanner.streamWriter.WriteLine($"{next.Weight:N2}");
            }
            scanner.streamWriter.Flush();
        }

        static double CalcCoords(int x1, int y1, int x2, int y2)
        {
            return Math.Sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
        }

        static Edge ProcessNextQueueItem(HashSet<int> unchosen, List<HashSet<int>> chosenGroups, HashSet<int> chosen, PriorityQueue<Edge, double> pq, List<Edge> chosenEdges)
        {
            var next = pq.Dequeue();
            chosen.Add(next.From);
            chosen.Add(next.To);
            chosenEdges.Add(next);
            HashSet<int> fromHashSet = null;
            HashSet<int> toHashSet = null;
            if (unchosen.Contains(next.From))
            {
                unchosen.Remove(next.From);
                fromHashSet = new HashSet<int>([next.From]);
            }
            else
            {
                fromHashSet = chosenGroups.First(x => x.Contains(next.From));
                chosenGroups.Remove(fromHashSet);
            }
            if (unchosen.Contains(next.To))
            {
                unchosen.Remove(next.To);
                fromHashSet.Add(next.To);
                chosenGroups.Add(fromHashSet);
            }
            else
            {
                if (!fromHashSet.Contains(next.To))
                {
                    toHashSet = chosenGroups.First(x => x.Contains(next.To));
                    foreach (var item in fromHashSet)
                    {
                        toHashSet.Add(item);
                    }
                }
                else
                {
                    chosenGroups.Add(fromHashSet);
                    return next;
                }
            }

            return next;
        }
    }



    class Edge
    {
        public int From { get; set; }
        public int To { get; set; }
        public double Weight { get; set; }
    }
}

