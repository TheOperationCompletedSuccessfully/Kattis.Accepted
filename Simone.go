package main

import (
    "fmt"
    "os"
    "bufio"
    //"math"
    //"sort"
    //"strings"
    )
	
func main() {
buf_reader := bufio.NewReaderSize(os.Stdin, 128)
buf_writer := bufio.NewWriterSize(os.Stdout, 128)
var n,k,i,minEnd,n0, minIndex int

fmt.Fscanf(buf_reader,"%d %d\n", &n, &k)

data := make([]int, k)
fmt.Fscanf(buf_reader,"%d", &n0)
data[n0-1]++
minEnd = n
for i=1;i<n;i++ {
fmt.Fscanf(buf_reader," %d", &n0)
data[n0-1]++
}
i=0;
minIndex = 0;
for minEnd >0 && i<k {
if data[i] < minEnd {
minEnd = data[i]
minIndex = i;
}
i++
}
count:=0
for i=minIndex;i<k;i++ {
if i== minIndex {
count++
} else if data[i]==minEnd {
count++
} 
}

buf_writer.WriteString(fmt.Sprintf("%d\n",count))
for i=minIndex;i<k;i++ {
if i== minIndex {
buf_writer.WriteString(fmt.Sprintf("%d",i+1))
} else if data[i]==minEnd {
buf_writer.WriteString(fmt.Sprintf(" %d",i+1))
} 
}
buf_writer.Flush()

}


