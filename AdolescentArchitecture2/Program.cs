using System;
using System.Collections.Generic;
using Zeva;

namespace AdolescentArchitecture
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 11, 2 ^ 11))
            {
                var n = scanner.NextUInt();
                try
                {
                    var toys = new PriorityQueue<Toy,double>();
                    for (int i = 0; i < n; i++)
                    {
                        var nextType = scanner.NextString(97);
                        var nextValue = scanner.NextUInt();
                        Toy nextToy = new Toy { ToyType = nextType };
                        switch (nextType)
                        {
                            case "cube":
                                nextToy.Side = nextValue;
                                break;
                            case "cylinder":
                                nextToy.Radius = nextValue;
                                break;
                        }

                        toys.Enqueue(nextToy,nextToy.Value);

                    }

                    var finalAnswer = new List<Toy>();
                    while (toys.Count > 0)
                    {
                        var nextToy = toys.Dequeue();
                        if (toys.Count > 0)
                        {
                            nextToy.CompareTo(toys.Peek());
                        }
                        finalAnswer.Add(nextToy);
                    }
                    foreach (var toy in finalAnswer)
                    {
                        scanner.streamWriter.WriteLine(toy);
                    }
                }
                catch (ToyException)
                {
                    scanner.streamWriter.WriteLine("impossible");
                }
                finally
                {
                    scanner.streamWriter.Flush();
                }

            }
            //Console.ReadKey();
        }

        public class Toy : IEquatable<Toy>, IComparable<Toy>
        {
            public string ToyType { get; set; }

            public int Side { get; set; }

            public double Radius { get; set; }

            public double Value => Radius > 0 ? Radius : (0.0001 + Side) / 2d;

            public double StrValue => Radius > 0 ? Radius : Side;

            public int CompareTo(Toy other)
            {
                if (ToyType.Equals(other.ToyType))
                {
                    return Value.CompareTo(other.Value);
                }

                if (Radius > 0)
                {
                    if (Radius > other.Side / 2d && Radius < Math.Sqrt(2) * other.Side / 2d)
                    {
                        throw new ToyException();
                    }
                    return Radius.CompareTo(Math.Sqrt(2) * other.Side / 2d);
                }

                if (Side / 2d < other.Radius && Math.Sqrt(2) * Side / 2d > other.Radius)
                {
                    throw new ToyException();
                }
                return (Math.Sqrt(2) * Side / 2d).CompareTo(other.Radius);
            }

            public bool Equals(Toy other)
            {
                if (ToyType.Equals(other.ToyType))
                {
                    return Value.Equals(other.Value);
                }

                if (Radius > 0)
                {
                    if (Radius > other.Side / 2d && Radius < Math.Sqrt(2) * other.Side / 2d)
                    {
                        throw new ToyException();
                    }
                    return Radius.Equals(other.Side / 2d);
                }

                if (Side / 2d < other.Radius && Math.Sqrt(2) * Side / 2d > other.Radius)
                {
                    throw new ToyException();
                }
                return (Side / 2d).Equals(other.Radius);
            }

            public override string ToString()
            {
                return $"{ToyType} {StrValue}";
            }
        }

        public class ToyException : Exception
        {

        }
    }
}