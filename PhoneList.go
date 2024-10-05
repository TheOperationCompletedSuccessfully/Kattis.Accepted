package main

import (
    "fmt"
    "os"
    "bufio"
    //"math"
    //"sort"
    //"strings"
    )

type triNode struct {
    edges [10]*triNode
    isEnd bool
	error bool
}

type tri struct {
    root *triNode
}

func initTri() *tri {
    return &tri{
        root: &triNode{},
    }
}

func (t *tri) insert(phoneNumber string) {
    phoneNumberLength := len(phoneNumber)
    node := t.root
    for i := 0; i < phoneNumberLength && !t.root.error; i++ {
        index := phoneNumber[i] - '0'
        if node.edges[index] == nil {
            node.edges[index] = &triNode{}
        }
		if(node.edges[index].isEnd) {
		t.root.error = true
		}
        node = node.edges[index]
    }
    node.isEnd = true
	for i:=0; i<10&&!t.root.error; i++ {
		if node.edges[i] != nil {
		t.root.error = true
		}
	}
}

func main() {
buf_reader := bufio.NewReaderSize(os.Stdin, 4800000)
buf_writer := bufio.NewWriterSize(os.Stdout, 256)
var n,cases int
var s string
fmt.Fscanf(buf_reader,"%d\n", &cases)
    
for c :=0; c < cases; c++ {  
tri := initTri() 
fmt.Fscanf(buf_reader,"%d\n", &n) 
    for j := 0; j < n; j++ {
		fmt.Fscanf(buf_reader,"%s\n", &s)
		if !tri.root.error {
        tri.insert(s)
		}
    }
	if(tri.root.error){
	buf_writer.WriteString("NO\n")
	} else {
	buf_writer.WriteString("YES\n")
	}
}
buf_writer.Flush()
}