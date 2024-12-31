using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Bumped
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 22, 2 ^ 7);

            var cities = scanner.NextUInt();
            var totalRoads = scanner.NextUInt();
            var totalFlights = scanner.NextUInt();
            var startCity = scanner.NextUInt();
            var destination = scanner.NextUInt();
            var visitedCities = new Dictionary<int, long>();
            var roads = new Dictionary<int, List<Road>>();
            var flights = new Dictionary<int, List<Road>>();
            var movement = new MinLongHeap<Route>();
            for(int i=0;i< totalRoads; i++)
            {
               var nextStart = scanner.NextUInt(true);
               var nextDestination = scanner.NextUInt();
               var nextCost = scanner.NextUInt();
               var newRoad1 = new Road { StartCity = nextStart, Destination = nextDestination, Cost = nextCost };
               var newRoad2 = new Road { StartCity = nextDestination, Destination = nextStart, Cost = nextCost };
               if(roads.ContainsKey(nextStart))
               {
                  roads[nextStart].Add(newRoad1);
               }
               else
               {
                  roads.Add(nextStart, new List<Road> { newRoad1 });
               }
               if (roads.ContainsKey(nextDestination))
               {
                  roads[nextDestination].Add(newRoad2);
               }
               else
               {
                  roads.Add(nextDestination, new List<Road> { newRoad2 });
               }
            }
            for(int i=0;i< totalFlights; i++)
            {
               var nextStart = scanner.NextUInt(true);
               var nextDestination = scanner.NextUInt();
               var nextFlight = new Road() { StartCity = nextStart, Destination = nextDestination, Cost = 0 };
               if (flights.ContainsKey(nextStart))
               {
                  flights[nextStart].Add(nextFlight);
               }
               else
               {
                  flights.Add(nextStart, new List<Road> { nextFlight });
               }
            }

            //if(startCity==destination)
            //{
            //   scanner.streamWriter.WriteLine(0);
            //   scanner.streamWriter.Flush();
            //   return;
            //}

            var firstMove = new Route { CurrentLocation = startCity, TotalCost = 0, UsedFlightTicket = false };
            movement.Push(firstMove);

            while(movement.Peek().CurrentLocation!=destination)
            {
               var nextMove = movement.Pop();
               if (roads.ContainsKey(nextMove.CurrentLocation))
               {
                  if (visitedCities.ContainsKey(nextMove.CurrentLocation) && visitedCities[nextMove.CurrentLocation] <= nextMove.TotalCost)
                  {
                     continue;
                  }

                  if (!visitedCities.ContainsKey(nextMove.CurrentLocation))
                  {
                     visitedCities.Add(nextMove.CurrentLocation, nextMove.TotalCost);
                  }
                  else
                  {
                     visitedCities[nextMove.CurrentLocation] = nextMove.TotalCost;
                  }

                  foreach (var nextRoad in roads[nextMove.CurrentLocation])
                  {
                     if (visitedCities.ContainsKey(nextRoad.Destination) && visitedCities[nextRoad.Destination] <= nextMove.TotalCost+nextRoad.Cost)
                     {
                        continue;
                     }
                     var nextToAdd = new Route { CurrentLocation = nextRoad.Destination, TotalCost = nextMove.TotalCost + nextRoad.Cost,UsedFlightTicket=nextMove.UsedFlightTicket };
                     movement.Push(nextToAdd);
                  }

                  if(!nextMove.UsedFlightTicket && flights.ContainsKey(nextMove.CurrentLocation))
                  {
                     foreach(var nextFlight in flights[nextMove.CurrentLocation])
                     {
                        if (visitedCities.ContainsKey(nextFlight.Destination) && visitedCities[nextFlight.Destination] <= nextMove.TotalCost)
                        {
                           continue;
                        }
                        var nextToAdd = new Route { CurrentLocation = nextFlight.Destination, TotalCost = nextMove.TotalCost, UsedFlightTicket = true };
                        movement.Push(nextToAdd);
                     }
                  }
               }
            }
            var answer = movement.Pop();
            scanner.streamWriter.WriteLine(answer.TotalCost);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }

      public class Road
      {
         public int StartCity { get; set; }

         public int Destination { get; set; }

         public int Cost { get; set; }
      }
      
      public class Route : IGetLongValue<Route>
      {
         public int CurrentLocation { get; set; }

         public long TotalCost { get; set; }

         public bool UsedFlightTicket { get; set; }

         public long GetValue(Route item) => item.TotalCost;
      }
   }
}
