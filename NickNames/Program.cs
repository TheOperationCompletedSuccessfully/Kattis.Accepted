using System;
using System.Collections.Generic;
using Zeva;

namespace NickNames
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 34, 2 ^ 19);

            var a = scanner.NextUInt();
            var names = new HashSet<long>();
            var root = new NamesTri();
            var current = root;
            int lastCh;
            long cand = 0;
            for(int i=0; i<a; i++)
            {
               lastCh = scanner.NextByte(97, 122);
               do
               {
                  if (current.Children.ContainsKey(lastCh))
                  {
                     current = current.Children[lastCh];
                  }
                  else
                  {
                     var newItem = new NamesTri() { Parent = current, Value = lastCh };
                     current.Children.Add(lastCh, newItem);
                     current = newItem;
                  }
                  current.CardinalValue++;

                  //cand = cand * 10 + (lastCh - 64);
                  
                  lastCh = scanner.NextByte(10, 122);
               }
               while (lastCh > 96);
               current = root;
               //names.Add(cand);
            }
            //var nickNames = new Dictionary<int, int>();
            var b = scanner.NextUInt(true);
            var found = true;
            
            
            for (int i = 0; i < b; i++)
            {
               lastCh = scanner.NextByte(97, 122);
               var result = 0;
               do
               {
                  if(current.Children.ContainsKey(lastCh) && found)
                  {
                     current = current.Children[lastCh];
                     result = current.CardinalValue;
                  }
                  else
                  {
                     found = false;
                     result = 0;
                  }
                  //cand = cand * 10 + (lastCh - 64);
                  lastCh = scanner.NextByte(10, 122);
               }
               while (lastCh > 96);
               current = root;
               found = true;
               scanner.streamWriter.WriteLine(result);
            }
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }

      public class NamesTri
      {
         public NamesTri Parent { get; set; }
         public Dictionary<int, NamesTri> Children = new Dictionary<int, NamesTri>();

         public long Value { get; set; }

         public int CardinalValue { get; set; }
      }
   }
}
