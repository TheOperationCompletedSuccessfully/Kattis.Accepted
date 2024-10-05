package main

import (
    "fmt"
    "os"
    "bufio"
    "math"
    //"sort"
    //"strings"
    )
	
func main() {
buf_reader := bufio.NewReaderSize(os.Stdin, 1000000)
buf_writer := bufio.NewWriterSize(os.Stdout, 256)

var n,scoreData,previous,yscore,nscore int
var s string
var score,total,currentStreak,totalStreak map[int]int

fmt.Fscanf(buf_reader,"%d\n", &n)
score = map[int]int{
    1: 0,
    -1: 0,
}
total = map[int]int{
    1: 0,
    -1: 0,
}
currentStreak = map[int]int{
    1: 0,
    -1: 0,
}
totalStreak = map[int]int{
    1: 0,
    -1: 0,
}
for j := 0; j < n; j++ {
fmt.Fscanf(buf_reader,"%s\n", &s)
firstCharacter:= s[0:1]

if firstCharacter=="Y" {
scoreData = 1
} else {
scoreData = -1
}

scoreDData  := 0-scoreData
old := score[scoreData]
old1 := score[scoreDData]
ns := old+int(math.Abs(float64(scoreData)))
newScore := ns - old1

if newScore>total[scoreData] {
total[scoreData] = newScore
} 

score[scoreData] = ns

if previous==scoreData {
currentStreak[scoreData]++

} else {
previous = scoreData
currentStreak[scoreData] = 1
}

if totalStreak[scoreData]<currentStreak[scoreData] {
totalStreak[scoreData] = currentStreak[scoreData]
}



}

ys := total[1]-total[-1]
if ys == 0 {
yscore = 0
} else {
yscore = ys/int(math.Abs(float64(ys)))
}

ns := totalStreak[1]-totalStreak[-1]
if ns == 0 {
nscore = 0
} else {
nscore = ns/int(math.Abs(float64(ns)))
}

if yscore == nscore {
buf_writer.WriteString("Agree\n")

} else {
buf_writer.WriteString("Disagree\n")
}
buf_writer.Flush()


}