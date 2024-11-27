using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using Zeva;

namespace DoctorKattis
{
   class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 25, 2 ^ 25))
            {
                var n = scanner.NextUInt();
                var cats = new Dictionary<string, Cat>();
                var catsInventory = new Dictionary<int, Cat>();
                var pq = new PriorityQueue<Cat,int>();
                var catCounter = 0;
                for (int i = 0; i < n; i++)
                {
                    var command = scanner.NextUInt(true);
                    string catName = string.Empty;
                    int increaseLevel = 0;
                    if (command < 3)
                    {
                        catName = scanner.NextString(65);
                    }

                    if (command < 2)
                    {
                        increaseLevel = scanner.NextUInt();
                    }

                    if (command == 0)
                    {
                        var newCat = new Cat { Name = catName, InfectionLevel = increaseLevel, ArrivalNumber = catCounter };
                        cats.Add(catName, newCat);
                        pq.Enqueue(newCat,newCat.GetHashCode());
                        catCounter++;
                    }

                    if (command == 1)
                    {
                        if (increaseLevel > 0)
                        {
                            cats[catName].InfectionLevel += increaseLevel;
                            pq.Enqueue(cats[catName], cats[catName].GetHashCode());
                        }
                    }

                    if (command == 2)
                    {
                        cats.Remove(catName);
                    }

                    if (command == 3)
                    {
                        scanner.streamWriter.WriteLine(cats.Count == 0 ? ClinicIsEmpty(pq) : FindTopCat(pq,cats));
                    }

                }
                scanner.streamWriter.Flush();
            }
         //Console.ReadKey();
        }

        private static string ClinicIsEmpty(PriorityQueue<Cat, int> pq)
        {
            pq = new PriorityQueue<Cat, int>();
            return "The clinic is empty";
        }

        private static string FindTopCat(PriorityQueue<Cat,int> pq, Dictionary<string, Cat> cats)
        {
            while(pq.Count > 0) 
            {
                var next = pq.Peek();
                if(cats.ContainsKey(next.Name))
                {
                    return next.Name;
                }
                else
                {
                    pq.Dequeue();
                }
            }
            return "The clinic is empty";
        }

        class Cat : IComparable<Cat>
        {
            public string Name { get; set; }
            public int InfectionLevel { get; set; }

            public int ArrivalNumber { get; set; }

            public int CompareTo([AllowNull] Cat other)
            {
                if (other == null) return -1;
                if (InfectionLevel.Equals(other.InfectionLevel))
                {
                    return ArrivalNumber.CompareTo(other.ArrivalNumber);
                }
                return InfectionLevel.CompareTo(other.InfectionLevel);
            }

            public override int GetHashCode()
            {
                return (100-InfectionLevel) * 200001 + ArrivalNumber;
            }
        }
    }
}
