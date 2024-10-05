using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zeva;

namespace OpenSource
{
   class Program
   {
      static void Main(string[] args)
      {
         using (var scanner = new ZevaScanner())
         {
            scanner.Initialize(2 ^ 21, 2 ^ 7);

            var item = scanner.NextString(32);
            
            do
            {
               var projects = new List<Project>();
               var students = new Dictionary<string, Project>();
               var blackList = new HashSet<string>();
               Project project = null;

               do
               {
                  if(item.ToUpper().Equals(item))
                  {
                     project = new Project { Name = item };
                     projects.Add(project);
                  }
                  else
                  {
                     if (!blackList.Contains(item))
                     {
                        if (students.ContainsKey(item) && students[item] != project)
                        {
                           blackList.Add(item);
                           students[item].Students.Remove(item);
                           students.Remove(item);
                        }
                        else
                        if(!students.ContainsKey(item))
                        {
                           students.Add(item, project);
                           project.Students.Add(item);
                        }
                     }
                  }
                  item = scanner.NextString(32);
               }
               while (item != "1");
               var results = projects.OrderByDescending(p => p.Students.Count).ThenBy(pr => pr.Name);
               foreach(var pr in results)
               {
                  scanner.streamWriter.WriteLine($"{pr.Name} {pr.Students.Count}");
               }

               item = scanner.NextString(32);
            }
            while (item != "0");
            scanner.streamWriter.Flush();
         }
         //Console.ReadKey();
      }

      public class Project
      {
         public string Name { get; set; }
         public HashSet<string> Students = new HashSet<string>();
      }

      
   }
}
