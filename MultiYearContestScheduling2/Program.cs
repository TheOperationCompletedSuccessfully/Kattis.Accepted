using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Zeva;

namespace ContestScheduling
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 9, 2 ^ 11);
            var years = scanner.NextUInt();
            var forbiddenDatesCount = scanner.NextUInt(true);
            var forbiddenDates = new HashSet<DateTime>();
            var schedules = new PriorityQueue<DateSchedule, long>();
            var goodOptions = new List<DateTime>[years];
            for (int i = 0; i < forbiddenDatesCount; i++)
            {
                var year = scanner.NextUInt(true);
                var month = scanner.NextUInt();
                var day = scanner.NextUInt();
                var date = new DateTime(year, month, day);
                if (year < 2019 + years && year > 2018 && month == 10 && date.DayOfWeek == DayOfWeek.Friday)
                {
                    forbiddenDates.Add(date);
                }
            }
            for (int i = 2019; i < years + 2019; i++)
            {
                int monday = 0;
                int day = 1;
                var year = i;
                var month = 10;
                DateTime date = new(year, month, day);
                while (monday < 2)
                {

                    date = new DateTime(year, month, day);
                    if (date.DayOfWeek == DayOfWeek.Monday)
                    {
                        monday++;
                    }
                    day++;
                }
                var forbiddenDate = new DateTime(date.Year, date.Month, date.Day - 3);
                forbiddenDates.Add(forbiddenDate);
                goodOptions[i - 2019] = [];
            }
            for (int i = 2019; i < years + 2019; i++)
            {
                int friday = 0;
                int day = 1;
                var year = i;
                var month = 10;
                DateTime date = new(year, month, day);
                while (friday < 1)
                {
                    date = new DateTime(year, month, day);
                    if (date.DayOfWeek == DayOfWeek.Friday)
                    {
                        friday++;
                    }
                    day++;
                }
                day--;
                while (day <= 31)
                {
                    date = new DateTime(year, month, day);
                    if (!forbiddenDates.Contains(date))
                    {
                        goodOptions[i - 2019].Add(date);
                    }
                    day += 7;
                }
            }

            foreach (var date in goodOptions[0])
            {
                var dateSchedule = new DateSchedule { CurrentDate = date, Penalty = (date.Day - 12) * (date.Day - 12) };
                schedules.Enqueue(dateSchedule, dateSchedule.Penalty);
            }

            var candidate = schedules.Dequeue();
            var alreadyChosen = new Dictionary<DateTime,long> { { candidate.CurrentDate,candidate.Penalty } };
            while (candidate.CurrentDate.Year != years + 2018)
            {
                
                foreach (var nextDate in goodOptions[candidate.CurrentDate.Year + 1 - 2019])
                {
                    var proposedPenalty = candidate.Penalty + (nextDate.Day - candidate.CurrentDate.Day) * (nextDate.Day - candidate.CurrentDate.Day);
                    if (!alreadyChosen.TryGetValue(nextDate, out long value) || value > proposedPenalty)
                    {
                        var nextSchedule = new DateSchedule { CurrentDate = nextDate, ChosenDates = new Queue<DateTime>(candidate.ChosenDates) };
                        nextSchedule.ChosenDates.Enqueue(candidate.CurrentDate);
                        nextSchedule.Penalty = proposedPenalty;
                        schedules.Enqueue(nextSchedule, nextSchedule.Penalty);
                        if(alreadyChosen.ContainsKey(nextDate))
                        {
                            alreadyChosen[nextDate] = proposedPenalty;
                        }
                        else
                        {
                            alreadyChosen.Add(nextDate,proposedPenalty);
                        }
                        
                    }
                }
                candidate = schedules.Dequeue();
            }
            scanner.streamWriter.WriteLine(candidate.Penalty);
            while (candidate.ChosenDates.Count > 0)
            {
                var date = candidate.ChosenDates.Dequeue();
                scanner.streamWriter.Write(date.Year);
                scanner.streamWriter.Write(" ");
                scanner.streamWriter.Write(date.Month);
                scanner.streamWriter.Write(" ");
                scanner.streamWriter.WriteLine(date.Day.ToString("00"));
            }

            scanner.streamWriter.Write(candidate.CurrentDate.Year);
            scanner.streamWriter.Write(" ");
            scanner.streamWriter.Write(candidate.CurrentDate.Month);
            scanner.streamWriter.Write(" ");
            scanner.streamWriter.WriteLine(candidate.CurrentDate.Day.ToString("00"));
            scanner.streamWriter.Flush();
        }

        public sealed class DateSchedule 
        {
            public DateTime CurrentDate { get; set; }

            public Queue<DateTime> ChosenDates = new();

            public long Penalty { get; set; }

        }
    }
}
