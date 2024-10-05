using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace Election2
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 20, 2 ^ 7);

            var n = scanner.NextUInt();
            var candidates = new Dictionary<string, string>();
            var votes = new Dictionary<string, int>();
            for(int i=0;i<n;i++)
            {
               var candidate = scanner.NextString(32);
               var party = scanner.NextString(32);
               candidates.Add(candidate, party);
            }
            var m = scanner.NextUInt(true);
            var maxVotes = 1;
            for(int i=0;i<m;i++)
            {
               var nextVote = scanner.NextString(32);
               if(!candidates.ContainsKey(nextVote))
               {
                  continue;
               }
               if(votes.ContainsKey(nextVote))
               {
                  votes[nextVote]++;
                  maxVotes = Math.Max(maxVotes, votes[nextVote]);
               }
               else
               {
                  votes.Add(nextVote, 1);
               }
            }

            var result = votes.Where(kvp => kvp.Value == maxVotes).ToArray();
            if(result.Length>1||result.Length==0)
            {
               scanner.streamWriter.WriteLine("tie");
            }
            else
            {
               scanner.streamWriter.WriteLine(candidates[result[0].Key]);
            }
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }
}
