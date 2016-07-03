
io.write(string.format("%d\n", 3 + 16))
local one_to_nine = 3 + 33
io.write(string.format("%d\n", one_to_nine))
local one_to_ten = one_to_nine + 3
local one_to_twenty = one_to_ten + 73
local one_to_thirty = one_to_twenty + 6 * 9 + one_to_nine + 6
local one_to_forty = one_to_thirty + 6 * 9 + one_to_nine + 5
local one_to_fifty = one_to_forty + 5 * 9 + one_to_nine + 5
local one_to_sixty = one_to_fifty + 5 * 9 + one_to_nine + 5
local one_to_seventy = one_to_sixty + 5 * 9 + one_to_nine + 7
local one_to_eighty = one_to_seventy + 7 * 9 + one_to_nine + 6
local one_to_ninety = one_to_eighty + 6 * 9 + one_to_nine + 6
local one_to_ninety_nine = one_to_ninety + 6 * 9 + one_to_nine
io.write(string.format("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11))
