using System;
using System.Collections.Generic;
using Zeva;

namespace WizardOfOdds
{
    class Program
    {
        static void Main(string[] args)
        {
            const string winAnswer = "Your wish is granted!";
            const string loseAnswer = "You will become a flying monkey!";
            
            using(var scanner = new ZevaScanner())
            {
                scanner.Initialize(256, 256);
                var data = scanner.NextString('0');
                var divisor = scanner.NextString('0');

                if(divisor.Length>3)
                {
                    Console.WriteLine(winAnswer);
                    return;
                }
                var div = int.Parse(divisor);
                if(div>335)
                {
                    Console.WriteLine(winAnswer);
                    return;
                }

                if((data.Length-1)*3>div || div ==0)
                {
                    Console.WriteLine(loseAnswer);
                    return;
                }
                var n = Math.DivRem(data.Length, 10, out var rem);

                var firstBigNumber = new Queue<long>();
                var chars = new Queue<char>(data.ToCharArray());
                long number = 0;
                var charCounter = 0;
                while (chars.Count > 0)
                {
                    number = 10 * number + (long)chars.Dequeue() - 48;
                    charCounter++;
                    if (firstBigNumber.Count == 0 && charCounter == ((rem==0)? 10 : rem))
                    {
                        firstBigNumber.Enqueue(number);
                        charCounter = 0;
                        number = 0;
                    }
                    if (firstBigNumber.Count > 0 && charCounter == 10)
                    {
                        firstBigNumber.Enqueue(number);
                        charCounter = 0;
                        number = 0;
                    }

                }
                    if (number > 0)
                    {
                        firstBigNumber.Enqueue(number);
                    }
                var secondBigNumber = new Queue<long>();
                number = 1;
                secondBigNumber.Enqueue(number);
                var secondBigNumberStack = new Stack<long>();
                
                for (int i = 0; i < div; i++)
                {
                    var fin = secondBigNumber.Count;
                    long addedValue = 0;
                    for (int j = 0; j < fin; j++)
                    {
                        var element = 2*secondBigNumber.Dequeue() + addedValue;
                        //element *= 2;
                        addedValue = Math.DivRem(element, 10000000000, out var el);
                        if(i<div-1)
                        {
                            secondBigNumber.Enqueue(el);
                        }
                        else
                        {
                            secondBigNumberStack.Push(el);
                        }
                    }
                    if(addedValue>0)
                    {
                        if (i < div - 1)
                        {
                            secondBigNumber.Enqueue(addedValue);
                        }
                        else
                        {
                            secondBigNumberStack.Push(addedValue);
                        }
                    }
                }

                if(firstBigNumber.Count> secondBigNumberStack.Count)
                {
                    Console.WriteLine(loseAnswer);
                    return;
                }

                if (firstBigNumber.Count < secondBigNumberStack.Count)
                {
                    Console.WriteLine(winAnswer);
                    return;
                }

                var final = firstBigNumber.Count;
                for (int i=0;i< final; i++)
                {
                    var number1 = firstBigNumber.Dequeue();
                    var number2 = secondBigNumberStack.Pop();
                    if(number1<number2)
                    {
                        Console.WriteLine(winAnswer);
                        return;
                    }
                    if(number1>number2)
                    {
                        Console.WriteLine(loseAnswer);
                        return;
                    }
                }
                Console.WriteLine(winAnswer);
            }
            //Console.ReadKey();
        }
    }
}
