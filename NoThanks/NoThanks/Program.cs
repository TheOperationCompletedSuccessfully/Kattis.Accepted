using System;
using System.Linq;
using Zagrade;

namespace NoThanks
{
    class Program
    {
        static void Main(string[] args)
        {
            var data = new int[90001];
            using(var scanner = new ZScanner())
            {
                scanner.Initialize();
                var n = scanner.NextUInt(true);
                for(int i=1; i<=n;i++)
                {
                    var card = scanner.NextUInt(true);
                    data[card] = card;
                }

                var result = data.Where((i, j) => i > 0 && data[j - 1] == 0).Sum();
                scanner.streamWriter.WriteLine(result);
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }
    }
}
