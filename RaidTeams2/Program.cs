using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace RaidTeams
{
    class Program
    {
        public static Dictionary<string, long> allNames = new Dictionary<string, long>();
        public static string[] names;
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 23, 2 ^ 21))
            {
                var n = scanner.NextUInt();

                var chosen = new HashSet<int>();

                names = new string[n];
                Span<Raider> raiders1 = stackalloc Raider[n];
                Span<Raider> raiders2 = stackalloc Raider[n];
                Span<Raider> raiders3 = stackalloc Raider[n];
                //var random = new Random(DateTime.Now.Millisecond);
                for (int i = 0; i < n; i++)
                {
                    var nextName = scanner.NextString(48);
                    var s1 = scanner.NextUInt();
                    var s2 = scanner.NextUInt();
                    var s3 = scanner.NextUInt();

                    names[i] = nextName;
                    var next1 = new Raider { NameIndex = i, Skill = s1 };
                    raiders1[i] = next1;
                    var next2 = new Raider { NameIndex = i, Skill = s2 };
                    raiders2[i] = next2;
                    var next3 = new Raider { NameIndex = i, Skill = s3 };
                    raiders3[i] = next3;
                }
                var raiders1Ready = new PriorityQueue<Raider, long>();
                var raiders2Ready = new PriorityQueue<Raider, long>();
                var raiders3Ready = new PriorityQueue<Raider, long>();
                var hashNames = names.OrderBy(i => i).ToArray();
                for (int j = 0; j < names.Length; j++)
                {
                    allNames.Add(hashNames[j], names.Length - j);
                }

                for (int i = 0; i < n; i++)
                {
                    raiders1Ready.Enqueue(raiders1[i], 0 - raiders1[i].GetValue());
                    raiders2Ready.Enqueue(raiders2[i], 0 - raiders2[i].GetValue());
                    raiders3Ready.Enqueue(raiders3[i], 0 - raiders3[i].GetValue());
                }

                while (raiders1Ready.Count > 0 && raiders2Ready.Count > 0 && raiders3Ready.Count > 0)
                {
                    var r1 = raiders1Ready.Dequeue();
                    bool goOut = false;
                    while (chosen.Contains(r1.NameIndex))
                    {
                        if (raiders1Ready.Count > 0)
                        {
                            r1 = raiders1Ready.Dequeue();
                        }
                        else
                        {
                            goOut = true;
                            break;
                        }
                    }
                    if (goOut)
                    {
                        break;
                    }
                    chosen.Add(r1.NameIndex);

                    var r2 = raiders2Ready.Dequeue();
                    while (chosen.Contains(r2.NameIndex))
                    {
                        if (raiders2Ready.Count > 0)
                        {
                            r2 = raiders2Ready.Dequeue();
                        }
                        else
                        {
                            goOut = true;
                            break;
                        }
                    }
                    if (goOut)
                    {
                        break;
                    }
                    chosen.Add(r2.NameIndex);

                    var r3 = raiders3Ready.Dequeue();
                    while (chosen.Contains(r3.NameIndex))
                    {
                        if (raiders3Ready.Count > 0)
                        {
                            r3 = raiders3Ready.Dequeue();
                        }
                        else
                        {
                            goOut = true;
                            break;
                        }
                    }

                    if (goOut)
                    {
                        break;
                    }

                    chosen.Add(r3.NameIndex);
                    var result = new[] { names[r1.NameIndex], names[r2.NameIndex], names[r3.NameIndex] }.Order().ToArray();
                    scanner.streamWriter.Write(result[0]);
                    scanner.streamWriter.Write(" ");
                    scanner.streamWriter.Write(result[1]);
                    scanner.streamWriter.Write(" ");
                    scanner.streamWriter.WriteLine(result[2]);
                }

                scanner.streamWriter.Flush();
            }

            //Console.ReadKey();
        }

        public struct Raider
        {
            public int NameIndex { get; set; }

            public int Skill { get; set; }

            public long GetValue() => Skill * 1000000L + allNames[names[NameIndex]];
        }

    }
}