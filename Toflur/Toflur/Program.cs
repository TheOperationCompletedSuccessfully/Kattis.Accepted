using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Toflur
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 22, 2 ^ 7);

                var n = scanner.NextUInt();
                
                if(n<=2500)
                {
                    //merge sort
                    var dataHash = new HashSet<int>();
                    dataHash.Add(scanner.NextUInt(true));
                    for(int i=1;i<n;i++)
                    {
                        dataHash.Add(scanner.NextUInt());
                    }
                    var data = dataHash.ToArray();
                    var sorted = MergeSort(data, 0, data.Length - 1);
                    var result = 0L;
                    for(int i=1;i< sorted.Length;i++)
                    {
                        result += ((long)sorted[i] - sorted[i - 1]) * (sorted[i] - sorted[i - 1]);
                    }
                    scanner.streamWriter.WriteLine(result);

                }
                else
                {
                    //counting sort
                    //var random = new Random(DateTime.Now.Millisecond);
                    var buckets = Enumerable.Range(1, 1000).ToHashSet();
                    var dataHash = new HashSet<int>();
                    var item = scanner.NextUInt(true);//random.Next(1, 1000);
                    var min = item;
                    var max = item;
                    dataHash.Add(item);
                    buckets.Remove(item / 1000);
                    for (int i = 1; i < n; i++)
                    {
                        item = scanner.NextUInt();//random.Next(99999, 120000);
                        dataHash.Add(item);
                        max = Math.Max(max, item);
                        min = Math.Min(min, item);
                        buckets.Remove(item / 1000);
                    }
                    if((max - min)/dataHash.Count > 10)
                    {
                        //remove buckets
                        var toSkip = buckets.Where(i => (i - 1) * 1000 > min && (i * 1000 < max)).ToHashSet();
                        dataHash.TryGetValue(min,out int previousItem);
                        var resultSum = 0L;
                        for(int i=min+1;i<=max;i=i+Math.Max(1, GetIndex(i, toSkip)))
                        {
                            if(dataHash.TryGetValue(i, out int nextItem))
                            {
                                resultSum += ((long)nextItem - previousItem) * (nextItem - previousItem);
                                previousItem = nextItem;
                            }
                        }
                        scanner.streamWriter.WriteLine(resultSum);
                    }
                    else
                    {
                        var sum = 0L;
                        dataHash.TryGetValue(min, out int previousItem);
                        for (int i = min + 1; i <= max; i++)
                        {
                            if (dataHash.TryGetValue(i, out int nextItem))
                            {
                                sum += ((long)nextItem - previousItem) * (nextItem - previousItem);
                                previousItem = nextItem;
                            }
                        }
                        scanner.streamWriter.WriteLine(sum);
                    }
                }
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }

        private static int GetIndex(int i, HashSet<int> buckets)
        {
            var result = 0;
            var ii = i;
            while (buckets.Contains(ii))
            {
                result += 10000;
                ii++;
            }
            return result;
        }

        public static int[] MergeSort(int[] data, int start, int end)
        {
            if (start == end)
            {
                return data.Skip(start).Take(1).ToArray();
            }

            if (start == end - 1)
            {
                if (data[start] > data[end])
                {
                    Swap(data, start, end);

                }
                return data.Skip(start).Take(2).ToArray();

            }
            var middle = start + (end - start) / 2;
            var newData1 = MergeSort(data, start, middle);
            var newData2 = MergeSort(data, middle + 1, end);

            var result = Merge(newData1, newData2);
            return result;
        }

        public static int[] Merge(int[] data1, int[] data2)
        {
            var result = new int[data1.Length + data2.Length];

            var index1 = 0;
            var index2 = 0;
            var index = -1;
            while (index1 < data1.Length && index2 < data2.Length)
            {
                var item1 = data1[index1];
                var item2 = data2[index2];

                var itemToPush = Math.Min(item1, item2);
                result[++index] = itemToPush;
                if (item1 < item2)
                {
                    index1++;
                }
                else
                {
                    index2++;
                }
            }

            int indexToProceed = index1 < data1.Length ? index1 : index2;
            var dataToProceed = index1 < data1.Length ? data1 : data2;

            for (int j = indexToProceed; j < dataToProceed.Length; j++)
            {
                result[++index] = dataToProceed[j];
            }

            return result;
        }

        public static void Swap(int[] data, int i, int j)
        {
            var temp = data[i];
            data[i] = data[j];
            data[j] = temp;
        }
    }
}
