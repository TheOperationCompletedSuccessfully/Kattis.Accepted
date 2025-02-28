using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;


namespace Geimskp
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 16, 2 ^ 7);

            var shipCount = scanner.NextUInt();
            var ships = new HashSet<Item>();
            for (int i = 0; i < shipCount; i++)
            {
                var nextX = scanner.NextInt(true);
                var nextY = scanner.NextInt();
                var nextZ = scanner.NextInt();
                var nextR = scanner.NextInt();
                var newShip = new Item { X = nextX, Y = nextY, Z = nextZ, R = nextR };
                ships.Add(newShip);
            }
            //to implement : chain reaction, e.g. UF
            var bombsCount = scanner.NextUInt(true);
            for(int i=0;i< bombsCount; i++)
            {
                var nextX = scanner.NextInt(true);
                var nextY = scanner.NextInt();
                var nextZ = scanner.NextInt();
                var nextR = scanner.NextUInt();
                var toRemove = new HashSet<Item>
                {
                    new() { X = nextX, Y = nextY, Z = nextZ, R = nextR }
                };
                int explosionCoeff = 1;
                while (toRemove.Count > 0)
                {
                    var toRemove2 = new HashSet<Item>();
                    foreach (var item in toRemove)
                    {
                        foreach (var ship in ships)
                        {
                            long dist = (long)(ship.X - item.X) * (ship.X - item.X) + (long)(ship.Y - item.Y) * (ship.Y - item.Y) + (long)(ship.Z - item.Z) * (ship.Z - item.Z);
                            long explosionRadius = (long)(ship.R + explosionCoeff * item.R) * (ship.R + explosionCoeff * item.R);
                            if (dist <= explosionRadius)
                            {
                                toRemove2.Add(ship);
                            }
                        }
                    }
                    ships.RemoveWhere(item => toRemove2.Contains(item));

                    toRemove = toRemove2;
                    explosionCoeff = 2;
                    if (ships.Count == 0)
                    {
                        break;
                    }
                }
                if (ships.Count == 0)
                {
                    break;
                }
            }

            scanner.streamWriter.WriteLine(ships.Count);
            scanner.streamWriter.Flush();
        }
    }

    public class Item : IEquatable<Item> 
    {
        public int X { get; set; }
        public int Y { get; set; }
        public int Z { get; set; }
        public int R { get; set; }

        public bool Equals(Item? other)
        {
            return X.Equals(other!.X)&& Y.Equals(other!.Y)&& Z.Equals(other!.Z)&&R.Equals(other!.R);
        }

        public override bool Equals(object obj)
        {
            return Equals(obj as Item);
        }
    }
}