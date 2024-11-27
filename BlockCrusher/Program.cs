using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace BlockCrusher
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2 ^ 18, 2 ^ 18))
            {
                var h = scanner.NextUInt();
                var w = scanner.NextUInt();
                
                int caseNumber = 0;
                do
                {
                    var blocks = new Dictionary<int, BlockItem>();
                    var paths = new PriorityQueue<BlockPath, int>();
                    var straightPaths = new int[w + 2];
                    for (int x = h; x >= 0; x--)
                        for (int y = 0; y < w + 2; y++)
                        {
                            int d = 100000;
                            int minPath = 0;
                            if (x < h && (y > 0 && y < w + 1))
                            {
                                d = scanner.NextDigit(true);

                                minPath = Int32.MaxValue;
                            }

                            if (x < h)
                            {
                                straightPaths[y] += d;
                            }

                            var nextItem = new BlockItem { Density = d, Y = y, X = x, MinPath = minPath };
                            blocks.Add(nextItem.Key, nextItem);
                        }
                    var minStraight = straightPaths.Min();
                    for (int y = 1; y < w + 1; y++)
                    {
                        var key = 100 * (h - 1) + y;
                        if (blocks[key].Density <= minStraight)
                        {
                            var nextPath = new BlockPath { X = h - 1, Y = y, TotalWork = blocks[key].Density };
                            blocks[key].MinPath = blocks[key].Density;
                            paths.Enqueue(nextPath, nextPath.TotalWork);
                        }
                    }

                    var nextPathToProcess = paths.Dequeue();
                    do
                    {
                        if (nextPathToProcess.X > 0 && nextPathToProcess.Y > 0)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X - 1, nextPathToProcess.Y - 1, minStraight);
                        }
                        if (nextPathToProcess.X > 0)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X - 1, nextPathToProcess.Y, minStraight);
                        }
                        if (nextPathToProcess.X > 0 && nextPathToProcess.Y + 1 < w + 1)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X - 1, nextPathToProcess.Y + 1, minStraight);
                        }

                        if (nextPathToProcess.Y > 0)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X, nextPathToProcess.Y - 1, minStraight);
                        }

                        if (nextPathToProcess.Y + 1 < w + 1)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X, nextPathToProcess.Y + 1, minStraight);
                        }

                        if (nextPathToProcess.X + 1 < h && nextPathToProcess.Y > 0)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X + 1, nextPathToProcess.Y - 1, minStraight);
                        }

                        if (nextPathToProcess.X + 1 < h)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X + 1, nextPathToProcess.Y, minStraight);
                        }

                        if (nextPathToProcess.X + 1 < h && nextPathToProcess.Y + 1 < w + 1)
                        {
                            PushItemIfPossible(nextPathToProcess, blocks, paths, nextPathToProcess.X + 1, nextPathToProcess.Y + 1, minStraight);
                        }

                        if (paths.Count > 0)
                        {
                            nextPathToProcess = paths.Dequeue();
                        }
                        else
                        {
                            break;
                        }
                    }
                    while (nextPathToProcess.X > 0);

                    if (caseNumber > 0)
                    {
                        scanner.streamWriter.WriteLine();
                    }
                    for (int x = h - 1; x >= 0; x--)
                    {
                        for (int y = 1; y < w + 1; y++)
                        {
                            var toPrint = blocks[100 * x + y];
                            if (nextPathToProcess.Path.Contains(toPrint.Key) || nextPathToProcess.Key.Equals(toPrint.Key))
                            {
                                toPrint = null;
                            }
                            scanner.streamWriter.Write(toPrint == null ? " " : toPrint.Density.ToString());
                        }
                        scanner.streamWriter.WriteLine();
                    }
                    h = scanner.NextUInt(true);
                    w = scanner.NextUInt();
                    caseNumber++;
                }
                while (h > 0);

                scanner.streamWriter.Flush();
            }
        }

        private static void PushItemIfPossible(BlockPath nextPathToProcess, Dictionary<int, BlockItem> blocks, PriorityQueue<BlockPath, int> paths, int x, int y, int levelToStop)
        {
            var item = blocks[100 * x + y];
            if (nextPathToProcess.Path.Contains(nextPathToProcess.X * 100 + nextPathToProcess.Y))
            {
                return;
            }
            if (item.MinPath < nextPathToProcess.TotalWork + item.Density)
            {
                return;
            }
            if (nextPathToProcess.TotalWork + item.Density > levelToStop)
            {
                return;
            }
            var nextPath = new BlockPath { X = x, Y = y, TotalWork = nextPathToProcess.TotalWork + item.Density, Path = new HashSet<int>(nextPathToProcess.Path) };
            nextPath.Path.Add(nextPathToProcess.X * 100 + nextPathToProcess.Y);
            item.MinPath = Math.Min(nextPathToProcess.TotalWork + item.Density, item.MinPath);
            paths.Enqueue(nextPath, nextPath.TotalWork);
        }

        public class BlockItem
        {
            public int X { get; set; }
            public int Y { get; set; }

            public int Key => 100 * X + Y;

            public int MinPath { get; set; }

            public int Density { get; set; }
        }

        public class BlockPath
        {
            public int TotalWork { get; set; }

            public int Key => 100 * X + Y;

            public int X { get; set; }
            public int Y { get; set; }

            public HashSet<int> Path = new HashSet<int>();

            public int GetValue(BlockPath item) => item.TotalWork;
        }
    }
}