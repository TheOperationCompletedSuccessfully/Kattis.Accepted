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
buf_reader := bufio.NewReaderSize(os.Stdin, 128)
buf_writer := bufio.NewWriterSize(os.Stdout, 128)
var n,n0,i,n1,n2,minEnd,index int
fmt.Fscanf(buf_reader,"%d\n", &n)
fmt.Fscanf(buf_reader,"%d ", &n0)
fmt.Fscanf(buf_reader,"%d ", &n1)
minEnd = 1000000
index = 1
for i=0;i<n-2;i++ {
if i<n {
fmt.Fscanf(buf_reader,"%d ", &n2)
} else {
fmt.Fscanf(buf_reader,"%d", &n2)
}
candidate := int(math.Max(float64(n0),float64(n2)))
if candidate < minEnd {
minEnd = candidate
index = i+1
}
n0 = n1
n1 = n2
}

buf_writer.WriteString(fmt.Sprintf("%d %d",index,minEnd))
buf_writer.Flush()
}