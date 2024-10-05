using System;
using System.Collections.Generic;
using System.Linq;
using Zagrade;

namespace CheatingStudents
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner())
            {
                scanner.Initialize(32768, 256);

                var n = scanner.NextInt();
                var students = new Tuple<int, int>[n];
                for(int i=0; i<n;i++)
                {
                    var x = scanner.NextInt(true);
                    var y = scanner.NextInt();
                    students[i] = new Tuple<int, int>(x, y);

                }
                if(n==1)
                {
                    Console.WriteLine(0);
                }

                if(n==2)
                {
                    Console.WriteLine(2*(Math.Abs(students[0].Item1 - students[1].Item1) + Math.Abs(students[0].Item2 - students[1].Item2)));
                }

                if (n > 2)
                {
                    var options = new List<Tuple<int, int, int>>();
                    var usedOptions = new HashSet<int>();
                    for (int i = 0; i < n; i++)
                        for (int j = i + 1; j < n; j++)
                        {
                            options.Add(new Tuple<int, int, int>(i, j, Math.Abs(students[i].Item1 - students[j].Item1) + Math.Abs(students[i].Item2 - students[j].Item2)));
                        }
                    var orderedOptions = options.OrderBy(item => item.Item3).ToArray();
                    var result = 0;
                    int index = 0;
                    while (usedOptions.Count < n)
                    {
                        if (usedOptions.Count == 0)
                        {
                            result += orderedOptions[index].Item3;
                            usedOptions.Add(orderedOptions[index].Item1);
                            usedOptions.Add(orderedOptions[index].Item2);
                        }
                        else
                        {
                            if (usedOptions.Contains(orderedOptions[index].Item1) && !usedOptions.Contains(orderedOptions[index].Item2)
                                ||
                                !usedOptions.Contains(orderedOptions[index].Item1) && usedOptions.Contains(orderedOptions[index].Item2))
                            {
                                result += orderedOptions[index].Item3;
                                usedOptions.Add(orderedOptions[index].Item1);
                                usedOptions.Add(orderedOptions[index].Item2);
                                index = 0;
                            }
                        }
                        index++;
                    }

                    Console.WriteLine(2*result);
                }

                //Console.ReadKey();
            }
         }

    }
}
