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
buf_reader := bufio.NewReaderSize(os.Stdin, 4096)
buf_writer := bufio.NewWriterSize(os.Stdout, 256)
var n,n0,i int
fmt.Fscanf(buf_reader,"%d\n", &n)

if(n==1) {
fmt.Fscanf(buf_reader,"%d", &n0)
n0 = n0/2
buf_writer.WriteString(fmt.Sprintf("%d\n",n0))
} else {

data := make([]int,1000)
minValue :=1000
sum:=0
for i=0;i<n;i++ {
fmt.Fscanf(buf_reader,"%d ", &n0)
minValue=int(math.Min(float64(n0),float64(minValue)))
sum+=n0
data[n0]++
}
n2 := 1+n/2
n3:=0
sum2:=0
for i=minValue;i<1000&&n3<n2;i+=2 {
if(data[i]>0){
toTake := int(math.Min(float64(n2-n3),float64(data[i])))
n3+=toTake

sum2+=toTake*(1+i/2)
}
}
result:=sum-sum2;
buf_writer.WriteString(fmt.Sprintf("%d\n",result))
}
buf_writer.Flush()
}
