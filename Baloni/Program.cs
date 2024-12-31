using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

using (var scanner = new ZevaScanner(2 ^ 23, 2 ^ 7))
{
    var n = scanner.NextUInt();
    var choices = new Dictionary<int, int>();
    for(int i=0;i<n;i++)
    {
        var next = scanner.NextUInt(i==0);
        if (choices.ContainsKey(next))
        {
            if (choices[next] == 1)
            {
                choices.Remove(next);
            }
            else
            {
                choices[next]--;
            }
        }
            var newKey = next - 1;
            if(choices.ContainsKey(newKey))
            {
                choices[newKey]++;
            }
            else
            {
                choices.Add(newKey, 1);
            }
    }
    var result = choices.Sum(kvp => kvp.Value);
    scanner.streamWriter.WriteLine(result);
    scanner.streamWriter.Flush();
}