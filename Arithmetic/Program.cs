using System;
using System.Collections.Generic;
using Zeva;

namespace Arithmetic
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 18, 2 ^ 18);

            int counter = 0;
            int next = 0;
            var queue = new Queue<int>();
            while(scanner.streamReader.Peek()>47)
            {
               queue.Enqueue(scanner.streamReader.Read() - 48);

            }
            Math.DivRem(queue.Count, 4, out int firstChunk);
            if (firstChunk > 0)
            {
               for (int i = 0; i < firstChunk; i++)
               {
                  next = next * 8 + queue.Dequeue();
               }
               var data = Convert.ToString(next, toBase: 16).ToUpper();
               scanner.streamWriter.Write(data);
            }
            counter = 0;
            next = 0;
            while(queue.Count>0)
            {
               next = next * 8 + queue.Dequeue();
               counter++;
               if (counter == 4)
               {
                  var data = Convert.ToString(next, toBase: 16).ToUpper();
                  if (data.Length < 3)
                  {
                     data = data.PadLeft(3, '0');
                  }
                  scanner.streamWriter.Write(data);
                  counter = 0;
                  next = 0;
               }
            }

            scanner.streamWriter.WriteLine();

            scanner.streamWriter.Flush();

         }
         //Console.ReadKey();
      }
   }
}
