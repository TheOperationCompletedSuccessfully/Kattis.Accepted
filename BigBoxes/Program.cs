using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;


namespace BigBoxes
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 20, 2 ^ 6);
            var itemsNumber = scanner.NextUInt();
            var boxesNumber = scanner.NextUInt();
            Span<int> originalData = stackalloc int[itemsNumber];
            var maxItem = 0;
            var sum = 0;
            for (int i = 0; i < itemsNumber; i++)
            {
                var nextItem = scanner.NextUInt(i == 0);

                originalData[i] = nextItem;
                maxItem = Math.Max(maxItem, nextItem);
                sum += nextItem;
            }
            if (boxesNumber == 1)
            {
                scanner.streamWriter.WriteLine(sum);
            }
            else
            {
                var leftTarget = maxItem;
                var packages = Assemble(originalData, leftTarget);
                if (packages <= boxesNumber)
                {
                    scanner.streamWriter.WriteLine(leftTarget);
                }
                else
                {
                    var rightTarget = sum;
                    var target = Math.Max((leftTarget + rightTarget) / boxesNumber, maxItem);

                    while (leftTarget + 1 < rightTarget && target >= maxItem)
                    {
                        packages = Assemble(originalData, target);
                        if (packages > boxesNumber)
                        {
                            leftTarget += (rightTarget - leftTarget) / 2;
                        }
                        else
                        {
                            rightTarget -= (rightTarget - leftTarget) / 2;
                        }

                        target = (leftTarget + rightTarget) / boxesNumber;
                    }
                    scanner.streamWriter.WriteLine(Math.Max(target, maxItem));
                }

            }
            scanner.streamWriter.Flush();
        }


        static int Assemble(Span<int> data, int limit)
        {
            var initial = data[0];
            int index = 1;
            int packageCount = 1;
            while (index < data.Length)
            {
                while (index < data.Length && initial + data[index] < limit)
                {
                    initial += data[index];
                    index++;
                }
                if (index < data.Length)
                {
                    initial = data[index];
                    index++;
                    packageCount++;
                }


            }
            return packageCount;
        }
    }
}