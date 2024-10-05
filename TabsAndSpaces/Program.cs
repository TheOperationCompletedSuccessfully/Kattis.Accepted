using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace TabsAndSpaces
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 10, 2 ^ 7);

            var filesNumber = scanner.NextUInt();
            var maxLine = 0;
            var total = 0;
            var stats = new Dictionary<int, int>();
            for (int i=0;i<filesNumber;i++)
            {
               var lines = scanner.NextUInt(true);
               
               for(int j=0;j<lines;j++)
               {
                  var next = scanner.NextUInt(true);
                  maxLine = Math.Max(next, maxLine);
                  total += next;
                  if(stats.ContainsKey(next))
                  {
                     stats[next]++;
                  }
                  else
                  {
                     stats.Add(next, 1);
                  }
               }
               
            }
            var bestOption = total;
            var tabLength = 1;
            var preparedList = stats.Where(vp => vp.Key != 0).ToList();
            for (int k = 2; k <= maxLine; k++)
            {
               var nextResult = preparedList.Select(kvp => { var s = Math.DivRem(kvp.Key, k, out int nRes); return kvp.Value * (s + nRes); }).Sum();
               if (nextResult < bestOption)
               {
                  bestOption = nextResult;
                  tabLength = k;
               }
            }
            scanner.streamWriter.WriteLine(tabLength);
            scanner.streamWriter.WriteLine(total - bestOption);
            
            scanner.streamWriter.Flush();

         }
         //Console.ReadKey();
      }
   }
}
