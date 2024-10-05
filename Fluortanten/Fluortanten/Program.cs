using System;
using System.Collections.Generic;
using System.Linq;
using Zagrade;

namespace Fluortanten
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(4194304,256);

                var n = scanner.NextInt();

                var preItems = new Stack<int>();
                var postItems = new List<int>();
                long currentSum = 0;
                bool bjornMet = false;
                int bjornPos = 0;
                bool firstPositiveMet = false;
                int lastnegative = -1;
                for(int i=0;i<n;i++)
                {
                    var nextItem = i==0 ? scanner.NextInt(true) : scanner.NextInt();
                    if(nextItem==0)
                    {
                        bjornMet = true;
                        bjornPos = i;
                    }
                    if(nextItem>0)
                    {
                        firstPositiveMet = true;
                    }
                    if(!bjornMet&&firstPositiveMet)
                    {
                        preItems.Push(nextItem);
                    }
                    else if (bjornMet&&nextItem!=0)
                    {
                        if (nextItem < 0)
                        { 
                            lastnegative = i; 
                        }
                        postItems.Add(nextItem);
                    }
                    currentSum += (i + 1) * nextItem;
                    //scanner.streamWriter.WriteLine(currentSum);
                }

                var bestChoice = currentSum;
                var current = currentSum;
                //scanner.streamWriter.WriteLine(bestChoice);
                while (preItems.TryPop(out int previous))
                {
                    current += previous;
                    bestChoice = Math.Max(current, bestChoice);
                }

                current = currentSum;
                //scanner.streamWriter.WriteLine(bestChoice);
                foreach (var item in lastnegative>0 ? postItems : postItems.Take(lastnegative-bjornPos-1))
                {
                    current -= item;
                    bestChoice = Math.Max(current, bestChoice);
                }

                scanner.streamWriter.WriteLine(bestChoice);
                scanner.streamWriter.Flush();
            }

            //Console.ReadKey();
        }
    }
}
