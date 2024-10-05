using System;
using System.Collections.Generic;
using System.Linq;
using Zagrade;

namespace SavingUniverse
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner())
            {
                scanner.Initialize(2200000,512);

                var cases = scanner.NextUInt();
                for(int i=0;i<cases;i++)
                {
                    var searchEngineNumber = scanner.NextUInt(true);
                    var searchEngines = new string[searchEngineNumber];

                    for(int j=0;j<searchEngineNumber;j++)
                    {
                        var searchEngineName = scanner.NextString(' ');
                        searchEngines[j] = searchEngineName;

                    }

                    var queryNumber = scanner.NextUInt(true);
                    int switchNumber = 0;
                    var chosen = new HashSet<string>();
                    int k = 0;
                    var lastChoice = string.Empty;
                    while(k<queryNumber)
                    {
                        if(chosen.Count< searchEngineNumber)
                        {
                            var nextQuery = scanner.NextString(' ');
                            lastChoice = nextQuery;
                            chosen.Add(nextQuery);
                            k++;
                        }
                        else
                        {
                            switchNumber++;
                            chosen.Clear();
                            chosen.Add(lastChoice);
                        }
                    }
                    if (chosen.Count == searchEngineNumber)
                    {
                        switchNumber++;
                    }
                        scanner.streamWriter.WriteLine($"Case #{i + 1}: {switchNumber}");
                }
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }
    }
}
