using Zagrade;

namespace _10KindsOfPeople
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(1048576, 256);

                var r = scanner.NextUInt();
                var c = scanner.NextUInt();
                var field = new Item[r, c];
                int sum = 0;
                for (int i = 0; i < r; i++)
                    for (int j = 0; j < c; j++)
                    {
                        int item;
                        if (j == 0)
                        {
                            int ch = 0;
                            while (ch < 48)
                            {
                                ch = scanner.NextByte();
                            }
                            item = ch - 48;
                        }
                        else
                        {
                            item = scanner.NextByte() - 48;
                        }
                        sum += item;
                        field[i, j] = new Item { Value = item == 1 };
                    }
                //for(int i=0;i<r;i++)
                //{
                //    var data = scanner.NextString(48);
                //    var itemData = data.ToCharArray().Select(cc => { sum += cc - 48; return new Item { Value = cc == 49 }; }).ToArray();
                //    for (int j = 0; j < c; j++)
                //    {
                //        field[i, j] = itemData[j];
                //    }

                //}

                var n = scanner.NextUInt(true);
                int nextGroup = 1;
                for(var i =0;i<n;i++)
                {
                    var r1 = scanner.NextUInt(true)-1;
                    var c1 = scanner.NextUInt()-1;
                    var r2 = scanner.NextUInt()-1;
                    var c2 = scanner.NextUInt()-1;

                    if(sum==0 || sum ==r*c)
                    {
                        scanner.streamWriter.WriteLine(field[r1, c1].Value ? "decimal" : "binary");
                        continue;
                    }

                    if(r1==r2 && c1 == c2)
                    {
                        scanner.streamWriter.WriteLine(field[r1, c1].Value ? "decimal" : "binary");
                        continue;
                    }

                    if(field[r1,c1].Value!= field[r2,c2].Value)
                    {
                        scanner.streamWriter.WriteLine("neither");
                        continue;
                    }

                    if(field[r1,c1].Group > 0 || field[r2,c2].Group > 0)
                    {
                        if(field[r1,c1].Group != field[r2,c2].Group)
                        {
                            scanner.streamWriter.WriteLine("neither");
                        }
                        else
                        {
                            scanner.streamWriter.WriteLine(field[r1, c1].Value ? "decimal" : "binary");
                        }
                        continue;
                    }
                    else
                    {
                        FloodFill(ref field, r1, c1, r,c, field[r1, c1].Value, nextGroup);
                        nextGroup++;

                        if (field[r1, c1].Group != field[r2, c2].Group)
                        {
                            scanner.streamWriter.WriteLine("neither");
                        }
                        else
                        {
                            scanner.streamWriter.WriteLine(field[r1, c1].Value ? "decimal" : "binary");
                        }

                    }
                }
                scanner.streamWriter.Flush();
                //Console.ReadKey();
            }
        }

        private static void FloodFill(ref Item[,] field, int r, int c, int rowLimit,int ColumnLimit, bool value, int nextGroup)
        {
            if(r>=0 && r < rowLimit && c>=0 && c<ColumnLimit && field[r,c].Value==value && field[r,c].Group==0)
            {
                field[r, c].Group = nextGroup;
                FloodFill(ref field, r - 1, c, rowLimit, ColumnLimit, value, nextGroup);
                FloodFill(ref field, r + 1, c, rowLimit, ColumnLimit, value, nextGroup);
                FloodFill(ref field, r, c-1, rowLimit, ColumnLimit, value, nextGroup);
                FloodFill(ref field, r, c+1, rowLimit, ColumnLimit, value, nextGroup);
            }
        }

        public class Item
        {
            public bool Value { get; set; }
            public int Group { get; set; }
        }
    }
}
