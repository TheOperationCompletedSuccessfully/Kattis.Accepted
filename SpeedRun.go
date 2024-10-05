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
buf_reader := bufio.NewReaderSize(os.Stdin, 524288)
buf_writer := bufio.NewWriterSize(os.Stdout, 256)
var n,g,i,startInterval,endInterval,minEnd,maxEnd int
data := make([]int,24001)
fmt.Fscanf(buf_reader,"%d %d\n", &g, &n)
minEnd = 24000
maxEnd = 0
for i=0;i<n;i++ {
fmt.Fscanf(buf_reader,"%d %d\n", &startInterval, &endInterval)
minEnd = int(math.Min(float64(endInterval),float64(minEnd)))
maxEnd = int(math.Max(float64(endInterval),float64(maxEnd)))
data[endInterval] = int(math.Max(float64(data[endInterval]),float64(startInterval)))
}

found:=1
for i=minEnd+1;i<=maxEnd&&found<g;i++ {
if data[i] >= minEnd {
found++
minEnd = i
}
}

if found<g {
buf_writer.WriteString("NO")
} else {
buf_writer.WriteString("YES")
}
buf_writer.Flush()
}