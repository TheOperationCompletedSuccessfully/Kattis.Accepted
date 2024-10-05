using System;
using System.Collections.Generic;
using Zeva;

namespace SlideCount
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 20, 2 ^ 20);

            var n = scanner.NextUInt();
            var c = scanner.NextUInt();
            var sum = 0;
            var queue = new Queue<Tuple<int, int>>();
            int k = 0;
            for(int i=0;i<n;i++)
            {
               var next = scanner.NextUInt(i == 0);
               if(sum+next<=c)
               {
                  var item = new Tuple<int, int>(next, k);
                  queue.Enqueue(item);
                  sum += next;
                  k++;
               }
               else
               {
                  while(sum+next>c)
                  {
                     var left = queue.Dequeue();
                     scanner.streamWriter.WriteLine(k - left.Item2);
                     sum -= left.Item1;
                     k++;
                  }
                  var item = new Tuple<int, int>(next, k);
                  queue.Enqueue(item);
                  sum += next;
                  k++;
               }
            }

            while(queue.Count>0)
            {
               var left = queue.Dequeue();
               scanner.streamWriter.WriteLine(k - left.Item2);
               k++;
            }
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }
}
