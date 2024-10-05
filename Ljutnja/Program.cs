using System;
using System.Collections.Generic;
using Zeva;

//next idea:
//push all data to heap, grouped
//get data from heap and deduct min(remnantm,(diff with next peak group)*Item in group
//result will be remained data in heap as sum of  items in group*value*value


namespace Ljutnja
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 21, 2 ^ 7);

            var m = scanner.NextUInt();
            var n = scanner.NextUInt();
            var children = new MaxLongHeap<ChildrenGroup>();
            var data = new Dictionary<int, int> { {0,0 } };
            long sum = 0;
            for(int i=0;i<n;i++)
            {
               var next = scanner.NextUInt(true);
               if(data.ContainsKey(next))
               {
                  data[next]++;
               }
               else
               {
                  data.Add(next, 1);
               }
               sum += next;
            }

            children.Push(new ChildrenGroup { Anger = 0, Count = 0 });

            foreach (var kvp in data)
            {
               var nextGroup = new ChildrenGroup { Anger = kvp.Key, Count = kvp.Value };
               children.Push(nextGroup);
            }

            long left = m;
            while(left >0)
            {
               var nextGroup = children.Pop();
               var peek = children.Peek();
               var diff = nextGroup.Anger - peek.Anger;
               if(left>=nextGroup.Count*diff)
               {
                  left -= nextGroup.Count * diff;
                  peek = children.Pop();
                  if(children.Count==0)
                  {
                     children.Push(new ChildrenGroup { Anger = 0, Count = 0 });
                  }
                  var newGroup = new ChildrenGroup { Anger = peek.Anger, Count = nextGroup.Count + peek.Count };
                  children.Push(newGroup);
               }
               else
               {
                  var toLower = Math.DivRem(left, nextGroup.Count, out long rem);
                  var group1 = new ChildrenGroup { Anger = nextGroup.Anger - toLower, Count = nextGroup.Count - rem };
                  var group2 = new ChildrenGroup { Anger = group1.Anger - 1, Count = rem };
                  children.Push(group1);
                  children.Push(group2);
                  left = 0;
               }
            }

            long result = 0;
            while(children.Count>0)
            {
               var kvp = children.Pop();
               result += kvp.Anger * kvp.Anger * kvp.Count;
            }

            scanner.streamWriter.WriteLine(result);
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }
   }

   public class ChildrenGroup : IEquatable<ChildrenGroup>, IGetLongValue<ChildrenGroup>
   {
      public long Count { get; set; }

      public long Anger { get; set; }

      public bool Equals(ChildrenGroup other)
      {
         return Anger.Equals(other.Anger) && Count.Equals(other.Count);
      }

      public long GetValue(ChildrenGroup item) => item.Anger;
   }
}
