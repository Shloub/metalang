#include <stdio.h>
#include <stdlib.h>

int main(void) {
    printf("%d\n", 3 + 16);
    int one_to_nine = 3 + 33;
    printf("%d\n", one_to_nine);
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
    printf("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11);
    return 0;
}


