using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace TripOdometer
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 19, 2 ^ 19);

                var n = scanner.NextUInt();
                var data = new HashSet<int>();
                var item = scanner.NextUInt(true);
                data.Add(item);
                var sum = item;
                for(int i=1;i<n;i++)
                {
                    item = scanner.NextUInt();
                    data.Add(item);
                    sum += item;
                }
                var result = new HashSet<int>();
                foreach(var d in data)
                {
                    result.Add(sum - d);
                }

                scanner.streamWriter.WriteLine(result.Count);
                scanner.streamWriter.WriteLine(string.Join(" ", result.OrderBy(i=>i)));
                scanner.streamWriter.Flush();
            }
        }
    }
}
