using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace Hermits
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 24, 2 ^ 7);

            var streets = new Dictionary<int, int>();
            var totals = new Dictionary<int, int>();

            var n = scanner.NextUInt();
            for(int i=0;i<n;i++)
            {
               var dwellers = (i == 0) ? scanner.NextUInt(true) : scanner.NextUInt();
               streets.Add((i + 1), dwellers);
               totals.Add((i + 1), dwellers);
            }

            var crossingsNumber = scanner.NextUInt(true);
            for(int i=0;i<crossingsNumber;i++)
            {
               var index1 = scanner.NextUInt(true);
               var index2 = scanner.NextUInt();

               var dwellers1 = streets[index1];
               var dwellers2 = streets[index2];
               totals[index1] += dwellers2;
               totals[index2] += dwellers1;

            }

            var result = new Tuple<int,int>(1, totals[1]);
            for (int i = 1; i < n; i++)
            {
               if(totals[i+1]<result.Item2)
               {
                  result = new Tuple<int, int>(i + 1, totals[i + 1]);
               }
            }

            scanner.streamWriter.WriteLine(result.Item1);
            scanner.streamWriter.Flush();
         }

         //Console.ReadKey();
      }
   }
}
