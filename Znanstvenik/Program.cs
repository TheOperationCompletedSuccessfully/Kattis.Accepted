using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Znanstvenik
{
    class Program
    {
        static readonly long mod = 1000000007;
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 20, 2 ^ 7);
            var r = scanner.NextUInt();
            var c = scanner.NextUInt();

            var data = Enumerable.Range(0, r).ToDictionary(i => i, i => new char[c]);
            Dictionary<long,int> hashes = [];
            Dictionary<long,List<int>> seen = [];
            for(int row = 0; row< r; row++)
            {
                char d = '-';
                while (d < 97)
                {
                    d = (char)scanner.streamReader.Read();
                }
                data[row][0] = d;
                if(row == r-1)
                {
                    hashes.Add(d, 0);
                }
                for (int col = 1; col< c; col++)
                {
                    d = (char)scanner.streamReader.Read();
                    data[row][col] = d;
                    if(row==r-1)
                    {
                        if(hashes.ContainsKey(d))
                        {
                            if(seen.ContainsKey(d))
                            {
                                seen[d].Add(col);
                            }
                            else
                            {
                                seen.Add(d, [hashes[d],col]);
                            }
                        }
                        else
                        {
                            hashes.Add(d,col);
                        }
                    }
                }
            }

            var result = r-1;
            while(seen.Count > 0&&result>0)
            {
                hashes.Clear();
                Dictionary<long, List<int>> seen2 = [];
                foreach (var key in seen.Keys)
                foreach(var column in seen[key])
                    {
                        var newValue = (key*123+ data[result - 1][column])%mod;

                        if (hashes.ContainsKey(newValue))
                        {
                            if (seen2.ContainsKey(newValue))
                            {
                                seen2[newValue].Add(column);
                            }
                            else
                            {
                                seen2.Add(newValue, [hashes[newValue], column]);
                            }
                        }
                        else
                        {
                            hashes.Add(newValue, column);
                        }
                    }
                seen = seen2;
                result--;
            }

            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
        }
    }

}