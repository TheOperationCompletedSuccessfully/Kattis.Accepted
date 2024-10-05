using System;
using Zeva;

namespace SupportVectorMachine
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 22, 2 ^ 14);

            var n = scanner.NextUInt();
            var w = new double[n];
            double wSum = 0;
            //var random = new Random(DateTime.Now.Millisecond);
            for(int i=0;i<n;i++)
            {
               double next = scanner.NextDouble(i==0);
               w[i] = next;
               wSum += next * next;
            }
            double b = scanner.NextDouble();
            //var knownAnswers = new Dictionary<double,double>();
            while (!scanner.streamReader.EndOfStream)
            {
               var x = new double[n];
               double xSum = 0;
               for(int i=0;i<n;i++)
               {
                  double next = scanner.NextDouble(i==0);
                  x[i] = next;
                  //File.AppendAllLines(@"C:\Temp\Result.txt", new string[] { next.ToString() });
                  xSum += next * w[i];
               }
               xSum+= b;
               var result = xSum / Math.Sqrt(wSum);
               scanner.streamWriter.WriteLine(result);
               //File.AppendAllLines(@"C:\Temp\Result.txt", new string[] { result.ToString() });
            }
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }
}
