using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace PurpleRain
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 17, 2 ^ 7);
            int Index = 0;

            var item = scanner.streamReader.Read();
            var prevItem = item;
            var prevIndex = Index;
            var itemCount = 0;
            var bQueue = new Queue<Interval>();
            var rQueue = new Queue<Interval>();
            do
            {
                if (item == prevItem)
                {
                    itemCount++;
                }
                else
                {
                    if ((char)item == 'B')
                    {
                        bQueue.Enqueue(new Interval { Start = prevIndex, End = Index - 1, Value = -1 * itemCount });
                        rQueue.Enqueue(new Interval { Start = prevIndex, End = Index - 1, Value = itemCount });
                    }
                    else
                    {
                        bQueue.Enqueue(new Interval { Start = prevIndex, End = Index - 1, Value = itemCount });
                        rQueue.Enqueue(new Interval { Start = prevIndex, End = Index - 1, Value = -1 * itemCount });
                    }
                    itemCount = 1;
                    prevIndex = Index;
                    prevItem = item;
                }
                if (scanner.streamReader.Peek() < 65)
                {
                    if (itemCount > 0)
                    {
                        if ((char)item == 'B')
                        {
                            bQueue.Enqueue(new Interval { Start = prevIndex, End = Index, Value = itemCount });
                            rQueue.Enqueue(new Interval { Start = prevIndex, End = Index, Value = -1 * itemCount });
                        }
                        else
                        {
                            bQueue.Enqueue(new Interval { Start = prevIndex, End = Index, Value = -1 * itemCount });
                            rQueue.Enqueue(new Interval { Start = prevIndex, End = Index, Value = itemCount });
                        }
                    }
                }
                item = scanner.streamReader.Read();
                Index++;
            }
            while (item > 65);


            Interval bMax = JoinAndFindMax(bQueue);
            Interval rMax = JoinAndFindMax(rQueue);
            var max = new[] { bMax, rMax }.Min();

            scanner.streamWriter.WriteLine($"{max.Start + 1} {max.End + 1}");
            scanner.streamWriter.Flush();
        }

        private static Interval JoinAndFindMax(Queue<Interval> queue)
        {
            if (queue.Count > 0)
            {
                if (queue.Peek().Value < 0)
                {
                    queue.Dequeue();
                }
            }
            Interval currentValue = null;
            if (queue.Count > 0)
            {
                currentValue = queue.Dequeue();
            }
            if (currentValue == null)
            {
                return new Interval { Start = 0, End = 0, Value = 0 };
            }
            Interval maxValue = new Interval { Start = currentValue.Start, End = currentValue.End, Value = currentValue.Value };
            var currentStart = currentValue.Start;
            var currentEnd = currentValue.End;
            var currentIntValue = currentValue.Value;
            //get longest sequence with max sum => maxValue
            while (queue.Count > 0)
            {
                var next = queue.Dequeue();
                currentIntValue += next.Value;
                if (currentIntValue < 0)
                {
                    currentStart = next.End + 1;
                    currentIntValue = 0;
                }
                else
                {
                    currentEnd = next.End;

                    if (currentIntValue > maxValue.Value)
                    {
                        maxValue.Start = currentStart;
                        maxValue.End = currentEnd;
                        maxValue.Value = currentIntValue;
                    }
                }
            }
            return maxValue;
        }

        public class Interval : IComparable<Interval>
        {
            public int Start { get; set; }
            public int End { get; set; }

            public int Value { get; set; }

            int IComparable<Interval>.CompareTo(Interval other)
            {
                return Value == other.Value ? Start == other.Start ? End.CompareTo(other.End) : Start.CompareTo(other.Start) : (0 - Value).CompareTo(0 - other.Value);
            }
        }
    }
}
