using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace BokForingAccounting2
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 19, 2 ^ 19);
            var n = scanner.NextUInt();
            var q = scanner.NextUInt();
            var root = new Item();
            var data = new Dictionary<int, Item>();
            for (int i = 0; i < q; i++)
            {
                var query = scanner.NextString(65);
                int ii;
                int x;
                switch (query)
                {
                    case "SET":
                        ii = scanner.NextUInt();
                        x = scanner.NextUInt();
                        if (data.TryGetValue(ii, out Item? value))
                        {
                            value.Value = x;
                            value.SetByOrder = i + 1;
                        }
                        else
                        {
                            data.Add(ii, new Item { Id = ii, Value = x, SetByOrder = i + 1 });
                        }
                        break;
                    case "RESTART":
                        x = scanner.NextUInt();
                        root.Value = x;
                        root.SetByOrder = i + 1;
                        break;
                    case "PRINT":
                        ii = scanner.NextUInt();
                        if (data.ContainsKey(ii))
                        {
                            if (data[ii].SetByOrder > root.SetByOrder)
                            {
                                scanner.streamWriter.WriteLine(data[ii].Value);
                            }
                            else
                            {
                                scanner.streamWriter.WriteLine(root.Value);
                            }
                        }
                        else
                        {
                            scanner.streamWriter.WriteLine(root.Value);
                        }
                        break;
                }
            }
            scanner.streamWriter.Flush();
        }

        public class Item
        {
            public int Id { get; set; }
            public int SetByOrder { get; set; }

            public int Value { get; set; }
        }
    }
}
