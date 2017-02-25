package main
import "fmt"

/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/
func main() {
  var input byte = ' '
  _  = input
  current_pos := 500
  var mem []int = make([]int, 1000)
  for i := 0; i < 1000; i++ {
      mem[i] = 0
  }
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  current_pos++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  mem[current_pos]++
  for mem[current_pos] != 0 {
      mem[current_pos]--
      current_pos--
      mem[current_pos]++
      fmt.Printf("%c", (byte)(mem[current_pos]))
      current_pos++
  }
}

