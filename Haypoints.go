package main

import (
    "fmt"
    "os"
    "bufio"
    "math"
    )
    
func main() {
buf_reader := bufio.NewReaderSize(os.Stdin, 4270000)
var word string
var r rune
var d,cases,value, index,result, minLength,maxLength,wordLength int
fmt.Fscanf(buf_reader,"%d %d\n", &d,&cases)

dictionary := make(map[string]int)
maxLength = 0
minLength = 100
for i:=0; i<d; i++ {
fmt.Fscanf(buf_reader,"%s %d\n",&word,&value)
dictionary[word] = value
wordLength = len(word)
maxLength = int(math.Max(float64(maxLength),float64(wordLength)))
minLength = int(math.Min(float64(minLength),float64(wordLength)))
}
t:=0
ddata := make([]rune, 300)
for index < cases {

fmt.Fscanf(buf_reader,"%c",&r)

if r == rune(46) {
fmt.Println(result)
index++
result = 0
t = 0
} else {

if r>33 {
ddata[t] = r
t++
} else {
if t >= minLength && t <= maxLength{
element := string(ddata[0:t])
result += dictionary[element]
}
t = 0
} 

}

}


}