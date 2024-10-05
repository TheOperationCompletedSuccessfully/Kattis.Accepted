using System;
using System.Collections.Generic;
using Zeva;

namespace Hittast
{
   class Program
   {
      static void Main(string[] args)
      {
         long bigNumber = 100000000000;
         
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 23, 2 ^ 7);

            var locationsNumber = scanner.NextUInt();
            var travelRoutesNumber = scanner.NextUInt();
            var routes = new Dictionary<int,List<Route>>();
            var lodgingPrices = new int[locationsNumber];
            var locationPricesA = new long[locationsNumber];
            var locationPricesB = new long[locationsNumber];
            var paths = new MinLongHeap<Path>();
            for(int i=0;i<locationsNumber;i++)
            {
               var nextPrice = scanner.NextUInt(i == 0);
               lodgingPrices[i] = nextPrice;
               locationPricesA[i] = bigNumber;
               locationPricesB[i] = bigNumber;
            }

            for(int i=0;i<travelRoutesNumber;i++)
            {
               //we start from zero
               var nextU = scanner.NextUInt(true)-1;
               var nextV = scanner.NextUInt()-1;
               var nextPriceA = scanner.NextUInt();
               var nextPriceB = scanner.NextUInt();

               var route1 = new Route { Start = nextU, End = nextV, PriceA = nextPriceA, PriceB = nextPriceB };
               var route2 = new Route { Start = nextV, End = nextU, PriceA = nextPriceA, PriceB = nextPriceB };
               if(routes.ContainsKey(route1.Start))
               {
                  routes[route1.Start].Add(route1);
               }
               else
               {
                  routes.Add(route1.Start, new List<Route> { route1 });
               }

               if (routes.ContainsKey(route2.Start))
               {
                  routes[route2.Start].Add(route2);
               }
               else
               {
                  routes.Add(route2.Start, new List<Route> { route2 });
               }


            }

            var firstMoveA = new Path { TotalCost = lodgingPrices[0], Who = 0,CurrentLocation=0 };
            var firstMoveB = new Path { TotalCost = lodgingPrices[locationsNumber-1], Who = 1,CurrentLocation=locationsNumber-1 };
            locationPricesA[0] = lodgingPrices[0];
            locationPricesB[locationsNumber - 1] = lodgingPrices[locationsNumber - 1];
            var bestPath = new Path { TotalCost = 10*bigNumber, Who = 0 };
            paths.Push(firstMoveA);
            paths.Push(firstMoveB);
            //while(paths.Count>0&&paths.Peek().TotalCost<bestPath.TotalCost)
            while(paths.Count>0)
            {
               var nextPath = paths.Pop();
               //check can we proceed and is path already 
               if (routes.ContainsKey(nextPath.CurrentLocation))
               {
                  foreach (var option in routes[nextPath.CurrentLocation])
                  {
                     var nextCost = nextPath.TotalCost + (nextPath.Who == 0 ? option.PriceA : option.PriceB)+lodgingPrices[option.End]-lodgingPrices[option.Start];
                     if (nextPath.Who == 0 && locationPricesA[option.End] <= nextCost)
                        continue;

                     if (nextPath.Who == 1 && locationPricesB[option.End] <= nextCost)
                        continue;

                     if (nextPath.Who == 0)
                     {
                        locationPricesA[option.End] = nextCost;
                        
                     }

                     if (nextPath.Who == 1)
                     {
                        locationPricesB[option.End] = nextCost;
                     }
                     var nextMove = new Path { TotalCost = nextCost, CurrentLocation = option.End, Who = nextPath.Who };
                     paths.Push(nextMove);
                     //twice counting lodgingPrices, so remove it
                     bestPath = new Path { TotalCost = Math.Min(bestPath.TotalCost, locationPricesA[option.End] + locationPricesB[option.End] - lodgingPrices[option.End]) };
                  }
               }

            }

            scanner.streamWriter.WriteLine(bestPath.TotalCost);
            scanner.streamWriter.Flush();

         }
         //Console.ReadKey();
      }

      public class Route : IEquatable<Route>
      {
         public int Start { get; set; }

         public int End { get; set; }

         public int PriceA { get; set; }

         public int PriceB { get; set; }

         public bool Equals(Route other)
         {
            return Start.Equals(other.Start) && End.Equals(other.End);
         }
      }

      public class Path : IGetLongValue<Path>
      {
         public long TotalCost { get; set; }

         public int Who { get; set; }

         public int CurrentLocation { get; set; }

         public HashSet<int> Visited { get; set; }

         public long GetValue(Path item) => TotalCost;
      }
   }
}
