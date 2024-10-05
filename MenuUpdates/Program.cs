using System;
using System.Collections.Generic;
using Zeva;

namespace MenuUpdates
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 20, 2 ^ 20);
            var d = scanner.NextUInt();
            var menuUpdates = scanner.NextUInt();
            //var usedIndexes = new HashSet<int>();
            var freeQueue = new Queue<MenuItemIndex>();
            var orderedVacantIndexes = new MinIntHeap<MenuItemIndex>();
            //var lastUpdate = 0;
            var lastUsedIndex = 0;
            for(int i=0;i<menuUpdates;i++)
            {
               var command = scanner.NextString(97);
               switch (command)
               {
                  case "a":
                     while(freeQueue.Count>0&&freeQueue.Peek().UsedUntil<=i)
                     {
                        var toTransfer = freeQueue.Dequeue();
                        orderedVacantIndexes.Push(toTransfer);
                     }
                     //MenuItemIndex nextIndex;
                     if(orderedVacantIndexes.Count>0)
                     {
                        var nextIndex = orderedVacantIndexes.Pop();
                        scanner.streamWriter.WriteLine(nextIndex.Index);
                     }
                     else
                     {
                        lastUsedIndex++;
                        scanner.streamWriter.WriteLine(lastUsedIndex);
                        //usedIndexes.Add(lastUsedIndex);
                     }
                     break;
                  case "r":
                     var indexToRemove = scanner.NextUInt();
                     var indexToQueue = new MenuItemIndex { Index = indexToRemove, UsedUntil = i + d };
                     freeQueue.Enqueue(indexToQueue);
                     break;
               }
            }
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }

      public class MenuItemIndex : IGetIntValue<MenuItemIndex>
      {
         public int Index { get; set; }

         public int UsedUntil { get; set; }

         public int GetValue(MenuItemIndex item) => item.Index;
      }
   }
}
