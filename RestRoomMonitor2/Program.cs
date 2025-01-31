using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace RestroomMonitor
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 21, 2 ^ 7);
            var s = scanner.NextUInt();
            var n = scanner.NextUInt();
            var clientsWithPaper = new PriorityQueue<Client, int>();
            var clientsNoPaper = new PriorityQueue<Client, int>();

            for (int i = 0; i < n; i++)
            {
                var nextDeadline = scanner.NextUInt(true);
                var nextPaper = scanner.NextByte() - 110;
                var nextClient = new Client { Deadline = nextDeadline, RequiresPaper = nextPaper };
                if (nextPaper > 0)
                {
                    clientsWithPaper.Enqueue(nextClient, nextClient.Deadline);
                }
                else
                {
                    clientsNoPaper.Enqueue(nextClient, nextClient.Deadline);
                }
            }

            int time = 0;
            var bFound = false;
            while ((clientsNoPaper.Count > 0 || clientsWithPaper.Count > 0) && !bFound)
            {
                for (int i = 0; i < s - 1 && clientsNoPaper.Count > 0; i++)
                {
                    clientsNoPaper.Dequeue();
                }
                if (clientsWithPaper.Count > 0)
                {
                    clientsWithPaper.Dequeue();
                }
                else if (clientsNoPaper.Count > 0)
                {
                    clientsNoPaper.Dequeue();
                }
                time++;
                if (clientsWithPaper.Count > 0)
                {
                    bFound = bFound || clientsWithPaper.Peek().Deadline <= time;
                }
                if (clientsNoPaper.Count > 0)
                {
                    bFound = bFound || clientsNoPaper.Peek().Deadline <= time;
                }
            }

            if (bFound)
            {
                scanner.streamWriter.WriteLine("No");
            }
            else
            {
                scanner.streamWriter.WriteLine("Yes");
            }
            scanner.streamWriter.Flush();
        }

        public class Client : IEquatable<Client>
        {
            public int RequiresPaper { get; set; }
            public int Deadline { get; set; }

            public bool Equals(Client other)
            {
                return Deadline.Equals(other.Deadline) && RequiresPaper.Equals(other.RequiresPaper);
            }

            public override bool Equals(object obj)
            {
                return Equals(obj as Client);
            }
        }
    }
}
