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
buf_reader := bufio.NewReaderSize(os.Stdin, 256)
buf_writer := bufio.NewWriterSize(os.Stdout, 256)
var p,a,b,c,d,n,i int
var max,result,next,akb,ckd float64

fmt.Fscanf(buf_reader,"%d %d %d %d %d %d\n", &p,&a,&b,&c,&d,&n)
max = float64(-4*p);

for i=1;i<=n;i++ {
akb = float64(a*i+b)
ckd = float64(c*i+d)
next = float64(p)*(math.Sin(akb)+math.Cos(ckd)+2)
//buf_writer.WriteString(fmt.Sprintf("%f\n",next))
result = math.Max(result,max - next)
max = math.Max(max,next)

}
result = math.Max(result,max - next)

buf_writer.WriteString(fmt.Sprintf("%f\n",result))
buf_writer.Flush()
}