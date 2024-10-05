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
buf_reader := bufio.NewReaderSize(os.Stdin, 256)
buf_writer := bufio.NewWriterSize(os.Stdout, 32768)
var k int
var consonants = [21]int{98,99,100,102,103,104,106,107,108,109,110,112,113,114,115,116,118,119,120,121,122}
var vowels = [5]int{97,101,105,111,117}
fmt.Fscanf(buf_reader,"%d", &k)
index :=0
for i:=0;i<21&&index<k;i++ {
for j:=0;j<21&&index<k;j++ {
for v:=0;v<5&&index<k;v++ {
for c:=0;c<21&&index<k;c++ {
buf_writer.WriteString(fmt.Sprintf("%v%v%v%v\n",string(rune(consonants[i])),string(rune(consonants[j])),string(rune(vowels[v])),string(rune(consonants[c]))))
index++
}}}}

buf_writer.Flush()
}