using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace RhyningSlang
{
    class Program
    {
        static void Main(string[] args)
        {
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(2 ^ 12, 2 ^ 7);

                string commonWord = scanner.NextString(65);
                int rhymeSuspectsNumber = scanner.NextUInt(true);
                var rhymes = new HashSet<string>();
                var minEnding = commonWord.Length;
                for (int i = 0; i < rhymeSuspectsNumber; i++)
                {
                    var rhymeElements =
                        scanner.NextString(32).Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries).ToList();

                    if (!rhymeElements.Any(r => commonWord.EndsWith(r)))
                    {
                        continue;
                    }
                    minEnding = Math.Min(minEnding, rhymeElements.Min(r => r.Length));

                    rhymeElements.ForEach(el => rhymes.Add(el));
                }

                int phraseNumber = scanner.NextUInt(true);

                for (int i = 0; i < phraseNumber; i++)
                {
                    var wordToTest = scanner.NextString(32).Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries).Last();
                    bool found = false;
                    if (wordToTest.Length >= minEnding && rhymes.Any(wordToTest.EndsWith))
                    {
                        scanner.streamWriter.WriteLine("YES");
                        found = true;
                    }
                    if (!found)
                    {
                        scanner.streamWriter.WriteLine("NO");
                    }
                }

                scanner.streamWriter.Flush();
            }
            //Console.ReadKey();
        }
    }
}