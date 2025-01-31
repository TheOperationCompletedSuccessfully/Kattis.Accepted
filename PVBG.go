package main

import (
    "fmt"
    "math"
    "os"
    "bufio"
    )
    
func main() {
buf_reader := bufio.NewReader(os.Stdin)
buf_writer := bufio.NewWriter(os.Stdout)

var n int
var next,result float64
fmt.Fscanf(buf_reader, "%d\n",&n)
result = 1000000000

for i:=0; i<=n; i++ {
fmt.Fscanf(buf_reader, "%f",&next)
result = math.Min(next,result)
if next == 1 {
i = n
}
}

r := int(result)
buf_writer.WriteString(fmt.Sprintf("%d\n",r+1))

buf_writer.Flush()
}