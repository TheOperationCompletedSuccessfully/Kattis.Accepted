using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace TripPlanning
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2^24,2^23))
            {
                var n = scanner.NextUInt();
                var m = scanner.NextUInt();
                var roads = new int[n];
                var found = 0;
                var random = new Random(DateTime.Now.Microsecond);
                for(int i=0;i<m;i++)
                {
                    var nextFrom = scanner.NextUInt(true);
                    var nextTo = scanner.NextUInt();
                    if(Math.Abs(nextFrom-nextTo)==1 ||Math.Abs(nextFrom-nextTo)==n-1)
                    {
                        var min = Math.Min(nextFrom,nextTo);
                        var max = Math.Max(nextFrom,nextTo);

                        if (Math.Abs(nextFrom - nextTo) == 1)
                        {
                            roads[min-1] = i + 1;
                            found++;
                        }
                        if(Math.Abs(nextFrom - nextTo) == n - 1)
                        {
                            roads[max-1] = i+1;
                            found++;
                        }
                        
                    }

                }

                if (found<n)
                {
                    scanner.streamWriter.WriteLine("impossible");
                    scanner.streamWriter.Flush();
                    return;
                }

                
                    for(int i=0;i<n;i++) 
                    {
                    scanner.streamWriter.WriteLine(roads[i]);
                    }
                scanner.streamWriter.Flush();
            }
        }
    }
}