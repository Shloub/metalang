package main
import "fmt"
func main() {
  /*
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
*/
  var p []int = make([]int, 10)
  for i := 0 ; i < 10; i++ {
    p[i] = i * i * i * i * i;
  }
  var sum int = 0
  for a := 0 ; a <= 9; a++ {
    for b := 0 ; b <= 9; b++ {
        for c := 0 ; c <= 9; c++ {
            for d := 0 ; d <= 9; d++ {
                for e := 0 ; e <= 9; e++ {
                    for f := 0 ; f <= 9; f++ {
                        var s int = p[a] + p[b] + p[c] + p[d] + p[e] + p[f]
                          var r int = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000
                          if s == r && r != 1 {
                            fmt.Printf("%d%d%d%d%d%d %d\n", f, e, d, c, b, a, r);
                              sum += r;
                          }
                      }
                  }
              }
          }
      }
  }
  fmt.Printf("%d", sum);
}

