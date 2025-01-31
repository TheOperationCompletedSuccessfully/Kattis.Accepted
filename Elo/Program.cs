using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Elo
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 14, 2 ^ 7);
            var players = scanner.NextUInt();
            var initialScore = scanner.NextUInt();

            var allowedSteps = new Dictionary<int, List<int>>();
            var uniquePlayers = new HashSet<Player>();
            for (int i = 0; i < players; i++)
            {
                var min = scanner.NextUInt(true);
                var max = scanner.NextUInt();
                var bonus = scanner.NextUInt();
                var nextPlayer = new Player { Id = i, Min = min, Max = max, Bonus = bonus };

                if (!uniquePlayers.Contains(nextPlayer))
                {
                    uniquePlayers.Add(nextPlayer);
                    var steps = Enumerable.Range(min, max - min + 1).ToList();
                    foreach (var step in steps)
                    {
                        if (allowedSteps.TryGetValue(step, out List<int>? destinations))
                        {
                            destinations.Add(i);
                        }
                        else
                        {
                            allowedSteps.Add(step, [i]);
                        }
                    }
                }
            }

            var visitedSteps = new HashSet<int>();
            var pq = new PriorityQueue<int, int>();
            var bestResult = initialScore;
            pq.Enqueue(initialScore, 0 - initialScore);
            var playersDic = uniquePlayers.ToDictionary(p => p.Id, pl => pl);

            while (pq.Count > 0)
            {
                var next = pq.Dequeue();
                bestResult = Math.Max(bestResult, next);
                if (!allowedSteps.ContainsKey(next))
                {
                    continue;
                }
                foreach (var nextPlayer in allowedSteps[next])
                {
                    var nextStep = next + playersDic[nextPlayer].Bonus;
                    if (!visitedSteps.Contains(nextStep))
                    {
                        pq.Enqueue(nextStep, 0 - nextStep);
                        visitedSteps.Add(nextStep);
                    }
                }
            }

            scanner.streamWriter.WriteLine(bestResult);
            scanner.streamWriter.Flush();
        }
    }

    class Player : IEquatable<Player>
    {
        public int Id { get; set; }
        public int Min { get; set; }
        public int Max { get; set; }
        public int Bonus { get; set; }

        public bool Equals(Player? other)
        {
            if (other == null)
                return false;
            return Min.Equals(other.Min) && Max.Equals(other.Max) && Bonus.Equals(other.Bonus);
        }

        public override bool Equals(object obj)
        {
            return Equals(obj as Player);
        }

        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }
    }
}