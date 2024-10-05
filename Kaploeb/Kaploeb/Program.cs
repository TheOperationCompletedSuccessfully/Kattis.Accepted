using System;
using System.Collections.Generic;
using System.Linq;
using Zagrade;

namespace Kaploeb
{
    //Running Race
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2097152, 2097152);

                var l = scanner.NextInt();
                var k = scanner.NextInt();
                var s = scanner.NextInt();

                var finishedRunners = new List<int>();
                var times = new Dictionary<int, int>();
                var registeredFinishes = new Dictionary<int, int>();
                for(int i=0;i<l;i++)
                {
                    var runner = scanner.NextInt(true);
                    var runnerMinutes = scanner.NextInt();
                    var runnerSeconds = scanner.NextInt();

                    if(!times.ContainsKey(runner))
                    {
                        if (runner <= s)
                        {
                            times.Add(runner, 60 * runnerMinutes + runnerSeconds);
                            registeredFinishes.Add(runner, 1);
                            if (registeredFinishes[runner] == k)
                            {
                                finishedRunners.Add(runner);
                            }
                        }
                    }
                    else
                    {
                        registeredFinishes[runner]++;
                        if(registeredFinishes[runner]==k)
                        {
                            times[runner] += 60 * runnerMinutes + runnerSeconds;
                            finishedRunners.Add(runner);
                        }

                        if(registeredFinishes[runner] < k)
                        {
                            times[runner] += 60 * runnerMinutes + runnerSeconds;
                        }
                    }
                }

                var result = finishedRunners.OrderBy(runner => times[runner]).ThenBy(runner => runner);

                scanner.streamWriter.Write(string.Join(Environment.NewLine, result));
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }
    }
}
