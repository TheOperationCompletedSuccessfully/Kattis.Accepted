package main

import (
    "fmt"
    "math"
    "sort"
    "strconv"
    "os"
    "bufio"
    )
    
func main() {
buf_reader := bufio.NewReaderSize(os.Stdin, 2097152)
buf_writer := bufio.NewWriterSize(os.Stdout, 2097152)
row := make([]int, 26)
col := make([]int, 26)
pad := make([]string, 8)

var caseNumber,spellChecker,distance,counter int
var refWord,s,w string

row[0]= 2
row[1]= 3
row[2]= 3
row[3]= 2
row[4]= 1
row[5]= 2
row[6]= 2
row[7]= 2
row[8]= 1
row[9]= 2
row[10]= 2
row[11]= 2
row[12]= 3
row[13]= 3
row[14]= 1
row[15]= 1
row[16]= 1
row[17]= 1
row[18]= 2
row[19]= 1
row[20]= 1
row[21]= 3
row[22]= 1
row[23]= 3
row[24]= 1
row[25]= 3

col[0]= 1
col[1]= 5
col[2]= 3
col[3]= 3
col[4]= 3
col[5]= 4
col[6]= 5
col[7]= 6
col[8]= 8
col[9]= 7
col[10]= 8
col[11]= 9
col[12]= 7
col[13]= 6
col[14]= 9
col[15]= 10
col[16]= 1
col[17]= 4
col[18]= 2
col[19]= 5
col[20]= 7
col[21]= 4
col[22]= 2
col[23]= 2
col[24]= 6
col[25]= 1

pad[0]= ""
pad[1]= "0"
pad[2]= "00"
pad[3]= "000"
pad[4]= "0000"
pad[5]= "00000"
pad[6]= "000000"
pad[7]= "0000000"

fmt.Fscanf(buf_reader, "%d\n",&caseNumber)
for i:=0;i<caseNumber; i++ {
fmt.Fscanf(buf_reader, "%s %d",&refWord,&spellChecker)
fmt.Fscanf(buf_reader, "%s\n",&s)
results := make(map[string]int)
for j:=0; j<spellChecker; j++ {
fmt.Fscanf(buf_reader, "%s\n", &w)
distance = 0
refBytes := []byte(refWord)
counter = 0
for _, r := range w {
distance += int(math.Abs(float64(col[r-97]-col[refBytes[counter]-97])) + math.Abs(float64(row[r-97]-row[refBytes[counter]-97])))
counter++
}
var myWidth int
if distance < 10 {
myWidth = 0
} else {
myWidth = 1 + int(math.Log10(float64(distance)))
}

results[pad[7-myWidth] + strconv.Itoa(distance) + w]=distance


}

keys := make([]string, 0, len(results))
for k := range results {
    keys = append(keys, k)
}
sort.Strings(keys)
for _, value := range keys {
var b int
var ss string
if _, err := fmt.Sscanf(value, "%d%s", &b, &ss); err == nil {
    //fmt.Println(ss, results[value])
    buf_writer.WriteString(fmt.Sprintf("%s %d\n",ss,results[value]))
}
    
}
}
buf_writer.Flush()
}