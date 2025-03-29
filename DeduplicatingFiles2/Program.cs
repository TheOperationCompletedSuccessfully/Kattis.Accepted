using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace DeduplicatingFiles2
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 23, 2 ^ 11);
            var n = scanner.NextUInt();
            do
            {
                var entries = new Dictionary<string, int>();
                var badEntries = new Dictionary<uint, int>();
                var hashesEntries = new HashSet<uint>();
                var toAmend = 0;
                for (int k = 0; k < n; k++)
                {
                    var line = scanner.NextString(32);
                    if (!entries.TryGetValue(line, out int value))
                    {
                        entries.Add(line, 1);
                    }
                    else
                    {
                        entries[line] = ++value;
                    }

                    var data = line.ToCharArray();
                    var result = (uint)data[0];

                    for (int i = 1; i < data.Length; i++)
                    {
                        var bitArray2 = (uint)data[i];
                        result = result ^ bitArray2;
                    }
                    //don't count collisions between same data

                    if (!hashesEntries.Add(result))
                    {
                        if (badEntries.TryGetValue(result, out int badValue))
                        {
                            badEntries[result] = ++badValue;
                            
                        }
                        else
                        {
                            badEntries.Add(result, 2);
                        }
                        toAmend += entries[line] - 1;
                    }
                }
                var res = badEntries.Values.Select(v => v * (v - 1) / 2).Sum() - toAmend;
                scanner.streamWriter.Write(entries.Count);
                scanner.streamWriter.Write($" ");
                scanner.streamWriter.WriteLine(res);

                n = scanner.NextUInt(true);
            }
            while (n > 0);

            scanner.streamWriter.Flush();
        }
    }
}
