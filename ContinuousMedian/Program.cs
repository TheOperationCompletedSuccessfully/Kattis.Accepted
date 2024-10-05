using System;
using System.Collections.Generic;
using Zeva;

namespace ContinuousMedian
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 22, 2 ^ 7))
            {
                var t = scanner.NextUInt();

                for (int caseNumber = 0; caseNumber < t; caseNumber++)
                {
                    int middleNew = -1;
                    var startHeapNew = new PriorityQueue<Number, int>();
                    var endHeapNew = new PriorityQueue<Number, int>();
                    long resultNew = 0;
                    var n = scanner.NextUInt(true);
                    int minValue = Int32.MaxValue;
                    int maxValue = 0;
                    for (int i = 0; i < n; i++)
                    {
                        int next = i == 0 ? scanner.NextUInt(true) : scanner.NextUInt();
                        ProcessValueNew(next, n, i, startHeapNew, endHeapNew, ref middleNew, ref minValue, ref maxValue, ref resultNew, scanner);
                    }
                    scanner.streamWriter.WriteLine(resultNew);
                }
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }

        public static void ProcessValueNew(int next, int n, int i, PriorityQueue<Number, int> startHeap, PriorityQueue<Number, int> endHeap, ref int middle, ref int minValue, ref int maxValue, ref long result, ZevaScanner scanner)
        {
            var leftToProcess = n - i;

            var nextNumber = new Number() { Value = next };
            if (i == 0)
            {
                middle = next;
                result += middle;
                NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
                return;
            }

            if (i == 1)
            {
                result += (middle + next) / 2;
                var maxElement = new Number() { Value = Math.Max(middle, next) };
                var minElement = new Number() { Value = Math.Min(middle, next) };
                startHeap.Enqueue(minElement,minElement.MaxPriority);
                endHeap.Enqueue(maxElement, maxElement.MinPriority);
                middle = -1;
                NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
                return;
            }
            var left = startHeap.Peek();
            var right = endHeap.Peek();
            if (middle == -1 && next < left.Value)
            {
                middle = startHeap.Dequeue().Value;
                if (!(next <= minValue && leftToProcess < startHeap.Count))
                {
                    startHeap.Enqueue(nextNumber, nextNumber.MaxPriority);
                }
                result += middle;
                NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
                return;
            }

            if (middle == -1 && next >= left.Value && next <= right.Value)
            {
                middle = next;
                result += middle;
                NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
                return;
            }

            if (middle == -1 && next > right.Value)
            {
                middle = endHeap.Dequeue().Value;
                if (!(next >= maxValue && leftToProcess < endHeap.Count))
                {
                    endHeap.Enqueue(nextNumber, nextNumber.MinPriority);
                }

                result += middle;
                NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
                return;
            }

            if (next < left.Value)
            {
                result += (middle + left.Value) / 2;
                var newValue1 = new Number() { Value = middle };
                endHeap.Enqueue(newValue1, newValue1.MinPriority);
                middle = -1;

                if (!(next <= minValue && leftToProcess < startHeap.Count))
                {
                    startHeap.Enqueue(nextNumber, nextNumber.MaxPriority);
                }
                NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
                return;
            }

            if (next >= left.Value && next <= right.Value)
            {
                result += (next + middle) / 2;
                if (next <= middle)
                {
                    startHeap.Enqueue(nextNumber, nextNumber.MaxPriority);
                    var newValue2 = new Number() { Value = middle };
                    endHeap.Enqueue(newValue2, newValue2.MinPriority);
                }
                else
                {
                    endHeap.Enqueue(nextNumber, nextNumber.MinPriority);
                    var newValue3 = new Number() { Value = middle };
                    startHeap.Enqueue(newValue3, newValue3.MaxPriority);
                }
                middle = -1;
                NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
                return;
            }

            //next > right && middle <> -1
            result += (middle + right.Value) / 2;
            var newValue = new Number() { Value = middle };
            startHeap.Enqueue(newValue, newValue.MaxPriority);
            middle = -1;
            if (!(next >= maxValue && leftToProcess < endHeap.Count))
            {
                endHeap.Enqueue(nextNumber, nextNumber.MinPriority);
            }
            NewMMsIfNeeded(i, n, next, ref minValue, ref maxValue, startHeap, endHeap);
        }

        public static void NewMMsIfNeeded(int i, int n, int next, ref int minValue, ref int maxValue, PriorityQueue<Number, int> startHeap, PriorityQueue<Number, int> endHeap)
        {
            //if (i > 4 * n / 5)
            //{
            //    minValue = ((Number)startHeap[startHeap.Count / 2]).Value;
            //    maxValue = ((Number)endHeap[endHeap.Count / 2]).Value;
            //    return;
            //}


            if (i < 2 * n / 3)
            {
                minValue = Math.Min(next, minValue);
                maxValue = Math.Max(next, maxValue);
            }
        }
    }

    class Number
    {
        public int Value { get; set; }

        public int GetValue(Number item) => item.Value;

        public int MaxPriority => Int32.MaxValue - Value;

        public int MinPriority => Value;

    }
}