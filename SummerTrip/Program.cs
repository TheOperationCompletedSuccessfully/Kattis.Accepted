using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace SummerTrip
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 17, 2 ^ 7);
            //Console.ReadKey();
            //var rand = new Random(DateTime.Now.Millisecond);
            var data = scanner.NextString(97).ToCharArray();//Enumerable.Range(0, 100000).Select(i => rand.Next(97, 122)).ToArray();
            var prevPositions = new int[26];
            var result = 0;
            for(int i=1;i<data.Length;i++)
            {
               var end = data[i];
               var index = end - 97;
               var hash = new HashSet<int>();
               for(int j=prevPositions[index];j<i;j++)
               {
                  if (data[j] != data[i])
                  {
                     hash.Add(data[j]);
                  }
               }
               result += hash.Count;
               prevPositions[index] = i;
            }

            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }
}
