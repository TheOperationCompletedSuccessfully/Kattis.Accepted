using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace ExoplanetLightHouse
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 14, 2 ^ 8);

            var t = scanner.NextUInt();
            for (int i = 0; i < t; i++)
            {
                var r = scanner.NextUDouble(true);
                var h1 = scanner.NextUDouble();
                var h2 = scanner.NextUDouble();
                var hh1 = h1 / 1000;
                var hh2 = h2 / 1000;
                var hip1 = r + hh1;
                var hip2 = r + hh2;
                var alpha1 = Math.Acos(r / hip1);
                var alpha2 = Math.Acos(r / hip2);
                var alpha = alpha1 + alpha2;
                var result = alpha * r;
                scanner.streamWriter.WriteLine(result);
            }
            scanner.streamWriter.Flush();
        }
    }
}