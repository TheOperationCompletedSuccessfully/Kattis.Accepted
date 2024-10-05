using System.Collections.Generic;
using Zeva;

namespace Pivot
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 17, 2 ^ 7);
                var n = scanner.NextUInt();
                var next = scanner.NextInt(true);
                var max = next;
                var solution = new Stack<int>();
                solution.Push(next);
                for (int i=1;i<n;i++)
                {
                    next = scanner.NextInt();
                    var current = max;
                    if(max > next)
                    {
                        while(current > next && solution.Count>0)
                        {
                            current = solution.Pop();
                        }
                        if (current < next)
                        {
                            solution.Push(current);
                        }
                    }
                    else
                    {
                        solution.Push(next);
                        max = next;
                    }
                }

                scanner.streamWriter.WriteLine(solution.Count);
                scanner.streamWriter.Flush();
            }
        }
    }
}
