using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace BungeeBuilder
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 24, 2 ^ 7);

            var n = scanner.NextUInt();
            var data = new int[n];
            var calced = new int[n];
            int max = -1;
            for(int i=0;i<n;i++)
            {
               var next = i == 0 ? scanner.NextUInt(true) : scanner.NextUInt();
               max = Math.Max(next, max);
               data[i] = next;
               calced[i] = (max - next);
            }
            max = data[n - 1];
            var result = -1;
            for(int i = n-1;i>=0;i--)
            {
               var next = data[i];
               max = Math.Max(next, max);
               calced[i] = Math.Min(calced[i], max-next);
               result = Math.Max(result, calced[i]);
            }

            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }
}
