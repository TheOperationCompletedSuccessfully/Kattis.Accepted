using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;


namespace DivideBy100
{
    class Program
    {
        static void Main(string[] args)
        {

            using var scanner = new ZevaScanner();

            var firstNumber = scanner.NextString(48);
            

            var nextCh = scanner.streamReader.Peek();
            while (nextCh < 49)
            {
                nextCh = scanner.streamReader.Read();
            }
            int posEnd = firstNumber.Length - 1;
            int posStart = firstNumber.Length - 1;
            bool writeStarted = false;
            bool metLessThatZero = false;
            nextCh = scanner.streamReader.Read();
            while(nextCh >=48)
            {
                
                if(posEnd>=0&&posStart>=0)
                {
                    var d = firstNumber[posEnd];
                    
                    if(d==48&&nextCh==48&&!writeStarted)
                    {
                        //do nothing 2 zeroes
                        nextCh = scanner.streamReader.Read();
                        posEnd--;
                        posStart--;
                        continue;
                    }
                    if(nextCh==48)
                    {
                        posStart--;
                        writeStarted = true;
                    }

                }
                else if(!metLessThatZero)
                {
                    metLessThatZero = true;
                    scanner.streamWriter.Write('0');
                    scanner.streamWriter.Write('.');
                    scanner.streamWriter.Write('0');
                }
                else
                {
                    scanner.streamWriter.Write('0');
                }
                nextCh = scanner.streamReader.Read();
            }
            if(posStart==-1 && !metLessThatZero)
            {
                scanner.streamWriter.Write("0.");
            }
            
            if(posStart>=0)
            {
                scanner.streamWriter.Write(firstNumber[..(posStart+1)]);
                
                if(writeStarted)
                {
                    scanner.streamWriter.Write(".");
                }
            }
            if(writeStarted)
            {
                
                scanner.streamWriter.WriteLine(firstNumber[Math.Max((posStart+1),0)..(posEnd+1)]);
            }
            scanner.streamWriter.Flush();

        }
    }
}