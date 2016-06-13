package main
import "fmt"
func result(sum int, t []int, maxIndex int, cache [][]int) int{
  if cache[sum][maxIndex] != 0 {
      return cache[sum][maxIndex]
  }else {
      if sum == 0 || maxIndex == 0 {
          return 1
      }else {
          out0 := 0
          div := sum / t[maxIndex]
          for i := 0; i <= div; i += 1 {
              out0 += result(sum - i * t[maxIndex], t, maxIndex - 1, cache)
          }
          cache[sum][maxIndex] = out0
          return out0
      }
  }
}

func main() {
  var t []int = make([]int, 8)
  for i := 0; i < 8; i += 1 {
      t[i] = 0
  }
  t[0] = 1
  t[1] = 2
  t[2] = 5
  t[3] = 10
  t[4] = 20
  t[5] = 50
  t[6] = 100
  t[7] = 200
  var cache [][]int = make([][]int, 201)
  for j := 0; j < 201; j += 1 {
      var o []int = make([]int, 8)
      for k := 0; k < 8; k += 1 {
          o[k] = 0
      }
      cache[j] = o
  }
  fmt.Printf("%d", result(200, t, 7, cache))
}

