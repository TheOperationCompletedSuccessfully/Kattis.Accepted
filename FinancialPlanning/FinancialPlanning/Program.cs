using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace FinancialPlanning
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 21, 2 ^ 7);
                var n = scanner.NextUInt();
                var m = scanner.NextUInt();
                var options = new List<InvestmentOption>();
                var chosenDays = new HashSet<int>();
                var latestDay = Int32.MaxValue;
                var minProfitDay = Int32.MaxValue;
                var maxProfitDay = 0;
                //var random = new Random(DateTime.Now.Millisecond);
                for (int i=0;i<n;i++)
                {
                    var profit = scanner.NextUInt(true); //random.Next(1, 5);
                    var initialCost = scanner.NextUInt(); //random.Next(100,100000000);
                    int firstDayOfProfit = 0;
                    int firstProfit = profit - initialCost;
                    if (profit<=initialCost)
                    {
                        firstDayOfProfit = Math.DivRem(initialCost, profit, out int remC);
                        firstProfit = profit-remC;
                    }
                    minProfitDay = Math.Min(minProfitDay, firstDayOfProfit);
                    //throwing away the crazy options
                    if (latestDay > firstDayOfProfit)
                    {
                        var item = new InvestmentOption { Profit = profit, InitialCost = initialCost, FirstDayOfProfit = firstDayOfProfit, FirstProfit = firstProfit };
                        options.Add(item);
                        latestDay = Math.Min(latestDay, firstDayOfProfit + m / profit);
                        maxProfitDay = Math.Max(maxProfitDay, firstDayOfProfit);
                        chosenDays.Add(firstDayOfProfit);
                    }
                    
                }

                var ordered = options.OrderBy(o => o.FirstDayOfProfit).ToArray();
                var orderedDays = chosenDays.OrderBy(d => d).ToArray();
                var accrued = 0;
                //int index = 0;
                int dayProfit = 0;
                var result = minProfitDay;
                int previousDay = minProfitDay;
                int innerIndex = 0;
                for(int index = 0;index<orderedDays.Length;index++)
                {
                    var day = orderedDays[index];
                    if(accrued+ dayProfit * (day - previousDay)>m)
                    {
                        break;
                    }
                    accrued += dayProfit*(day-previousDay);
                    while(innerIndex<ordered.Length&& ordered[innerIndex].FirstDayOfProfit == day)
                    {
                        accrued += ordered[innerIndex].FirstProfit;
                        dayProfit += ordered[innerIndex].Profit;
                        innerIndex++;
                    }
                    result = day;
                    previousDay = day;
                }

                if (accrued<m)
                {
                    var additionalDays = Math.DivRem(m - accrued, dayProfit, out int rem);
                    result += additionalDays + (rem > 0 ? 1 : 0);
                }
                //day counts from 1
                scanner.streamWriter.WriteLine(result+1);
                scanner.streamWriter.Flush();
            }
        }
    }

    public class InvestmentOption
    {
        public int Profit { get; set; }
        public int InitialCost { get; set; }

        public int FirstDayOfProfit { get; set; }

        public int FirstProfit { get; set; }
    }
}
