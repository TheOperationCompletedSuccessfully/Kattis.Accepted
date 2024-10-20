using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace TSK
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2^21,2^21))
            {
                var testCases = scanner.NextUInt();
                for(int testCase = 0; testCase < testCases; testCase++) 
                {
                    var example = scanner.NextString(97);
                    var entriesCount = scanner.NextUInt();
                    var entries = new StringEntry[entriesCount];
                    for(int i=0;i< entriesCount; i++) 
                    {
                        var next = scanner.NextString(97);
                        entries[i] = new StringEntry {  Value = next };
                        entries[i].Difference = entries[i].CalcDifference(example);
                    }

                    var result = entries.Order().ToArray();
                    for(int i=0;i< result.Length;i++) 
                    {
                        scanner.streamWriter.Write(result[i].Value);
                        scanner.streamWriter.Write(" ");
                        scanner.streamWriter.WriteLine(result[i].Difference);
                    }
                }
                scanner.streamWriter.Flush();
            }
        }
    }
}

public class StringEntry : IComparable<StringEntry> 
{
    public string Value { get; set; }
    public int Difference { get; set; }
    public int CalcDifference(string example)
    {
        int result = 0;
        for (int i = 0; i < example.Length; i++)
        {
            result += Math.Abs(Rows[example[i]] - Rows[Value[i]]) + Math.Abs(Cols[example[i]] - Cols[Value[i]]);
        }
        return result;
    }

    public int CompareTo(StringEntry? other)
    {
        if(Difference.Equals(other.Difference))
        {
            return string.CompareOrdinal(Value, other.Value);
        }
        else
        {
            return Difference.CompareTo(other.Difference);
        }
    }

    private Dictionary<int, int> Rows = new Dictionary<int, int>
    {
        {97, 2 },{98, 3},{99,3 },{100,2 },{101,1 },{102,2 },{103,2},{104,2 },{105,1 },{106,2},{107,2 },
        {108, 2 },{109, 3},{110,3 },{111,1 },{112,1 },{113,1 },{114,1},{115,2 },{116,1 },{117,1},{118,3 },
        {119,1 },{120,3 },{121,1 },{122,3 }
    };
    private Dictionary<int, int> Cols = new Dictionary<int, int>
    {
        {97, 1 },{98, 5},{99,3 },{100,3 },{101,3 },{102,4 },{103,5},{104,6 },{105,8 },{106,7},{107,8 },
        {108, 9 },{109, 7},{110,6 },{111,9 },{112,10 },{113,1 },{114,4},{115,2 },{116,5 },{117,7},{118,4 },
        {119,2 },{120,2 },{121,6 },{122,1 }
    };
}