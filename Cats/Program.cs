using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using Zeva;

namespace Cats
{
    class Program
    {
        static void Main(string[] args)
        {

            using (var scanner = new ZevaScanner(2^26,2^7))
            {
                var testCases = scanner.NextUInt();
                for(int testCase = 0;testCase<testCases;testCase++) 
                {
                    var milk = scanner.NextUInt(true);
                    var catsCount = scanner.NextUInt();
                    var linesCount = catsCount * (catsCount - 1) / 2;
                    var cats = new Dictionary<int, List<CatDistance>>();
                    for(int i=0;i<linesCount;i++) 
                    {
                        var fromCat = scanner.NextUInt(true);
                        var toCat = scanner.NextUInt();
                        var distance = scanner.NextUInt();

                        var catDistance1 = new CatDistance { FirstCat = fromCat, SecondCat = toCat, Distance=distance };
                        var catDistance2 = new CatDistance { FirstCat= toCat, SecondCat = fromCat, Distance=distance };
                        if(cats.ContainsKey(fromCat))
                        {
                            cats[fromCat].Add(catDistance1);
                        }
                        else
                        {
                            cats.Add(fromCat,new List<CatDistance> { catDistance1 });
                        }
                        if(cats.ContainsKey(toCat))
                        {
                            cats[toCat].Add(catDistance2);
                        }
                        else
                        {
                            cats.Add(toCat,new List<CatDistance> { catDistance2 });
                        }
                    }

                    var pq = new PriorityQueue<Path, int>();
                    pq.Enqueue(new Path { Location = 0, MilkUsed = 1 },0);
                    var visited = new HashSet<int>();
                    var milkUsed = 0;
                    while(pq.Count>0 && visited.Count<cats.Count&&milkUsed<=milk)
                    {
                        var nextCat = pq.Dequeue();
                        if(visited.Contains(nextCat.Location))
                        {
                            continue;
                        }
                        foreach(var neighbourCat in cats[nextCat.Location].Where(c=> !visited.Contains(c.SecondCat))) 
                        {
                            var newPath = new Path { Location = neighbourCat.SecondCat, MilkUsed = neighbourCat.Distance + 1 };
                            if (newPath.MilkUsed <= milk)
                            {
                                pq.Enqueue(newPath, newPath.MilkUsed);
                            }
                        }
                        milkUsed+= nextCat.MilkUsed;
                        visited.Add(nextCat.Location);
                    }
                    scanner.streamWriter.WriteLine(visited.Count==cats.Count &&milkUsed<=milk ? "yes" : "no");
                }
                scanner.streamWriter.Flush();
            }
        }
    }
}

public class Path
{
    public int Location { get; set; }
    public int MilkUsed { get; set; }
}

public class CatDistance
{
    public int FirstCat { get; set; }
    public int SecondCat { get; set; }
    public int Distance { get; set; }
}