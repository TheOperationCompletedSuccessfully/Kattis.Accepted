using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;


namespace Matarinnkaup
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 21, 2 ^ 20);
            var recipeNumber = scanner.NextUInt();
            var receiptNumber = scanner.NextUInt();
            var recipes = new Dictionary<string, Dictionary<string, int>>();
            for (int i = 0; i < recipeNumber; i++)
            {
                var nextRecipeName = scanner.NextString(95);
                recipes.Add(nextRecipeName, []);
                var ingredientsNumber = scanner.NextUInt(true);
                for (int j = 0; j < ingredientsNumber; j++)
                {
                    var nextIngredientName = scanner.NextString(95);
                    var ingredientAmount = scanner.NextUInt();
                    recipes[nextRecipeName].Add(nextIngredientName, ingredientAmount);
                }
            }
            var receipts = new Dictionary<string, long>();
            for (int i = 0; i < receiptNumber; i++)
            {
                var dishNumber = scanner.NextUInt(true);
                for (int j = 0; j < dishNumber; j++)
                {
                    var nextDish = scanner.NextString(95);
                    var nextAmount = scanner.NextUInt();
                    if (receipts.ContainsKey(nextDish))
                    {
                        receipts[nextDish] += nextAmount;
                    }
                    else
                    {
                        receipts.Add(nextDish, nextAmount);
                    }
                }
            }
            var answer = new Dictionary<string, long>();
            foreach (var kvp in receipts)
            {
                foreach (var ingredientKvp in recipes[kvp.Key])
                {
                    if (answer.ContainsKey(ingredientKvp.Key))
                    {
                        answer[ingredientKvp.Key] += kvp.Value * ingredientKvp.Value;
                    }
                    else
                    {
                        answer.Add(ingredientKvp.Key, kvp.Value * ingredientKvp.Value);
                    }
                }
            }

            var answers = answer.OrderBy(kvp => kvp.Key).ToArray();
            for(int i=0;i<answers.Length;i++)
            {
                scanner.streamWriter.Write(answers[i].Key);
                scanner.streamWriter.Write(" ");
                scanner.streamWriter.WriteLine(answers[i].Value);
            }

            scanner.streamWriter.Flush();
        }
    }
}
