object euler17
{
  
  
  def main(args : Array[String])
  {
    printf("%d\n", 3 + 3 + 5 + 4 + 4);
    var one_to_nine: Int = 3 + 3 + 5 + 4 + 4 + 3 + 5 + 5 + 4;
    printf("%d\n", one_to_nine);
    var one_to_ten: Int = one_to_nine + 3;
    var one_to_twenty: Int = one_to_ten + 6 + 6 + 8 + 8 + 7 + 7 + 9 + 8 + 8 + 6;
    var one_to_thirty: Int = one_to_twenty + 6 * 9 + one_to_nine + 6;
    var one_to_forty: Int = one_to_thirty + 6 * 9 + one_to_nine + 5;
    var one_to_fifty: Int = one_to_forty + 5 * 9 + one_to_nine + 5;
    var one_to_sixty: Int = one_to_fifty + 5 * 9 + one_to_nine + 5;
    var one_to_seventy: Int = one_to_sixty + 5 * 9 + one_to_nine + 7;
    var one_to_eighty: Int = one_to_seventy + 7 * 9 + one_to_nine + 6;
    var one_to_ninety: Int = one_to_eighty + 6 * 9 + one_to_nine + 6;
    var one_to_ninety_nine: Int = one_to_ninety + 6 * 9 + one_to_nine;
    printf("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 3 + 8);
  }
  
}

