import java.util.*;

public class euler17
{
  
  
  public static void main(String args[])
  {
    System.out.printf("%d\n", 3 + 16);
    int one_to_nine = 3 + 33;
    System.out.printf("%d\n", one_to_nine);
    int one_to_ten = one_to_nine + 3;
    int one_to_twenty = one_to_ten + 73;
    int one_to_thirty = one_to_twenty + 6 * 9 + one_to_nine + 6;
    int one_to_forty = one_to_thirty + 6 * 9 + one_to_nine + 5;
    int one_to_fifty = one_to_forty + 5 * 9 + one_to_nine + 5;
    int one_to_sixty = one_to_fifty + 5 * 9 + one_to_nine + 5;
    int one_to_seventy = one_to_sixty + 5 * 9 + one_to_nine + 7;
    int one_to_eighty = one_to_seventy + 7 * 9 + one_to_nine + 6;
    int one_to_ninety = one_to_eighty + 6 * 9 + one_to_nine + 6;
    int one_to_ninety_nine = one_to_ninety + 6 * 9 + one_to_nine;
    System.out.printf("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11);
  }
  
}

