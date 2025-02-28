using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;


namespace Nafnatalning
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 23, 2 ^ 7);

            var n = scanner.NextUInt();
            var p = scanner.NextUInt();

            var precalculated = new Dictionary<int, long>();
            long sum = 0;
            long combSum = 0;
            for(int i=0;i<n; i++) 
            {
                var next = scanner.NextUInt(i==0);
                sum += next;
                combSum += Comb(next, 2);
            }
            var totalComb = Comb(sum, 2);
            var result = (long)Math.Ceiling((totalComb - combSum) / (double)p);
            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
        }

        public static long Comb(long n, int k)
        {
            if (k > n)
                return 0;
            if (k == n)
                return 1;
            if (k == 1)
                return n;
            var result = n * (n - 1)/2;
            return result;
        }

    }
}