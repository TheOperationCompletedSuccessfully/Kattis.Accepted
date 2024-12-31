using System;
using System.Collections.Generic;
using System.Linq;
using Zeva;

namespace S10
{
    class Program
    {
        static void Main(string[] args)
        {
            using var scanner = new ZevaScanner(2 ^ 22, 2 ^ 7);
            var parkingSpots = scanner.NextUInt();
            var companies = scanner.NextUInt();
            var companyInfo = new Dictionary<int, CompanyInfo>();
            var garage = new Garage { Capacity = parkingSpots };
            for (int i = 0; i < companies; i++)
            {
                var companySpots = scanner.NextUInt(true);
                var companyPlates = scanner.NextUInt();
                garage.CompanyInfo.Add(i, new CompanyInfo { Spots = companySpots });
                for (int j = 0; j < companyPlates; j++)
                {
                    var nextPlate = scanner.NextString(48);
                    garage.AllRegisteredPlates.Add(nextPlate, i);
                }
            }
            var photos = scanner.NextUInt(true);

            for (int i = 0; i < photos; i++)
            {
                var nextPhoto = scanner.NextString(48);
                garage.CarEvent(nextPhoto);
            }
            var culprits = garage.Illegals.Order().ToList();
            scanner.streamWriter.WriteLine(culprits.Count);
            foreach (var culprit in culprits)
            {
                scanner.streamWriter.WriteLine(culprit);
            }
            scanner.streamWriter.Flush();
        }
    }

    class Garage
    {
        public int Capacity { get; set; }
        public HashSet<string> ParkedInside = new HashSet<string>();
        public HashSet<string> ParkedOutside = new HashSet<string>();
        public Dictionary<string, int> AllRegisteredPlates = new Dictionary<string, int>();
        public HashSet<string> Illegals = new HashSet<string>();
        public Dictionary<int, CompanyInfo> CompanyInfo = new Dictionary<int, CompanyInfo>();

        public void CarEvent(string plate)
        {
            if (ParkedInside.Contains(plate))
            {
                ParkedInside.Remove(plate);
                if (AllRegisteredPlates.ContainsKey(plate))
                {
                    CompanyInfo[AllRegisteredPlates[plate]].Parked.Remove(plate);
                }
                return;
            }
            if (ParkedOutside.Contains(plate))
            {
                ParkedOutside.Remove(plate);
                return;
            }

            if (!AllRegisteredPlates.ContainsKey(plate))
            {
                Illegals.Add(plate);
            }

            if (ParkedInside.Count < Capacity)
            {
                ParkedInside.Add(plate);

                if (AllRegisteredPlates.ContainsKey(plate))
                {
                    CompanyInfo[AllRegisteredPlates[plate]].Parked.Add(plate);
                    if (CompanyInfo[AllRegisteredPlates[plate]].Parked.Count > CompanyInfo[AllRegisteredPlates[plate]].Spots)
                    {
                        Illegals.Add(plate);
                    }
                }
                return;
            }
            else
            {
                ParkedOutside.Add(plate);
                Illegals.Add(plate);
            }
        }
    }

    class CompanyInfo
    {
        public int Spots { get; set; }
        public HashSet<string> Parked = new HashSet<string>();
    }
}