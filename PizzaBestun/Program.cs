using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace PizzaBestun
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner(2^19,2^7))
            {
                var totalPizzas = scanner.NextUInt();
                var pizzas = new int[totalPizzas];
                for(int i=0;i<totalPizzas; i++)
                {
                    var name = scanner.NextString(65);
                    var nextPrice = scanner.NextUInt();
                    pizzas[i] = nextPrice;
                }

                var ordered = pizzas.OrderByDescending(x=>x).ToArray();
                long answer = 0;
                for(int i=0; i<totalPizzas;i+=2)
                {
                    answer += ordered[i];
                }

                scanner.streamWriter.WriteLine(answer);
                scanner.streamWriter.Flush();
            }
        }
    }
}