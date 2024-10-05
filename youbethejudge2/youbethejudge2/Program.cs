using System;
using System.Collections.Generic;
using System.Linq;
using Zagrade;

namespace youbethejudge2
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(8388608, 256);

                var n = scanner.NextInt();
                var limit = Convert.ToInt32(Math.Pow(2, n));
                //var data = new List<FieldItem>();
                var k = Convert.ToInt64((Math.Pow(4, n) - 1) / 3);
                var finalCheck = new Dictionary<int, List<Tuple<int,int>>>();
                var statistics = new int[k+1];
                bool finish = false;
                for(int i=0; i< limit&&!finish; i++)
                    for(int j=0;j< limit&&!finish; j++)
                    {
                        var itemValue = j==0 ? scanner.NextInt(true) : scanner.NextInt();
                        //var item = new FieldItem { Column = j, Row = i, Value = itemValue };
                        if (itemValue > k + 1)
                        {
                            Console.WriteLine(0);
                            finish = true;
                        }
                        else
                        {
                            statistics[itemValue]++;
                            if (statistics[itemValue] > 3 || itemValue == 0 && statistics[itemValue] > 1)
                            {
                                Console.WriteLine(0);
                                finish = true;
                            }
                            else
                            {
                                if(statistics[itemValue]==1)
                                {
                                    finalCheck.Add(itemValue, new List<Tuple<int, int>> { new Tuple<int, int>(j, i) });
                                }
                                else
                                {
                                    finalCheck[itemValue].Add(new Tuple<int, int>(j, i));
                                }

                                if(finalCheck[itemValue].Select(x=>x.Item1).Max()- finalCheck[itemValue].Select(x => x.Item1).Min()>1
                                    || finalCheck[itemValue].Select(x => x.Item2).Max() - finalCheck[itemValue].Select(x => x.Item2).Min() > 1)
                                {
                                    Console.WriteLine(0);
                                    finish = true;
                                }
                            }
                        }
                    }

                if(!finish)
                {
                    Console.WriteLine(1);
                }
            }
            //Console.ReadKey();
        }
    }
}
