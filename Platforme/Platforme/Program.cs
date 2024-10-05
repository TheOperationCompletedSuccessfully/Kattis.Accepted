using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Platforme
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 14, 2 ^ 7);

                var platformNumber = scanner.NextUInt();
                var platforms = new List<Platform>();
                for(int i=0;i<platformNumber;i++)
                {
                    var height = scanner.NextUInt(true);
                    var start = scanner.NextUInt();
                    var end = scanner.NextUInt();
                    var platform = new Platform { PillarStart = 2*start+1, PillarEnd = 2*end-1, Height = height,DeckStart = 2*start,DeckEnd=2*end };
                    platforms.Add(platform);
                }

                var sorted = platforms.OrderByDescending(p => p.Height).ThenBy(p => p.DeckStart);
                //xcoord, not height
                var pillars = new Queue<int>();
                
                var result = 0;
                foreach(var platformEvent in sorted)
                {
                    result += 2 * platformEvent.Height;
                    var pillarsQueue = new Queue<int>();
                    while (pillars.Count>0)
                    {
                        var pillar = pillars.Dequeue();
                        if(pillar>=platformEvent.DeckStart && pillar<=platformEvent.DeckEnd)
                        {
                            result -= platformEvent.Height;
                        }
                        else
                        {
                            pillarsQueue.Enqueue(pillar);
                        }
                    }
                    pillars = pillarsQueue;
                    pillars.Enqueue(platformEvent.PillarStart);
                    pillars.Enqueue(platformEvent.PillarEnd);
                    
                }
                scanner.streamWriter.WriteLine(result);
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }

        class Platform
        {
            public int PillarStart { get; set; }
            public int PillarEnd { get; set; }

            public int DeckStart { get; set; }
            public int DeckEnd { get; set; }
            public int Height { get; set; }
        }
    }
}
