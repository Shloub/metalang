package main
import "fmt"
func testA(a bool, b bool) {
  if a {
      if b {
          fmt.Printf("A")
      } else {
          fmt.Printf("B")
      }
  } else if b {
      fmt.Printf("C")
  } else {
      fmt.Printf("D")
  }
}

func testB(a bool, b bool) {
  if a {
      fmt.Printf("A")
  } else if b {
      fmt.Printf("B")
  } else {
      fmt.Printf("C")
  }
}

func testC(a bool, b bool) {
  if a {
      if b {
          fmt.Printf("A")
      } else {
          fmt.Printf("B")
      }
  } else {
      fmt.Printf("C")
  }
}

func testD(a bool, b bool) {
  if a {
      if b {
          fmt.Printf("A")
      } else {
          fmt.Printf("B")
      }
      fmt.Printf("C")
  } else {
      fmt.Printf("D")
  }
}

func testE(a bool, b bool) {
  if a {
      if b {
          fmt.Printf("A")
      }
  } else {
      if b {
          fmt.Printf("C")
      } else {
          fmt.Printf("D")
      }
      fmt.Printf("E")
  }
}

func test(a bool, b bool) {
  testD(a, b)
  testE(a, b)
  fmt.Printf("\n")
}

func main() {
  test(true, true)
  test(true, false)
  test(false, true)
  test(false, false)
}

