using System;
using System.Collections.Generic;
using System.Linq;
using Zagrade;

namespace IslandHopping
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(262144, 256);

                var cases = scanner.NextInt();
                for (int caseNumber = 0; caseNumber < cases; caseNumber++)
                {
                    
                    var numberOfIslands = scanner.NextInt(true);
                    //-0.001 -0.001 doesn't work
                    var field = new Island[numberOfIslands];
                    var random = new Random(DateTime.Now.Millisecond);
                    for(int islandNumber = 0; islandNumber < numberOfIslands; islandNumber++)
                    {
                        var x = scanner.NextDouble(true);//random.NextDouble() * 2000 - 1000;//
                        var y = scanner.NextDouble(); //random.NextDouble() * 2000 - 1000; //
                        field[islandNumber] = new Island { X = x, Y = y };
                    }

                    if(numberOfIslands == 1)
                    {
                        scanner.streamWriter.WriteLine(0);
                        continue;
                    }

                    var bridges = new List<Bridge>();
                    double minDistance = 4000000;
                    //var result = 0;
                    Bridge minBridge = null;
                    //var minDistanceIndex2 = -1;
                    for (int i = 0; i < numberOfIslands; i++)
                        for(var j=i+1;j<numberOfIslands;j++)
                        {
                            var bridge = new Bridge { IslandIndex1 = i, IslandIndex2 = j, Distance = GetDistance(ref field, i, j) };
                            bridges.Add(bridge);
                            if(bridge.Distance < minDistance)
                            {
                                minBridge = bridge;
                                minDistance = bridge.Distance;
                            }
                        }

                    var builtBridges = new List<Bridge>();
                    builtBridges.Add(minBridge);
                    bridges.Remove(minBridge);
                    field[minBridge.IslandIndex1].Connnected = true;
                    field[minBridge.IslandIndex2].Connnected = true;
                    var orderedBridges = bridges.OrderBy(b => b.Distance).ToList();

                    while(field.Any(f=>!f.Connnected))
                    {
                        int index = 0;
                        //var bridgesToRemove = new List<Bridge>();
                        var bFound = false;
                        foreach(var item in orderedBridges)
                        {
                            //if (field[item.IslandIndex1].Connnected && field[item.IslandIndex2].Connnected)
                            //{
                            //    bridgesToRemove.Add(item);
                            //}

                            if (field[item.IslandIndex1].Connnected && !field[item.IslandIndex2].Connnected)
                            {
                                bFound = true;
                                builtBridges.Add(item);
                                field[item.IslandIndex1].Connnected = true;
                                field[item.IslandIndex2].Connnected = true;
                                //bridgesToRemove.Add(item);
                            }

                            if (!field[item.IslandIndex1].Connnected && field[item.IslandIndex2].Connnected)
                            {
                                bFound = true;
                                builtBridges.Add(item);
                                field[item.IslandIndex1].Connnected = true;
                                field[item.IslandIndex2].Connnected = true;
                                //bridgesToRemove.Add(item);
                            }
                            index++;
                            if (bFound)
                            {
                                break;
                            }
                            
                        }

                        //if(index<field.Length-3)
                        //    foreach (var bridgeToRemove in bridgesToRemove)
                        //    {
                        //        orderedBridges.Remove(bridgeToRemove);
                        //    }

                    }

                    var result = builtBridges.Sum(b => GetDistance(ref field, b.IslandIndex1, b.IslandIndex2));

                    scanner.streamWriter.WriteLine(result);

                }

                scanner.streamWriter.Flush();
                //Console.ReadKey();
            }
        }

        public static double GetDistance(ref Island[] islands, int i, int j)
        {
            var island1 = islands[i];
            var island2 = islands[j];
            return Math.Sqrt((island1.X - island2.X) * (island1.X - island2.X) + (island1.Y - island2.Y) * (island1.Y - island2.Y));
        }
    }

    

    public class Bridge
    {
        public double Distance { get; set; }
        public int IslandIndex1 { get; set; }
        public int IslandIndex2 { get; set; }
    }

    public class Island
    {
        public double X { get; set; }
        public double Y { get; set; }
        public bool Connnected { get; set; }

        
    }
}
