var util = require("util");
util.print(3 + 16, "\n");
var one_to_nine = 3 + 33;
util.print(one_to_nine, "\n");
var one_to_ten = one_to_nine + 3;
var one_to_twenty = one_to_ten + 73;
var one_to_thirty = one_to_twenty + 6 * 9 + one_to_nine + 6;
var one_to_forty = one_to_thirty + 6 * 9 + one_to_nine + 5;
var one_to_fifty = one_to_forty + 5 * 9 + one_to_nine + 5;
var one_to_sixty = one_to_fifty + 5 * 9 + one_to_nine + 5;
var one_to_seventy = one_to_sixty + 5 * 9 + one_to_nine + 7;
var one_to_eighty = one_to_seventy + 7 * 9 + one_to_nine + 6;
var one_to_ninety = one_to_eighty + 6 * 9 + one_to_nine + 6;
var one_to_ninety_nine = one_to_ninety + 6 * 9 + one_to_nine;
util.print(one_to_ninety_nine, "\n", 100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11, "\n");

