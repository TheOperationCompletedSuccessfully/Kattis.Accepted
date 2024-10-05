using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace RockSPT
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 27, 2 ^ 12);

            var n = scanner.NextUInt();
            do
            {
               var k = scanner.NextUInt();
               var playerWins = new Dictionary<int, int>();
               var playerGames = new Dictionary<int, int>();
               for(int i=0;i<n*(n-1)*k/2;i++)
               {
                  var player1 = scanner.NextUInt(true);
                  var action1 = scanner.NextString(97);
                  var player2 = scanner.NextUInt();
                  var action2 = scanner.NextString(97);
                  if(!playerWins.ContainsKey(player1))
                  {
                     playerWins.Add(player1, 0);
                  }
                  if (!playerWins.ContainsKey(player2))
                  {
                     playerWins.Add(player2, 0);
                  }
                  if (!playerGames.ContainsKey(player1))
                  {
                     playerGames.Add(player1, 0);
                  }
                  if (!playerGames.ContainsKey(player2))
                  {
                     playerGames.Add(player2, 0);
                  }
                  var result = action1.Length - action2.Length;
                  if(Math.Max(action1.Length,action2.Length)==2*Math.Min(action1.Length, action2.Length))
                  {
                     result = -1 * result;
                  }
                  result /= Math.Max(Math.Abs(result),1);
                  playerWins[player1] += Math.Max(result,0);
                  playerWins[player2] += Math.Abs(Math.Min(result, 0));

                  playerGames[player1] += Math.Abs(result);
                  playerGames[player2] += Math.Abs(result);
               }

               for(int i=1;i<=n;i++)
               {
                  if (playerGames.ContainsKey(i) && playerGames[i] > 0)
                  {
                     scanner.streamWriter.WriteLine("{0:N3}", playerWins[i] / (double)playerGames[i]);
                  }
                  else
                  {
                     scanner.streamWriter.WriteLine("-");
                  }
               }
               n = scanner.NextUInt(true);
               if(n>0)
               {
                  scanner.streamWriter.WriteLine();
               }
            }
            while (n > 0);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }
}
