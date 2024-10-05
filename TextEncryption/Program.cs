using System;
using System.Collections.Generic;
using Zeva;

namespace TextEncryption
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 21, 2 ^ 21);

            //var n = scanner.NextUInt();
            var step = scanner.NextUInt();
            do
            {

               var data = new int[10000];
               var nextChar = scanner.NextByte();
               int next = -1;
               do
               {
                  nextChar = nextChar > 96 ? nextChar - 32 : nextChar;
                  if (nextChar > 64)
                  {
                     data[++next] = nextChar;
                  }

                  nextChar = scanner.NextByte();
               }
               while (nextChar > 13);
               var length = next + 1;
               var cr = Math.DivRem(length, step, out int rem);
               var cycles = cr;
               var queues = new Queue<int>[step];
               int p = 0;
               int c = 0;
               //if (length >= step)
               //{
               for (int j = 0; j < length; j++)
               {
                  if (queues[c] == null)
                  {
                     queues[c] = new Queue<int>();
                  }
                  if (p < cycles)
                  {
                     queues[c].Enqueue(data[j]);
                     p++;
                  }
                  else
                  {
                     if (rem > 0)
                     {
                        queues[c].Enqueue(data[j]);
                        rem--;
                        if (step > 1)
                        {
                           p = 0;

                           c++;
                        }
                     }
                     else
                     {
                        if (step > 1)
                        {
                           c++;
                           if (queues[c] == null)
                           {
                              queues[c] = new Queue<int>();
                           }
                           queues[c].Enqueue(data[j]);
                           p = 1;
                        }
                        else
                        {
                           queues[c].Enqueue(data[j]);
                        }
                     }
                  }
               }
               for (int j = 0; j < length; j++)
               {
                  var index = Math.DivRem(j, step, out int rm);
                  char tp = new char();
                  //if (length > step)
                  //{
                     tp = (char)queues[rm].Dequeue();
                  //}
                  //else
                  //{
                  //   tp = (char)queues[0].Dequeue();
                  //}
                  scanner.streamWriter.Write(tp);
               }
               scanner.streamWriter.WriteLine();
               //}
               //else
               //{
               //   scanner.streamWriter.WriteLine("")
               //}

               step = scanner.NextUInt(true);
            }
            while (step > 0);
            scanner.streamWriter.Flush();

         }
         //Console.ReadKey();
      }
   }
}
