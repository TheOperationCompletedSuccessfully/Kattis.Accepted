using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace Clinic
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 21, 2 ^ 7);

            var n = scanner.NextUInt();
            var k = scanner.NextUInt();
            var patients = new MaxIntHeap<Patient>();
            var leftPatients = new HashSet<string>();
            for (int i = 0; i < n; i++)
            {
                var q = scanner.NextUInt(true);
                switch (q)
                {
                    case 1:
                        int t = scanner.NextUInt();
                        string name = scanner.NextString(33);
                        int s = scanner.NextUInt();
                        var newPatient = new Patient() { ArrivalTime = t, Name = name, Severity = s, K = k };
                        patients.Push(newPatient, t);
                        leftPatients.Remove(name);
                        break;
                    case 2:
                        int time = scanner.NextUInt();
                        Patient nextPatient = null;
                        while (patients.Count > 0 && (nextPatient == null || leftPatients.Contains(nextPatient.Name)))
                        {
                            nextPatient = patients.Pop(time);
                        }
                        if (nextPatient == null || leftPatients.Contains(nextPatient.Name))
                        {
                            scanner.streamWriter.WriteLine("doctor takes a break");
                            //leftPatients.Clear();
                        }
                        else if (nextPatient != null)
                        {
                            scanner.streamWriter.WriteLine(nextPatient.Name);
                        }
                        break;
                    case 3:
                        int tt = scanner.NextUInt();
                        string leftName = scanner.NextString(33);
                        leftPatients.Add(leftName);
                        break;
                }
            }
            scanner.streamWriter.Flush();
        }
    }

    public class Patient : IGetIntValue<Patient>
    {
        public int ArrivalTime { get; set; }
        public string Name { get; set; }

        public int Severity { get; set; }

        public int K { get; set; }

        public long Compare(Patient other, int time)
        {
            if(GetValue(time) == other.GetValue(time))
            {
                return 0-Name.CompareTo(other.Name);
            }
            else
            {
                return GetValue(time) - other.GetValue(time);
            }
        }

        public long GetValue(int time) => (time - ArrivalTime) * (long)K + Severity;
    }
}