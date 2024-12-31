using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace BrowniePoints
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 19, 2 ^ 7);
            var n = scanner.NextUInt();
            
            var specialX = 0;
            var specialY = 0;
            Span<Data> data = stackalloc Data[10000];
            do{
                var index = n/2;
                var stanResult = 0;
                var ollieResult = 0;
                for(int i=0;i<n;i++)
                {
                    var nextX = scanner.NextInt(true);
                    var nextY = scanner.NextInt();
                    if(i==index)
                    {
                        specialX = nextX;
                        specialY = nextY;
                        continue;
                    }

                    if(i<index)
                    {
                        data[i] = new Data(nextX,nextY);
                        continue;
                    }

                    if(nextX>specialX&&nextY>specialY || nextX<specialX&&nextY<specialY)
                    {
                        stanResult++;
                        continue;
                    }

                    if(nextX!=specialX&&nextY!=specialY)
                    {
                        ollieResult++;
                        continue;
                    }
                }
                
                for(int i=0;i<index;i++)
                {
                    if(data[i].X>specialX&&data[i].Y>specialY || data[i].X<specialX&&data[i].Y<specialY)
                    {
                        stanResult++;
                        continue;
                    }

                    if(data[i].X!=specialX&&data[i].Y!=specialY)
                    {
                        ollieResult++;
                    }
                }

                scanner.streamWriter.Write(stanResult);
                scanner.streamWriter.Write(" ");
                scanner.streamWriter.WriteLine(ollieResult);

                n = scanner.NextUInt();
            }
            while(n>0);
        }
    }

    readonly struct Data(int x, int y)
    {
        public int X { get; } = x;
        public int Y { get; } = y;
    }
}