using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace Nikola
{
   class Program
   {

      public static HashSet<int> visitedByJumps = new HashSet<int>();

      public static int[] data;

      public static MinIntHeap<Move> jumps = new MinIntHeap<Move>();
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 13, 2 ^ 7);

            var n = scanner.NextUInt();
            data = new int[n];

            for(int i=0;i<n;i++)
            {
               var next = scanner.NextUInt(true);
               data[i] = next;
            }
            var firstMove = new Move
            {
               Jump = 1,
               Location = 1,
               Payment = data[1]

            };
            jumps.Push(firstMove);
            while(jumps.Peek().Location!=n-1)
            {
               PerformJumps(n - 1);
            }

            var result = jumps.Pop();
            scanner.streamWriter.WriteLine(result.Payment);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }

      private static void PerformJumps(int targetLocation)
      {
         if (jumps.Count > 0)
         {
            var prevMove = jumps.Pop();
            var nextLocation1 = (prevMove.Jump +1) + prevMove.Location;
            if (nextLocation1 <= targetLocation)
            {
               var action1 = (prevMove.Jump * (targetLocation + 1)) + nextLocation1;
               if (!visitedByJumps.Contains(action1))
               {
                  visitedByJumps.Add(action1);
                  var nextMove1 = new Move { Jump = prevMove.Jump + 1, Location = nextLocation1, Payment = prevMove.Payment + data[nextLocation1] };
                  jumps.Push(nextMove1);
               }
            }
            var nextLocation2 = prevMove.Location - prevMove.Jump;
            if (nextLocation2 >= 0)
            {
               var action2 = -1 * ((prevMove.Jump * (targetLocation + 1)) + nextLocation2);
               if (!visitedByJumps.Contains(action2))
               {
                  visitedByJumps.Add(action2);
                  var nextMove2 = new Move { Jump = prevMove.Jump, Location = nextLocation2, Payment = prevMove.Payment + data[nextLocation2] };
                  jumps.Push(nextMove2);
               }
            }
         }
      }

      public class Move : IGetIntValue<Move>
      {
         public int Jump { get; set; }

         public int Location { get; set; }

         public int Step { get; set; }

         public int Payment { get; set; }

         public int GetValue(Move item) => item.Payment;
      }
   }
}
