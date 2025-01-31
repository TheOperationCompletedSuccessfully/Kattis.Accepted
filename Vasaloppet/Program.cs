using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Vasaloppet
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 22, 2 ^ 7);
            var n = scanner.NextUInt();
            var t = scanner.NextUInt();
            var s = scanner.NextUInt();

           Span<Interval> intervals = stackalloc Interval[n];

            int l = 0;
            int r = 0;
            int advSum = 0;
            for (int i = 0; i < n; i++)
            {
                l = scanner.NextUInt(true);
                r = scanner.NextUInt();
                
                var newInterval = new Interval { StartTime= l, EndTime = t, EndAdvTime = r };

                intervals[i] = newInterval;
                if(i>0)
                {
                    intervals[i - 1].EndTime = l;
                }
                if (r - l >= s)
                {
                    scanner.streamWriter.WriteLine("0");
                    scanner.streamWriter.Flush();
                    return;
                }
                advSum += r - l;
            }


            if (n == 0)
            {
                scanner.streamWriter.WriteLine(s);
                scanner.streamWriter.Flush();
                return;
            }

            if (s == t)
            {
                scanner.streamWriter.WriteLine(s - advSum);
                scanner.streamWriter.Flush();
                return;
            }

            //idea is to make array of blocks [{adv time, show time}]
            //and use 2 pointers to calc

            int startIndex = 0;
            int endIndex = 0;
            int sumTime = intervals[endIndex].TotalDuration;
            int advDuration = intervals[endIndex].AdvDuration;
            int result = intervals[endIndex].AdvDuration;
            while (endIndex<=n-1&&startIndex<=endIndex)
            {
                while(endIndex<n-1 && sumTime < s)
                {
                    endIndex++;
                    sumTime += intervals[endIndex].TotalDuration;
                    advDuration += intervals[endIndex].AdvDuration;
                }

                var diff = Math.Max(0,sumTime - s);
                var affectedAdvDuration = Math.Max(0, diff - intervals[endIndex].ShowTime);
                result = Math.Max(result, advDuration - affectedAdvDuration);

                sumTime -= intervals[startIndex].TotalDuration;
                advDuration -= intervals[startIndex].AdvDuration;
                startIndex++;
                if(endIndex <startIndex && endIndex<n-1)
                {
                    endIndex++;
                    sumTime += intervals[endIndex].TotalDuration;
                    advDuration += intervals[endIndex].AdvDuration;
                }
            }

            scanner.streamWriter.WriteLine(s-result);
            scanner.streamWriter.Flush();
        }

        public struct Interval
        {
            public int StartTime { get; set; }
            public int EndTime { get; set; }
            public int EndAdvTime { get; set; }
            public readonly int TotalDuration => EndTime - StartTime;
            public readonly int AdvDuration => EndAdvTime - StartTime;
            public readonly int ShowTime => TotalDuration - AdvDuration;
        }
    }
}
