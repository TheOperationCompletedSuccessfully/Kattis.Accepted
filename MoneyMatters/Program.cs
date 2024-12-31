using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace MoneyMatters
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 20, 2 ^ 7);
            var n = scanner.NextUInt();
            var m = scanner.NextUInt();
            var sum = 0;
            Span<int> friends = stackalloc int[n];
            for (int i = 0; i < n; i++)
            {
                var nextAmount = scanner.NextInt(true);
                friends[i] = nextAmount;
                sum += nextAmount;
            }
            if (sum != 0)
            {
                scanner.streamWriter.WriteLine("IMPOSSIBLE");
                scanner.streamWriter.Flush();
                return;
            }
            var friendships = new Dictionary<int, List<FriendShip>>();
            for (int i = 0; i < m; i++)
            {
                var nextFrom = scanner.NextUInt(true);
                var nextTo = scanner.NextUInt();
                var friendship1 = new FriendShip { From = nextFrom, To = nextTo };
                var friendship2 = new FriendShip { To = nextFrom, From = nextTo };
                if (friendships.TryGetValue(nextFrom, out List<FriendShip>? value))
                {
                    value.Add(friendship1);
                }
                else
                {
                    friendships.Add(nextFrom, [friendship1]);
                }
                if (friendships.TryGetValue(nextTo, out List<FriendShip>? value2))
                {
                    value2.Add(friendship2);
                }
                else
                {
                    friendships.Add(nextTo, [friendship2]);
                }
            }

            var pq = new Queue<int>();

            var notVisited = Enumerable.Range(0, n).ToHashSet();
            while (notVisited.Count > 0)
            {
                int controlSum = 0;
                pq.Enqueue(notVisited.First());
                while (pq.Count > 0 && notVisited.Count > 0)
                {
                    var next = pq.Dequeue();
                    if (!notVisited.Contains(next))
                    {
                        continue;
                    }
                    controlSum += friends[next];
                    if (friendships.TryGetValue(next, out List<FriendShip>? value))
                    {
                        foreach (var friend in value)
                        {
                            pq.Enqueue(friend.To);
                        }
                    }
                    notVisited.Remove(next);
                }
                if (controlSum != 0)
                {
                    scanner.streamWriter.WriteLine("IMPOSSIBLE");
                    scanner.streamWriter.Flush();
                    return;
                }
            }
            scanner.streamWriter.WriteLine("POSSIBLE");
            scanner.streamWriter.Flush();
        }
    }
    public class FriendShip
    {
        public int From { get; set; }
        public int To { get; set; }
    }
}