package main

import (
    "fmt"
    "os"
    "bufio"
    )
    
func main() {
buf_reader := bufio.NewReaderSize(os.Stdin, 4000010)
var n,m,ii,jj int

fmt.Fscanf(buf_reader, "%d ", &n)
fmt.Fscanf(buf_reader, "%d\n",&m)


data := make(map[int]int)

for i:=0; i<m; i++ {
fmt.Fscanf(buf_reader, "%d ", &ii)
fmt.Fscanf(buf_reader, "%d\n", &jj)
data[ii-1] = data[ii-1]+1
data[jj-1] = data[jj-1]+1

}
for i:=0;i<n;i++{
value:=data[i]-i-1
if(i<n-1) {
fmt.Print(value)
fmt.Print(" ")
} else {
fmt.Println(value)
}
}

}