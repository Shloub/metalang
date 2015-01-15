package main
import "fmt"
func main() {
  var one int = 3
  var two int = 3
  var three int = 5
  var four int = 4
  var five int = 4
  var six int = 3
  var seven int = 5
  var eight int = 5
  var nine int = 4
  var ten int = 3
  var eleven int = 6
  var twelve int = 6
  var thirteen int = 8
  var fourteen int = 8
  var fifteen int = 7
  var sixteen int = 7
  var seventeen int = 9
  var eighteen int = 8
  var nineteen int = 8
  var twenty int = 6
  var thirty int = 6
  var forty int = 5
  var fifty int = 5
  var sixty int = 5
  var seventy int = 7
  var eighty int = 6
  var ninety int = 6
  var hundred int = 7
  var thousand int = 8
  fmt.Printf("%d\n", one + two + three + four + five);
  var hundred_and int = 10
  var one_to_nine int = one + two + three + four + five + six + seven + eight + nine
  fmt.Printf("%d\n", one_to_nine);
  var one_to_ten int = one_to_nine + ten
  var one_to_twenty int = one_to_ten + eleven + twelve + thirteen + fourteen + fifteen + sixteen + seventeen + eighteen + nineteen + twenty
  var one_to_thirty int = one_to_twenty + twenty * 9 + one_to_nine + thirty
  var one_to_forty int = one_to_thirty + thirty * 9 + one_to_nine + forty
  var one_to_fifty int = one_to_forty + forty * 9 + one_to_nine + fifty
  var one_to_sixty int = one_to_fifty + fifty * 9 + one_to_nine + sixty
  var one_to_seventy int = one_to_sixty + sixty * 9 + one_to_nine + seventy
  var one_to_eighty int = one_to_seventy + seventy * 9 + one_to_nine + eighty
  var one_to_ninety int = one_to_eighty + eighty * 9 + one_to_nine + ninety
  var one_to_ninety_nine int = one_to_ninety + ninety * 9 + one_to_nine
  fmt.Printf("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + hundred_and * 9 * 99 + hundred * 9 + one + thousand);
}

