using System;
using Zeva;

namespace AnnoyedCoworkers
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 21, 2 ^ 7);
            var h = scanner.NextUInt();
            var c = scanner.NextUInt();
            var result = 0L;
            var heap = new MinLongHeap<Coworker>();
            for (int i = 0; i < c; i++)
            {
               var a = scanner.NextUInt(true);
               var d = scanner.NextUInt();
               var coworker = new Coworker { A = a, D = d, Used=0 };
               heap.Push(coworker);
               result = Math.Max(result, a);

            }
            

            for(int i=0; i<h;i++)
            {
               var data = heap.Pop();
               data.A += data.D;
               result = Math.Max(result, data.A);
               data.Used++;
               heap.Push(data);
            }
            
            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }

   class Coworker : IGetLongValue<Coworker>
   {
      public long A { get; set; }
      public long D { get; set; }

      public int Used { get; set; }

      public long GetValue(Coworker item) => item.A + item.D;
      
   }
}
