#include <stdio.h>
#include <stdlib.h>

int main(void){
  int one = 3;
  int two = 3;
  int three = 5;
  int four = 4;
  int five = 4;
  int six = 3;
  int seven = 5;
  int eight = 5;
  int nine = 4;
  int ten = 3;
  int eleven = 6;
  int twelve = 6;
  int thirteen = 8;
  int fourteen = 8;
  int fifteen = 7;
  int sixteen = 7;
  int seventeen = 9;
  int eighteen = 8;
  int nineteen = 8;
  int twenty = 6;
  int thirty = 6;
  int forty = 5;
  int fifty = 5;
  int sixty = 5;
  int seventy = 7;
  int eighty = 6;
  int ninety = 6;
  int hundred = 7;
  int thousand = 8;
  printf("%d\n", one + two + three + four + five);
  int hundred_and = 10;
  int one_to_nine = one + two + three + four + five + six + seven + eight + nine;
  printf("%d\n", one_to_nine);
  int one_to_ten = one_to_nine + ten;
  int one_to_twenty = one_to_ten + eleven + twelve + thirteen + fourteen + fifteen + sixteen + seventeen + eighteen + nineteen + twenty;
  int one_to_thirty = one_to_twenty + twenty * 9 + one_to_nine + thirty;
  int one_to_forty = one_to_thirty + thirty * 9 + one_to_nine + forty;
  int one_to_fifty = one_to_forty + forty * 9 + one_to_nine + fifty;
  int one_to_sixty = one_to_fifty + fifty * 9 + one_to_nine + sixty;
  int one_to_seventy = one_to_sixty + sixty * 9 + one_to_nine + seventy;
  int one_to_eighty = one_to_seventy + seventy * 9 + one_to_nine + eighty;
  int one_to_ninety = one_to_eighty + eighty * 9 + one_to_nine + ninety;
  int one_to_ninety_nine = one_to_ninety + ninety * 9 + one_to_nine;
  printf("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + hundred_and * 9 * 99 + hundred * 9 + one + thousand);
  return 0;
}


