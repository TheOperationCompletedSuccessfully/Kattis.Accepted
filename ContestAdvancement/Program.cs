using System;
using System.Collections.Generic;
using Zeva;

namespace ContestAdvancement
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 18, 2 ^ 12);
            var teamsCount = scanner.NextUInt();
            var toAcceptCount = scanner.NextUInt();
            var schoolLimit = scanner.NextUInt();

            var allTeams = new MaxIntHeap<Team>();
            var candidates2ndRound = new MaxIntHeap<Team>();
            var chosen = new MaxIntHeap<Team>();
            var acceptedRegister = new Dictionary<int, int>();

            for(int i=0;i< teamsCount&&chosen.Count<toAcceptCount; i++)
            {
               var nextId = scanner.NextUInt(true);
               var school = scanner.NextUInt();
               var next = new Team { Id = nextId, School = school, Rank = teamsCount - i };
               if(!acceptedRegister.ContainsKey(school))
               {
                  acceptedRegister.Add(school, 1);
                  chosen.Add(next);
                  continue;
               }
               if(acceptedRegister[school]<schoolLimit)
               {
                  acceptedRegister[school]++;
                  chosen.Add(next);
                  continue;
               }
               candidates2ndRound.Add(next);
            }

            while(chosen.Count<toAcceptCount)
            {
               var toAdd = candidates2ndRound.Pop();
               chosen.Push(toAdd);
            }

            while (chosen.Count > 0)
            {
               var toPrint = chosen.Pop();
               scanner.streamWriter.WriteLine(toPrint.Id);
            }
            scanner.streamWriter.Flush();

         }
         //Console.ReadKey();
      }

      public class Team : IGetIntValue<Team>
      {
         public int Id { get; set; }
         public int School { get; set; }

         public int Rank { get; set; }

         public int GetValue(Team item) => item.Rank;
      }
   }
}
