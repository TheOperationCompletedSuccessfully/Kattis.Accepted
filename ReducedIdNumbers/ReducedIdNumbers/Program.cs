using System;
using System.Collections.Generic;
using Zeva;

namespace ReducedIdNumbers
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 11, 2 ^ 7);

                var n = scanner.NextUInt();
                var data = new int[n];
                var remnants = new HashSet<int>();
                for(int i=0;i<n;i++)
                {
                    var item = scanner.NextUInt(true);
                    data[i] = item;
                }
                int j = 0;
                int div = n;
                while(j<n)
                {
                    if(data[j]<n)
                    {
                        if(remnants.Contains(data[j]))
                        {
                            remnants.Clear();
                            j = 0;
                            div++;
                            continue;
                        }
                        remnants.Add(data[j]);
                    }
                    else
                    {
                        Math.DivRem(data[j], div, out int remt);
                        if (remnants.Contains(remt))
                        {
                            remnants.Clear();
                            j = 0;
                            div++;
                            continue;
                        }
                        remnants.Add(remt);
                    }
                    j++;
                }

                scanner.streamWriter.WriteLine(div);
                scanner.streamWriter.Flush();
            }
        }
    }
}
