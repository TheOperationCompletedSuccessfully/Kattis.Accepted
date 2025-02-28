using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace MuddyHike
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 23, 2 ^ 7);
            var rows = scanner.NextUInt();
            var columns = scanner.NextUInt();
            var data = new int[rows, columns];
            var movement = new PriorityQueue<Path, int>();
            //key of visited cell, tuple of maxcell,id of path class
            //remove not efficient paths when visited
            var visitedNodes = new Dictionary<int, Tuple<int, int>>();
            //key=cellid, pathid
            var toBeRemoved = new HashSet<int>();
            for (int row = 0; row < rows; row++)
            {
                for (int col = 0; col < columns; col++)
                {
                    var next = scanner.NextUInt(col == 0);
                    data[row, col] = next;
                    if (col == 0)
                    {
                        var newPath = new Path { CurrentValue = next, CurrentRow = row, CurrentColumn = col, MaxValue = next, Id = row };
                        movement.Enqueue(newPath, next);
                    }
                }
            }
            bool found = false;
            Path result = null;

            while (!found)
            {
                var nextMove = movement.Dequeue();
                if (toBeRemoved.Contains(nextMove.Id))
                {
                    continue;
                }

                if (visitedNodes.TryGetValue(nextMove.Key, out Tuple<int, int>? visitedValue) && visitedValue.Item1 <= nextMove.MaxValue)
                {
                    continue;
                }
                if (visitedNodes.TryGetValue(nextMove.Key, out Tuple<int, int>? visitedValue2) && visitedValue2.Item1 > nextMove.MaxValue)
                {
                    nextMove.CurrentValue = data[nextMove.CurrentRow, nextMove.CurrentColumn];
                    nextMove.MaxValue = Math.Max(nextMove.MaxValue, nextMove.CurrentValue);
                    toBeRemoved.Add(visitedValue2.Item2);
                    visitedNodes[nextMove.Key] = new Tuple<int, int>(nextMove.MaxValue, nextMove.Id);
                }

                if (!visitedNodes.ContainsKey(nextMove.Key))
                {
                    nextMove.CurrentValue = data[nextMove.CurrentRow, nextMove.CurrentColumn];
                    nextMove.MaxValue = Math.Max(nextMove.MaxValue, nextMove.CurrentValue);
                    visitedNodes.Add(nextMove.Key, new Tuple<int, int>(nextMove.MaxValue, nextMove.Id));
                }

                if (nextMove.CurrentColumn == columns - 1)
                {
                    found = true;
                    result = nextMove;
                    continue;
                }

                var moveLeft = MoveLeft(nextMove, ref data);
                if (moveLeft != null && !IsVisited(moveLeft, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveLeft, moveLeft.MaxValue);
                }

                var moveRight = MoveRight(nextMove, ref data, columns);
                if (moveRight != null && !IsVisited(moveRight, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveRight, moveRight.MaxValue);
                }

                var moveUp = MoveUp(nextMove, ref data);
                if (moveUp != null && !IsVisited(moveUp, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveUp, moveUp.MaxValue);
                }

                var moveDown = MoveDown(nextMove, ref data, rows);
                if (moveDown != null && !IsVisited(moveDown, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveDown, moveDown.MaxValue);
                }
            }

            while (movement.Count > 0 && movement.Peek().MaxValue < result.MaxValue)
            {
                var nextMove = movement.Dequeue();

                if (toBeRemoved.Contains(nextMove.Id))
                {
                    continue;
                }

                if (visitedNodes.TryGetValue(nextMove.Key, out Tuple<int, int>? visitedValue) && visitedValue.Item1 <= nextMove.MaxValue)
                {
                    continue;
                }
                if (visitedNodes.TryGetValue(nextMove.Key, out Tuple<int, int>? visitedValue2) && visitedValue2.Item1 > nextMove.MaxValue)
                {
                    toBeRemoved.Add(visitedValue2.Item2);
                    visitedNodes[nextMove.Key] = new Tuple<int, int>(nextMove.MaxValue, nextMove.Id);
                }

                if (!visitedNodes.ContainsKey(nextMove.Key))
                {
                    visitedNodes.Add(nextMove.Key, new Tuple<int, int>(nextMove.MaxValue, nextMove.Id));
                }

                if (nextMove.CurrentColumn == columns - 1)
                {
                    if (result.MaxValue > nextMove.MaxValue)
                    {
                        result = nextMove;
                    }
                    continue;
                }

                var moveLeft = MoveLeft(nextMove, ref data);
                if (moveLeft != null && !IsVisited(moveLeft, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveLeft, moveLeft.MaxValue);
                }

                var moveRight = MoveRight(nextMove, ref data, columns);
                if (moveRight != null && !IsVisited(moveRight, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveRight, moveRight.MaxValue);
                }

                var moveUp = MoveUp(nextMove, ref data);
                if (moveUp != null && !IsVisited(moveUp, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveUp, moveUp.MaxValue);
                }

                var moveDown = MoveDown(nextMove, ref data, rows);
                if (moveDown != null && !IsVisited(moveDown, visitedNodes, toBeRemoved))
                {
                    movement.Enqueue(moveDown, moveDown.MaxValue);
                }
            }
            scanner.streamWriter.WriteLine(result.MaxValue);
            scanner.streamWriter.Flush();
        }

        static bool IsVisited(Path nextMove, Dictionary<int, Tuple<int, int>> visitedNodes, HashSet<int> toBeRemoved)
        {
            if (visitedNodes.TryGetValue(nextMove.Key, out Tuple<int, int>? nextValue) && nextValue.Item1 <= nextMove.MaxValue)
            {
                return true;
            }
            if (visitedNodes.TryGetValue(nextMove.Key, out Tuple<int, int>? visitedValue) && visitedValue.Item1 > nextMove.MaxValue)
            {
                toBeRemoved.Add(visitedValue.Item2);
                visitedNodes[nextMove.Key] = new Tuple<int, int>(nextMove.MaxValue, nextMove.Id);
                return false;
            }
            return false;
        }

        static Path MoveLeft(Path previous, ref int[,] data)
        {
            if (previous.CurrentColumn == 0)
            {
                return null;
            }
            var maxValue = Math.Max(previous.MaxValue, data[previous.CurrentRow, previous.CurrentColumn - 1]);
            return new Path { CurrentColumn = previous.CurrentColumn - 1, CurrentRow = previous.CurrentRow, MaxValue = maxValue, Id = previous.Id, CurrentValue = data[previous.CurrentRow, previous.CurrentColumn - 1] };
        }

        static Path MoveRight(Path previous, ref int[,] data, int columns)
        {
            if (previous.CurrentColumn + 1 == columns)
            {
                return null;
            }
            var maxValue = Math.Max(previous.MaxValue, data[previous.CurrentRow, previous.CurrentColumn + 1]);
            return new Path { CurrentColumn = previous.CurrentColumn + 1, CurrentRow = previous.CurrentRow, MaxValue = maxValue, Id = previous.Id, CurrentValue = data[previous.CurrentRow, previous.CurrentColumn + 1] };
        }

        static Path MoveUp(Path previous, ref int[,] data)
        {
            if (previous.CurrentRow == 0)
            {
                return null;
            }
            var maxValue = Math.Max(previous.MaxValue, data[previous.CurrentRow - 1, previous.CurrentColumn]);
            return new Path { CurrentColumn = previous.CurrentColumn, CurrentRow = previous.CurrentRow - 1, MaxValue = maxValue, Id = previous.Id, CurrentValue = data[previous.CurrentRow - 1, previous.CurrentColumn] };
        }

        static Path MoveDown(Path previous, ref int[,] data, int rows)
        {
            if (previous.CurrentRow + 1 == rows)
            {
                return null;
            }
            var maxValue = Math.Max(previous.MaxValue, data[previous.CurrentRow + 1, previous.CurrentColumn]);
            return new Path { CurrentColumn = previous.CurrentColumn, CurrentRow = previous.CurrentRow + 1, MaxValue = maxValue, Id = previous.Id, CurrentValue = data[previous.CurrentRow + 1, previous.CurrentColumn] };
        }

        public class Path
        {
            public int CurrentValue { get; set; }

            public int CurrentRow { get; set; }

            public int CurrentColumn { get; set; }

            public int MaxValue { get; set; }

            public int Id { get; set; }

            public int Key => 1000 * CurrentRow + CurrentColumn;

        }
    }
}
