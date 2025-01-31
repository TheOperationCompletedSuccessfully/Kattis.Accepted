using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Saunas
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 18, 2 ^ 12);
            var n = scanner.NextUInt();
            var allFinns = new MinIntHeap<Finn>();
            long totalA = 0;
            long totalB = 0;
            long totalC = 0;
            for (int i = 0; i < n; i++)
            {
                var a = scanner.NextInt(true);
                var b = scanner.NextInt();
                var c = scanner.NextInt();
                var maxT = scanner.NextUInt();
                totalA += a;
                totalB += b;
                totalC += c;
                var next = new Finn { A = a, B = b, C = c, MaxT = maxT };
                allFinns.Push(next);
            }
            double exPoint = totalA != 0 ? (-1d) * totalB / (2 * totalA) : totalB >= 0 ? allFinns.Peek().MaxT : 0;
            double result = 0;

            while (allFinns.Count > 0)
            {
                var next = allFinns.PopGroup();
                if (totalA > 0)
                {
                    long m = next.Key.MaxT;
                    long o = 0;
                    long toDealWith = Math.Abs(exPoint - 0) < Math.Abs(exPoint - m) ? m : o;
                    result = Math.Max((double)totalA * toDealWith * toDealWith + totalB * toDealWith + totalC, result);
                }
                else
                {
                    if (exPoint > next.Key.MaxT)
                    {
                        exPoint = next.Key.MaxT;
                    }
                    if(exPoint < 0)
                    {
                        exPoint = 0;
                    }
                    result = Math.Max((double)totalA * exPoint * exPoint + totalB * exPoint + totalC, result);
                }
                totalA -= next.Key.A * (long)next.Value;
                totalB -= next.Key.B * (long)next.Value;
                totalC -= next.Key.C * (long)next.Value;
                while (allFinns.Count > 0 && allFinns.Peek().MaxT == next.Key.GetValue(next.Key))
                {
                    next = allFinns.PopGroup();
                    totalA -= next.Key.A * (long)next.Value;
                    totalB -= next.Key.B * (long)next.Value;
                    totalC -= next.Key.C * (long)next.Value;
                };
                if (allFinns.Count > 0)
                {
                    exPoint = totalA != 0 ? (-1d) * totalB / (2 * totalA) : totalB >= 0 ? allFinns.Peek().MaxT : 0;
                }
            }
            scanner.streamWriter.WriteLine(result);
        }

        public class Finn : IGetIntValue<Finn>, IEquatable<Finn>
        {
            public int A { get; set; }
            public int B { get; set; }

            public int C { get; set; }

            public int MaxT { get; set; }

            public bool Equals(Finn other)
            {
                return A == other.A && B == other.B && C == other.C && MaxT == other.MaxT;
            }

            public int GetValue(Finn item) => MaxT;

            public override bool Equals(object obj)
            {
                return Equals(obj as Finn);
            }
        }
    }
}
