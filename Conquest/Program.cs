using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;


namespace Conquest
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 22, 2 ^ 7);
            var islandNumber = scanner.NextUInt();
            var bridgeNumber = scanner.NextUInt();
            var islands = Enumerable.Range(0, islandNumber).Select(i => new Island { Id = i }).ToArray();
            var occupationHeap = new PriorityQueue<Island, int>();
            var visited = new HashSet<int>();
            for (int i = 0; i < bridgeNumber; i++)
            {
                var startIsland = scanner.NextUInt(true) - 1;
                var endIsland = scanner.NextUInt() - 1;
                islands[startIsland].Connections.Add(endIsland);
                islands[endIsland].Connections.Add(startIsland);
            }

            for (int i = 0; i < islandNumber; i++)
            {
                var nextSize = scanner.NextUInt(true);
                islands[i].ArmySize = nextSize;
            }

            visited.Add(0);


            var result = islands[0].ArmySize;
            foreach (var islandId in islands[0].Connections)
            {
                var item = islands[islandId];
                occupationHeap.Enqueue(item, item.ArmySize);
            }

            while (occupationHeap.Count > 0 && result > occupationHeap.Peek().ArmySize)
            {
                var processNext = occupationHeap.Dequeue();
                if (!visited.Contains(processNext.Id))
                {
                    visited.Add(processNext.Id);
                    result += processNext.ArmySize;
                    foreach (var islandId in processNext.Connections)
                    {
                        if (!visited.Contains(islandId))
                        {
                            var item = islands[islandId];
                            occupationHeap.Enqueue(item, item.ArmySize);
                        }
                    }
                }
            }

            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
        }
    }

    public class Island
    {
        public int Id { get; set; }

        public int ArmySize { get; set; }

        public List<int> Connections = [];

    }
}
