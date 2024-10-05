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
buf_reader := bufio.NewReaderSize(os.Stdin, 512)
buf_writer := bufio.NewWriterSize(os.Stdout, 256)
var laptopLength,laptopHeight,k,l,h,a,b int

fmt.Fscanf(buf_reader,"%d", &laptopLength)
fmt.Fscanf(buf_reader," %d", &laptopHeight)
fmt.Fscanf(buf_reader," %d\n", &k)

laptop := make([][]rune, laptopLength)
for i := range laptop {
    laptop[i] = make([]rune, laptopHeight)
}

for i:=0;i<laptopLength;i++ {
for j:=0;j<laptopHeight;j++ {
laptop[i][j] = rune(95)
}
}

for i:=0;i<k;i++ {
fmt.Fscanf(buf_reader,"%d", &l)
fmt.Fscanf(buf_reader,"%d", &h)
fmt.Fscanf(buf_reader,"%d", &a)
fmt.Fscanf(buf_reader,"%d \n", &b)

for column:=a;column<int(math.Min(float64(a+l),float64(laptopLength)));column++ {
for row:=b;row<int(math.Min(float64(b+h),float64(laptopHeight)));row++ {
laptop[column][row] = rune(97+i)
}
}
}

for row:=0;row<laptopHeight;row++ {
for column:=0;column<laptopLength;column++ {
buf_writer.WriteString(fmt.Sprintf("%v",string(laptop[column][row])))
}
buf_writer.WriteString("\n")
}
buf_writer.Flush()
}