package main
import "fmt"
func is_leap(year int) bool{
  return year % 400 == 0 || year % 100 != 0 && year % 4 == 0
}

func ndayinmonth(month int, year int) int{
  if month == 0 {
    return 31
  } else if month == 1 {
    if is_leap(year) {
        return 29
      } else {
        return 28
      }
  } else if month == 2 {
    return 31
  } else if month == 3 {
    return 30
  } else if month == 4 {
    return 31
  } else if month == 5 {
    return 30
  } else if month == 6 {
    return 31
  } else if month == 7 {
    return 31
  } else if month == 8 {
    return 30
  } else if month == 9 {
    return 31
  } else if month == 10 {
    return 30
  } else if month == 11 {
    return 31
  }           
  return 0
}

func main() {
  var month int = 0
  var year int = 1901
  var dayofweek int = 1
  /* 01-01-1901 : mardi */
  var count int = 0
  for year != 2001{
    var ndays int = ndayinmonth(month, year)
    dayofweek = (dayofweek + ndays) % 7;
    month ++;
    if month == 12 {
      month = 0;
        year ++;
    }
    if dayofweek % 7 == 6 {
      count ++;
    }
  }
  fmt.Printf("%d\n", count);
}

