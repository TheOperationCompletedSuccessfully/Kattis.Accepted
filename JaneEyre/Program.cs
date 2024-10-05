using System;
using Zeva;

namespace JaneEyre
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 23, 2 ^ 7);
            var janeEyre = "\"Jane Eyre\"";
            var n = scanner.NextUInt();
            var m = scanner.NextUInt();
            var k = scanner.NextUInt();
            long result = 0;
            for(int i = 0; i<n;i++)
            {
               var name = scanner.NextQuotedString();
               var pages = scanner.NextUInt(true);
               if(string.CompareOrdinal(janeEyre,name)>0)
               {
                  result += pages;
               }
            }
            var books = new MinLongHeap<Book>();
            for(int i=0;i<m;i++)
            {
               var time = scanner.NextUInt(true);
               var name = scanner.NextQuotedString();
               var pages = scanner.NextUInt(true);
               if (string.CompareOrdinal(janeEyre, name) > 0)
               {
                  var nextBook = new Book { Name = name, Time = time, Pages = pages };
                  books.Push(nextBook);
               }
            }
            if(m==0)
            {
               scanner.streamWriter.WriteLine(result+k);
               scanner.streamWriter.Flush();
               return;
            }

            if (books.Count > 0)
            {
               var book = books.Pop();
               while (result >= book.Time && books.Count > 0)
               {
                  result += book.Pages;
                  if (books.Count > 0)
                  {
                     book = books.Pop();
                  }
               }
               if (result >= book.Time)
               {
                  result += book.Pages;
               }
            }

            scanner.streamWriter.WriteLine(result + k);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }

   class Book : IGetLongValue<Book>
   {
      public long Time { get; set; }

      public string Name { get; set; }

      public long Pages { get; set; }

      public long GetValue(Book item) => item.Time;
      
   }
}
