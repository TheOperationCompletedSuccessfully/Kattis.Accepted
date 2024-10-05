using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace ICouldHaveWon
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 11, 2 ^ 14);
            int nextChar = 0;
            var gameData = new Dictionary<int, Dictionary<int,int>>();
            var rounds = new Dictionary<int, int>();
            int length = 0;
            var gameResults = new Dictionary<int, int>();
            nextChar = scanner.NextByte();
            do
            {
               length++;
               for(int i=length;i>=1;i--)
               {
                  if(i==length)
                  {
                     if(gameResults.ContainsKey(i-1))
                     {
                        gameData.Add(i, new Dictionary<int, int>() { { -1, 0 }, { 1, 0 } });
                        gameData[i][gameResults[i - 1]] += (i - 1);
                        
                     }
                     else
                     {
                        if (gameData.ContainsKey(i - 1))
                        {
                           gameData.Add(i, new Dictionary<int, int>() { { -1, gameData[i-1][-1] }, { 1, gameData[i - 1][1] } });
                        }
                        else
                        {
                           gameData.Add(i, new Dictionary<int, int>() { { -1, 0 }, { 1, 0 } });
                        }
                     }
                     
                     rounds.Add(i, 1);
                  }
                  gameData[i][131 - 2 * nextChar]++;

                  if(gameData[i][-1]==i || gameData[i][1]==i)
                  {
                     if(gameData[i][1] == i)
                     {
                        if(gameResults.ContainsKey(i))
                        {
                           gameResults[i]++;
                        }
                        else
                        {
                           gameResults.Add(i, 1);
                        }
                        
                     }
                     if(gameData[i][-1] == i)
                     {
                        if (gameResults.ContainsKey(i))
                        {
                           gameResults[i]--;
                        }
                        else
                        {
                           gameResults.Add(i, -1);
                        }
                     }
                     gameData[i] = new Dictionary<int, int>() { { -1, 0 }, { 1, 0 } };
                  }
               }
               nextChar = scanner.NextByte();
            }
            while (nextChar > 64);
            var results = gameResults.Where(r => r.Value > 0).Select(kvp => kvp.Key).OrderBy(k => k).ToArray();
            scanner.streamWriter.WriteLine(results.Length);
            if(results.Length>0)
            {
               var data = string.Join(" ", results);
               scanner.streamWriter.WriteLine(data);
            }
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }
}
