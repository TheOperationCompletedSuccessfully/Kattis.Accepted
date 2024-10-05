using System;
using System.Collections.Generic;
using Zeva;

namespace FantasyDraft
{
   class Program
   {
      public static Dictionary<int, Queue<string>> _preferenceLists = new Dictionary<int, Queue<string>>();
      
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 21, 2 ^ 21);

            HashSet<string> chosenNames = new HashSet<string>();
            var teams = new Dictionary<int, Queue<string>>();
            var owners = scanner.NextUInt();
            var teamSize = scanner.NextUInt();
            for(int i=0;i<owners;i++)
            {
               var prefListSize = scanner.NextUInt(true);
               _preferenceLists.Add(i, new Queue<string>());
               teams.Add(i, new Queue<string>());
               for(int j=0;j< prefListSize; j++)
               {
                  var next = scanner.NextString(65);
                  _preferenceLists[i].Enqueue(next);
               }
            }

            var playersNumber = scanner.NextUInt(true);
            var playersToChoose = new HashSet<string>();
            var rankingQueue = new Queue<string>();

            for(int i=0;i<playersNumber;i++)
            {
               var nextName = scanner.NextString(65);
               playersToChoose.Add(nextName);
               rankingQueue.Enqueue(nextName);
            }

            for (int currentSize = 0; currentSize < teamSize && playersToChoose.Count > 0; currentSize++)
            {
               for (int owner = 0; owner < owners && playersToChoose.Count > 0; owner++)
               {
                  while(_preferenceLists[owner].Count>0 && chosenNames.Contains(_preferenceLists[owner].Peek()))
                  {
                     _preferenceLists[owner].Dequeue();
                  }
                  if(_preferenceLists[owner].Count>0)
                  {
                     var nextName = _preferenceLists[owner].Dequeue();
                     playersToChoose.Remove(nextName);
                     chosenNames.Add(nextName);
                     teams[owner].Enqueue(nextName);
                  }
                  else
                  {
                     while(rankingQueue.Count>0 && chosenNames.Contains(rankingQueue.Peek()))
                     {
                        rankingQueue.Dequeue();
                     }
                     if(rankingQueue.Count>0)
                     {
                        var anotherName = rankingQueue.Dequeue();
                        playersToChoose.Remove(anotherName);
                        chosenNames.Add(anotherName);
                        teams[owner].Enqueue(anotherName);
                     }
                  }
               }
            }

            for(int owner = 0;owner<owners;owner++)
            {
               scanner.streamWriter.WriteLine(string.Join(" ", teams[owner]));
            }
            scanner.streamWriter.Flush();
         }

         //Console.ReadKey();
      }
   }
}
