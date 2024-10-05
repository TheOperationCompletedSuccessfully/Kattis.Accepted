using System;
using System.Collections.Generic;
using Zagrade;

namespace Recount
{
    class Program
    {
        static void Main(string[] args)
        {
            bool found = false;
            var votes = new Dictionary<int, int>();

            int top = 0;
            int[] second = new int[2];
            string topValue = string.Empty;
            string[] secondValue = new string[2];
            int i = 0;
            var secondIndex = 0;
            using (var scanner = new ZevaScanner())
            {
                scanner.Initialize(1048576, 128);
                
                while (!found)
                {
                    var candidate = scanner.NextString(32);
                    if (candidate == "***")
                    {
                        found = true;
                        continue;
                    }
                    if (Math.Min(second[secondIndex], second[1 - secondIndex]) + 100000 - i < top)
                    {
                        found = true;
                        continue;
                    }
                    var candidateKey = candidate.GetHashCode();
                    if (!votes.ContainsKey(candidateKey) && 100000 - i < i)
                    {
                        i++;
                        continue;
                    }
                    else if (!votes.ContainsKey(candidateKey))
                    {
                        votes.Add(candidateKey, 1);
                        i++;
                        if (top < 1)
                        {
                            top = 1;
                            topValue = candidate;
                        }
                        else if (second[secondIndex] < 1)
                        {
                            second[secondIndex] = 1;
                            secondValue[secondIndex] = candidate;
                            secondIndex = 1 - secondIndex;
                        }
                        continue;
                    }

                    if (votes[candidateKey] + 100000 - i < top)
                    {
                        votes.Remove(candidateKey);
                        i++;
                        if (votes.Keys.Count == 1) found = true;
                    }
                    else
                    {
                        votes[candidateKey]++;
                        i++;
                        if (top < votes[candidateKey])
                        {
                            second[secondIndex] = top;
                            secondValue[secondIndex] = topValue;
                            top = votes[candidateKey];
                            topValue = candidate;
                            secondIndex = 1 - secondIndex;
                        }
                        else if (second[secondIndex] <= votes[candidateKey])
                        {
                            second[secondIndex] = votes[candidateKey];
                            secondValue[secondIndex] = candidate;
                            secondIndex = 1 - secondIndex;
                        }
                        continue;
                    }

                }
            }
            Console.Write(top == Math.Max(second[0], second[1]) ? "Runoff!" : topValue);
            //Console.ReadKey();
        }
    }
}