using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace Downtime
{
   class Program
   {
      static void Main(string[] args)
      {
         //idea is to make 2 queues - for start times of incoming requests
         //and for endtimes
         //when server can handle more (free) - it is added to stack
         //when stack is empty - new server is created
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 20, 2 ^ 7);

            //var startTimes = new Queue<Tuple<int, int>>();//requestid-time
            var endTimes = new Queue<Tuple<int,int>>();//requestid-time
            var availableServers = new HashSet<int>();
            var allServers = new Dictionary<int, Server>();//serverid-server
            var data = new Dictionary<int, int>();//requestid-serverid

            var n = scanner.NextUInt();
            var k = scanner.NextUInt();
            int serverCounter = -1;

            for(int i=0;i<n;i++)
            {
               var next = scanner.NextUInt(true);
               while(endTimes.Count>0 && endTimes.Peek().Item2<=next)
               {
                  var item = endTimes.Dequeue();
                  allServers[data[item.Item1]].Work--;
                  availableServers.Add(allServers[data[item.Item1]].ServerId);
               }

               if(availableServers.Count>0)
               {
                  var nextServerId = availableServers.First();
                  data.Add(i, nextServerId);
                  endTimes.Enqueue(new Tuple<int, int>(i, next + 1000));
                  allServers[nextServerId].Work++;
                  if(allServers[nextServerId].Work == k)
                  {
                     availableServers.Remove(nextServerId);
                  }
               }
               else
               {
                  var nextServer = new Server { ServerId = ++serverCounter, Work=1 };
                  allServers.Add(nextServer.ServerId, nextServer);
                  data.Add(i, nextServer.ServerId);
                  endTimes.Enqueue(new Tuple<int, int>(i, next + 1000));
                  if(nextServer.Work < k)
                  {
                     availableServers.Add(nextServer.ServerId);
                  }
               }
            }

            scanner.streamWriter.WriteLine(allServers.Count);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }

      public class Server
      {
         public int Work { get; set; }

         public int ServerId { get; set; }

      }
   }
}
