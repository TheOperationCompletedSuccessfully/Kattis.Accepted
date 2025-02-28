using System;
using Zeva;

namespace Classy
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 23, 2 ^ 22);
            var cases = scanner.NextUInt();
            Span<int> classes = stackalloc int[10];
            for (int caseNumber = 0; caseNumber < cases; caseNumber++)
            {
                var totalPersons = scanner.NextUInt(true);
                var persons = new MaxTHeap<Person>();
                
                for (int personNumber = 0; personNumber < totalPersons; personNumber++)
                {
                    var nextName = scanner.NextString(97);
                    var className = scanner.NextString(97);
                    var classIndex = -1;
                    var nextClassValue = 0;
                    
                    do
                    {
                        switch (className)
                        {
                            case "upper":
                                classes[++classIndex] = 1;
                                break;
                            case "middle":
                                classes[++classIndex] = 0;
                                break;
                            case "lower":
                                classes[++classIndex] = -1;
                                break;
                        }
                        className = scanner.NextString(97);
                    }
                    while (!className.Equals("class"));
                    var classPow = 11;
                    for(int j=classIndex;j>=0;j--)
                    {
                        nextClassValue += (int)Math.Pow(4, --classPow) * classes[j];
                    }

                    var nextPerson = new Person { Name = nextName, Class = nextClassValue };
                    persons.Push(nextPerson);
                }

                while (persons.Count > 0)
                {
                    var nextToPrint = persons.Pop();
                    scanner.streamWriter.WriteLine(nextToPrint.Name);
                }
                scanner.streamWriter.WriteLine("==============================");
            }
            scanner.streamWriter.Flush();
        }

        public sealed class Person : IEquatable<Person>, IComparable<Person>
        {
            public string Name { get; set; }

            public long Class { get; set; }

            public int CompareTo(Person other)
            {
                if (Class.Equals(other.Class))
                {
                    return (-1)*Name.CompareTo(other.Name);
                }
                return Class.CompareTo(other.Class);
            }

            public bool Equals(Person other)
            {
                return Name.Equals(other.Name) && Class.Equals(other.Class);
            }

            public override bool Equals(object obj)
            {
                return Equals(obj as Person);
            }
        }
    }
}
