using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace BirthdayBoy
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 12, 2 ^ 7);

            var n = scanner.NextUInt();
            var boys = new MinIntHeap<Boy>();
            var intervals = new MaxIntHeap<DaysInterval>();
            for(int i=0;i<n;i++)
            {
               var nextName = scanner.NextString(65);
               var nextMonth = scanner.NextUInt();
               var nextDay = scanner.NextUInt();
               var birthDay = new DateTime(2023, nextMonth, nextDay);
               if(birthDay>new DateTime(2023,10,28))
               {
                  birthDay = new DateTime(2022, nextMonth, nextDay);
               }
               var boy = new Boy { BirthDay = birthDay, Name = nextName };
               boys.Push(boy);
            }
            var prevDateTime = new DateTime(2022, 10, 28);
            var firstBoy = boys.Peek();
            var nextBoy = boys.Peek();
            while(boys.Count>0)
            {
               nextBoy = boys.Pop();
               var nextDaysInterval = new DaysInterval { StartDate = prevDateTime, EndDate = nextBoy.BirthDay };
               prevDateTime = nextDaysInterval.EndDate;
               intervals.Push(nextDaysInterval);
            }
            if(firstBoy.BirthDay!=nextBoy.BirthDay)
            {
               var specialBoy = new Boy { BirthDay = nextBoy.BirthDay.AddYears(-1) };
               var nextDaysInterval = new DaysInterval { StartDate = specialBoy.BirthDay, EndDate = firstBoy.BirthDay };
               intervals.Push(nextDaysInterval);
            }

            var candidate = intervals.Pop();
            var answer = candidate.EndDate.AddDays(-1);
            scanner.streamWriter.WriteLine(answer.ToString("MM-dd"));
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();

      }

      public class DaysInterval : IGetIntValue<DaysInterval>
      {
         public DateTime StartDate { get; set; }

         public DateTime EndDate { get; set; }
         public int Days => EndDate.Subtract(StartDate).Days*1000+(365-Math.Min(EndDate.Subtract(new DateTime(2021,10,28)).Days,EndDate.Subtract(new DateTime(2022,10,28)).Days));

         public int GetValue(DaysInterval item) => Days;
      }

      public class Boy : IGetIntValue<Boy>
      {
         public string Name { get; set; }

         public DateTime BirthDay { get; set; }

         public int GetValue(Boy item) => BirthDay.Subtract(new DateTime(2022, 10, 28)).Days;
      }
   }
}
