using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using Zagrade;

namespace SkyIslands
{
    class Program
    {
        static Island[] _islands;
        static HashSet<int> merged = new HashSet<int>();
        static void Main(string[] args)
        {
            
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2^24, 2^7);
                var n = scanner.NextInt();
                var m = scanner.NextInt();
                _islands = Enumerable.Range(1, n).Select(i=>new Island() { Root = i, Parent = i, Value = i, Children = new HashSet<int>(new List<int> { i}) }).ToArray();
                merged = _islands.Select(i => i.Value * n + i.Value).ToHashSet();
                if (n == 1)
                {
                    scanner.streamWriter.WriteLine("YES");
                    scanner.streamWriter.Flush();
                    return;
                }
                if (m<n-1)
                {
                    scanner.streamWriter.WriteLine("NO");
                    scanner.streamWriter.Flush();
                    return;
                }
                //var random = new Random(DateTime.Now.Millisecond);
                
                for(int i=0;i<m;i++)
                {
                    var islandIndex1 = scanner.NextInt(true);//random.Next(1, n);
                    var islandIndex2 = scanner.NextInt(); //random.Next(1, n);
                    var key = islandIndex1 * n + islandIndex2;
                    if (!merged.Contains(key)&&!merged.Contains(_islands[islandIndex1 - 1].Root*n+ _islands[islandIndex2 - 1].Value))
                    {
                        Merge(_islands[islandIndex1 - 1], _islands[islandIndex2 - 1],n);
                    }
                    if(_islands[0].Children.Count == n)
                    {
                        scanner.streamWriter.WriteLine("YES");
                        scanner.streamWriter.Flush();
                        return;
                    }
                }

                scanner.streamWriter.WriteLine("NO");
                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }

        static void Merge(Island island1, Island island2, int n)
        {
            var minIsland = island1.Value < island2.Value ? island1 : island2;
            var maxIsland = island1.Value < island2.Value ? island2 : island1;
            var minRootIsland = _islands[Math.Min(island1.Root, island2.Root)-1];
            var maxRootIsland = _islands[Math.Max(island1.Root, island2.Root)-1];
            var oldCount = minIsland.Children.Count;
            minIsland.Children.UnionWith(maxIsland.Children);
            minIsland.Children.Add(maxIsland.Value);
            if (oldCount < minIsland.Children.Count)
            {
                minRootIsland.Children.UnionWith(minIsland.Children);
                minRootIsland.Children.UnionWith(maxRootIsland.Children);
                minRootIsland.Children.Add(maxRootIsland.Value);

                foreach (var islandIndex in minRootIsland.Children)
                {
                    _islands[islandIndex - 1].Root = minRootIsland.Value;
                    merged.Add(minRootIsland.Value * n + islandIndex);
                    merged.Add(islandIndex * n + minRootIsland.Value);
                }
            }
            merged.Add(island1.Value * n + island2.Value);
            merged.Add(island2.Value * n + island1.Value);
        }

        class Island : IComparable<Island>
        {
            public int Root { get; set; }
            public int Parent { get; set; }
            public int Value { get; set; }

            public HashSet<int> Children = new HashSet<int>();

            public int CompareTo([AllowNull] Island other)
            {
                if (other == null) return -1;
                return this.Value.CompareTo(other.Value);
            }
        }
    }
}
