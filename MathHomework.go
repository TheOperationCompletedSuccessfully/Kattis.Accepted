package main

import (
    "fmt"
    "math"
    "os"
    "bufio"
    )
    
func main() {
buf_reader := bufio.NewReaderSize(os.Stdin, 50)
buf_writer := bufio.NewWriterSize(os.Stdout, 250*250*250*13)

var b,c,d,l int
fmt.Fscanf(buf_reader, "%d %d %d %d\n",&b,&c,&d,&l)

if l < int(math.Min(float64(b),math.Min(float64(c),float64(d)))) && l>0 {
buf_writer.WriteString("impossible")
} else {
found := false
for i:=0; i<=l; i++ {
for j:=0; j <= l-i*b; j++ {
for k:=0; k <= l-i*b-j*c; k++ {
if l == i*b + j*c + k*d {
found = true
buf_writer.WriteString(fmt.Sprintf("%d %d %d\n",i,j,k))
}
}
}
}

if !found {
buf_writer.WriteString("impossible")
}

}
buf_writer.Flush()
}