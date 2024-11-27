using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace GymLeadersTerritory
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 24, 2 ^ 7))
            {
                var totalGymLeaders = scanner.NextUInt();
                var rivalGymLeader = scanner.NextUInt();
                var totalAlliances = scanner.NextUInt();
                var alliances = new Dictionary<int, List<int>>();
                for (int i = 0; i < totalAlliances; i++)
                {
                    var nextLeader1 = scanner.NextUInt(true);
                    var nextLeader2 = scanner.NextUInt();
                    var alliance1 = new Alliance { FirstLeader = nextLeader1, SecondLeader = nextLeader2 };
                    var alliance2 = new Alliance { FirstLeader = nextLeader2, SecondLeader = nextLeader1 };
                    if (alliances.ContainsKey(nextLeader1))
                    {
                        alliances[nextLeader1].Add(alliance1.SecondLeader);
                    }
                    else
                    {
                        alliances.Add(nextLeader1, new List<int> { alliance1.SecondLeader });
                    }
                    if (alliances.ContainsKey(nextLeader2))
                    {
                        alliances[nextLeader2].Add(alliance2.SecondLeader);
                    }
                    else
                    {
                        alliances.Add(nextLeader2, new List<int> { alliance2.SecondLeader });
                    }
                }
                if (!alliances.ContainsKey(rivalGymLeader))
                {
                    scanner.streamWriter.WriteLine("YES");
                    scanner.streamWriter.Flush();
                    return;
                }

                if (alliances[rivalGymLeader].Count <= 1)
                {
                    scanner.streamWriter.WriteLine("YES");
                    scanner.streamWriter.Flush();
                    return;
                }
                var toDefeat = alliances.Where(kvp=>kvp.Value.Count <=1).ToList();
                while (alliances[rivalGymLeader].Count > 1 && toDefeat.Count>0)
                {
                    foreach(var kvp in toDefeat) 
                    {
                        if(kvp.Value.Count==1)
                        {
                            alliances[kvp.Value[0]].Remove(kvp.Key);
                        }

                        alliances.Remove(kvp.Key);
                    }
                    toDefeat = alliances.Where(kvp => kvp.Value.Count <= 1).ToList();
                }

                if(alliances[rivalGymLeader].Count <= 1)
                {
                    scanner.streamWriter.WriteLine("YES");
                }
                else
                {
                    scanner.streamWriter.WriteLine("NO");
                }
                scanner.streamWriter.Flush();
            }
        }
    }
}

public class Alliance
{
    public int FirstLeader { get; set; }
    public int SecondLeader { get; set; }
}