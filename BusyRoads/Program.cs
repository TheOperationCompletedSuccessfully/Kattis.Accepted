using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace BusyRoads
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 23, 2 ^ 7);
            var cities = scanner.NextUInt();
            var roadNumber = scanner.NextUInt();
            var dayLength = scanner.NextUInt();

            var roads = new Dictionary<int, List<Road>>();
            for (int i = 0; i < roadNumber; i++)
            {
                var nextRoadFrom = scanner.NextUInt(true);
                var nextRoadTo = scanner.NextUInt();
                var nextRoadWeight = scanner.NextUInt();
                var nextRoadOpenFrom = scanner.NextUInt();
                var nextRoadOpenTo = scanner.NextUInt();

                var road1 = new Road { From = nextRoadFrom, To = nextRoadTo, Weight = nextRoadWeight, OpenFrom = nextRoadOpenFrom, OpenTo = nextRoadOpenTo };
                var road2 = new Road { From = nextRoadTo, To = nextRoadFrom, Weight = nextRoadWeight, OpenFrom = nextRoadOpenFrom, OpenTo = nextRoadOpenTo };

                if (roads.TryGetValue(road1.From, out List<Road>? roads1))
                {
                    roads1.Add(road1);
                }
                else
                {
                    roads.Add(road1.From, [road1]);
                }

                if (roads.TryGetValue(road2.From, out List<Road>? roads2))
                {
                    roads2.Add(road2);
                }
                else
                {
                    roads.Add(road2.From, [road2]);
                }


            }
            var pq = new PriorityQueue<Path, long>();
            var start = new Path { City = 1, Time = 0 };
            pq.Enqueue(start, start.Time);
            var visited = new HashSet<int>();
            while (pq.Count > 0 && pq.Peek().City != cities)
            {
                var nextPath = pq.Dequeue();
                if (visited.Contains(nextPath.City))
                {
                    continue;
                }
                if (roads.TryGetValue(nextPath.City, out List<Road>? nextRoadsToProcess))
                {
                    var exactTime = nextPath.Time % dayLength;
                    foreach (var road in nextRoadsToProcess)
                    {
                        var nextDestination = road.To;
                        long nextTime;
                        if (exactTime >= road.OpenFrom && exactTime <= road.OpenTo)
                        {
                            nextTime = nextPath.Time + road.Weight;
                        }
                        else
                        {
                            nextTime = nextPath.Time + road.Weight + (road.OpenFrom > exactTime ? road.OpenFrom - exactTime : dayLength - exactTime + road.OpenFrom);
                        }

                        var newPath = new Path { City = nextDestination, Time = nextTime };
                        pq.Enqueue(newPath, nextTime);
                    }
                }
                visited.Add(nextPath.City);
            }
            scanner.streamWriter.WriteLine(pq.Peek().Time);
            scanner.streamWriter.Flush();
        }
    }
}

class Path
{
    public int City { get; set; }
    public long Time { get; set; }
}

class Road
{
    public int From;
    public int To;
    public int OpenFrom;
    public int OpenTo;
    public int Weight;
}