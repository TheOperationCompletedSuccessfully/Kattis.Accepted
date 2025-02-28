using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Brexit
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 23, 2 ^ 7);
            var c = scanner.NextUInt();
            var p = scanner.NextUInt();
            var homeCountry = scanner.NextUInt();
            var firstToLeave = scanner.NextUInt();
            if (firstToLeave == homeCountry)
            {
                scanner.streamWriter.WriteLine("leave");
                scanner.streamWriter.Flush();
                return;
            }

            var partnerships = new Dictionary<int, HashSet<int>>();
            var countriesLeft = Enumerable.Range(1, c).ToHashSet();
            var queue = new Queue<int>();
            queue.Enqueue(firstToLeave);
            for (int i = 0; i < p; i++)
            {
                var partner1 = scanner.NextUInt(true);
                var partner2 = scanner.NextUInt();
                if (partnerships.TryGetValue(partner1, out HashSet<int>? partners1))
                {
                    partners1.Add(partner2);
                }
                else
                {
                    partnerships.Add(partner1, [partner2]);
                }

                if (partnerships.TryGetValue(partner2, out HashSet<int>? partners2))
                {
                    partners2.Add(partner1);
                }
                else
                {
                    partnerships.Add(partner2, [partner1]);
                }
            }
            if (!partnerships.ContainsKey(homeCountry))
            {
                scanner.streamWriter.WriteLine("stay");
                scanner.streamWriter.Flush();
                return;
            }
            var initialCounts = partnerships.ToDictionary(kvp => kvp.Key, kvp => kvp.Value.Count);

            while (queue.Count > 0 && countriesLeft.Contains(homeCountry))
            {
                var nextToLeave = queue.Dequeue();
                countriesLeft.Remove(nextToLeave);
                if (partnerships.TryGetValue(nextToLeave, out HashSet<int>? toProcess))
                {
                    foreach (var partner in toProcess)
                    {
                        partnerships[partner].Remove(nextToLeave);
                        if (partnerships[partner].Count <= initialCounts[partner] / 2)
                        {
                            queue.Enqueue(partner);
                        }
                    }
                    partnerships.Remove(nextToLeave);
                }
            }

            scanner.streamWriter.WriteLine(countriesLeft.Contains(homeCountry) ? "stay" : "leave");
            scanner.streamWriter.Flush();
        }
    }
}