using System;
using Zeva;

namespace SnakesAndMasters
{
    class Program
    {
        public static int[] cached;
        
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 7, 2 ^ 7);

                var n = scanner.NextUInt();
                cached = new int[n+2];
                Math.DivRem(CountSum(1, n) + CountSum(2, n),1000000,out int result);

                scanner.streamWriter.WriteLine(result);
                scanner.streamWriter.Flush();
            }
        }

        public static int CountSum(int current,int target)
        {
            if(current>target)
            {
                return 0;
            }

            if(current==target)
            {
                return 1;
            }
            int result1;
            if (cached[current+1] == 0)
            {
                result1 = CountSum(current + 1, target);
                cached[current+1] = result1;
            }
            else
            {
                result1 = cached[current+1];
            }

            int result2;
            if (cached[current + 2] == 0)
            {
                result2 = CountSum(current + 2, target);
                cached[current + 2] = result2;
            }
            else
            {
                result2 = cached[current + 2];
            }

            Math.DivRem(result1 + result2,1000000,out int result);
            return result;
        }
    }
}
