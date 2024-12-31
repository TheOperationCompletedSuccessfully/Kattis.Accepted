using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace PizzaDelivery
{
    class Program
    {
        static void Main(string[] args)
        {

            using var scanner = new ZevaScanner(2 ^ 20, 2 ^ 9);
            var n = scanner.NextUInt();
            
            for (int i = 0; i < n; i++)
            {
                var cols = scanner.NextUInt(true);
                var rows = scanner.NextUInt();
                var totalSum = 0;
                Span<RolColValue> data = stackalloc RolColValue[10101];
                Span<long> rowSums = stackalloc long[100];
                Span<long> colsSums = stackalloc long[100];
                for (int row = 0; row < rows; row++)
                    for (int col = 0; col < cols; col++)
                    {
                        var next = scanner.NextUInt(col == 0);
                        rowSums[row] += next;
                        colsSums[col] += next;
                        totalSum += next;
                        var newRCV = new RolColValue(row, col, next);
                        if (next != 0)
                        {
                            data[(col+1) * 100 + row] = newRCV;
                        }
                    }

                long rowComplexSum = 0;
                for (int row = 0; row < rows; row++)
                {
                    rowComplexSum += row * rowSums[row];
                }
                long colComplexSum = 0;
                for (int col = 0; col < cols; col++)
                {
                    colComplexSum += col * colsSums[col];
                }

                var rowOptions = new List<long> { (long)Math.Ceiling(rowComplexSum / (double)totalSum), (rowComplexSum / totalSum) }.ToHashSet();
                var colOptions = new List<long> { (long)Math.Ceiling(colComplexSum / (double)totalSum), (colComplexSum / totalSum) }.ToHashSet();

                var result = Int64.MaxValue;

                foreach (var row in rowOptions)
                    foreach (var col in colOptions)
                    {
                        long sum = 0;
                        for (int rowC = 0; rowC < rows; rowC++)
                            for (int colC = 0; colC < cols; colC++)
                            {
                                var item = data[100 * (colC+1) + rowC];
                                sum += (Math.Abs(item.Row - row) + Math.Abs(item.Col - col)) * item.Value;
                            }
                        result = Math.Min(result, sum);
                    }

                scanner.streamWriter.Write(result);
                scanner.streamWriter.WriteLine($" blocks");
            }

            scanner.streamWriter.Flush();
        }
    }

        public readonly struct RolColValue(int row, int col, int value)
        {
            public int Row { get; } = row;
            public int Col { get; } = col;
            public int Value { get; } = value;
        }
}