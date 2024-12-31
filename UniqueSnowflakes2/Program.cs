using System;
using System.Collections;
using System.Collections.Generic;
using Zeva;

namespace Snowflakes
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 20, 2 ^ 8))
            {
                var caseNumber = scanner.NextUInt();
                for (int i = 0; i < caseNumber; i++)
                {
                    var snowflakesNumber = scanner.NextUInt(true);
                    var indexes = new Dictionary<long, int>();
                    var indexLengthes = new Dictionary<int, int>();
                    var data = new int[snowflakesNumber];
                    var package = new HashSet<int>();
                    int oldLength = 0;
                    int bestLength = 0;
                    bool tooShort = false;
                    var firstInTheRowIndex = 0;
                    for (int j = 0; j < snowflakesNumber; j++)
                    {
                        var snowflake = scanner.NextUInt(true);
                        if (!tooShort)
                        {
                            data[j] = snowflake;

                            if (package.Count == 0)
                            {
                                firstInTheRowIndex = j;
                            }
                            if (!indexLengthes.ContainsKey(snowflake))
                            {
                                indexLengthes.Add(snowflake, 0);
                            }
                            var snowflakeKey = 10000000000 * indexLengthes[snowflake] + snowflake;
                            indexes[snowflakeKey] = j;
                            indexLengthes[snowflake] = indexLengthes[snowflake] + 1;
                            package.Add(snowflake);
                            if (oldLength == package.Count)
                            {
                                bestLength = Math.Max(oldLength, bestLength);


                                for (int k = firstInTheRowIndex; k <= indexes[snowflakeKey - 10000000000]; k++)
                                {
                                    package.Remove(data[k]);
                                }
                                firstInTheRowIndex = indexes[snowflakeKey - 10000000000] + 1;
                                package.Add(snowflake);
                                if (bestLength - package.Count >= snowflakesNumber - j)
                                {
                                    tooShort = true;
                                }
                            }
                            oldLength = package.Count;
                        }
                    }
                    bestLength = Math.Max(bestLength, oldLength);
                    scanner.streamWriter.WriteLine(bestLength);
                }
                scanner.streamWriter.Flush();
            }
        }
    }
}