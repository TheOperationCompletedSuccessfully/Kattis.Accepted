using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Linuhlynun
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var scanner = new ZevaScanner(2^22,2^7))
            {
                var n = scanner.NextUInt();
                var students = new Dictionary<int, long>();
                var data = new int[n];
                long total = 0;
                for(int i = 0; i < n; i++)
                {
                    var nextStudentHome = scanner.NextUInt(true);
                    var nextStudentPollution = scanner.NextUInt();

                    if(students.ContainsKey(nextStudentHome))
                    {
                        students[nextStudentHome] += nextStudentPollution;
                    }
                    else
                    {
                        students.Add(nextStudentHome, nextStudentPollution);
                    }
                    total += nextStudentPollution;
                }
                var keysOrdered = students.Keys.Order().ToArray();
                long sum = 0;
                int index = -1;
                while(2*sum<total)
                {
                    sum += students[keysOrdered[++index]];
                }
                scanner.streamWriter.WriteLine(keysOrdered[index]);
                scanner.streamWriter.Flush();
            }
        }
    }
}