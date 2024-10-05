using System;
using System.Collections.Generic;
using System.Linq;
using Zagrade;

namespace ShoppingListEasy
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(8192, 512);

                var n = scanner.NextInt();
                var m = scanner.NextInt();
                var result = new string[m];
                var counts = new int[m];
                var survived = new HashSet<string>();
                var survived2 = new HashSet<string>();
                for (int i = 0; i < n; i++)
                {
                    Math.DivRem(i, 2, out int rem);
                    var toCheck = rem == 0 ? survived2 : survived;
                    var toChange = rem == 0 ? survived : survived2;
                    toChange.Clear();
                    for (int j = 0; j < m; j++)
                    {
                        if (i == 0)
                        {
                            result[j] = scanner.NextString(97);
                        }
                        else
                        {
                            var item = scanner.NextString(97);
                            if(toCheck.Contains(item))
                            {
                                toChange.Add(item);
                            }
                        }
                    }
                    if(i==0)
                    {
                        survived = result.ToHashSet();
                    }
                }
                Math.DivRem(n, 2, out int remm);
                var finalResult = (remm == 0 ? survived2 : survived).OrderBy(i => i).ToList(); ;
                scanner.streamWriter.WriteLine(finalResult.Count);
                scanner.streamWriter.WriteLine(string.Join(Environment.NewLine, finalResult));
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }
    }
}
