let () =
begin
  Printf.printf "%d\n" (3 + 16);
  let one_to_nine = 3 + 33 in
  Printf.printf "%d\n" one_to_nine;
  let one_to_ten = one_to_nine + 3 in
  let one_to_twenty = one_to_ten + 73 in
  let one_to_thirty = one_to_twenty + 6 * 9 + one_to_nine + 6 in
  let one_to_forty = one_to_thirty + 6 * 9 + one_to_nine + 5 in
  let one_to_fifty = one_to_forty + 5 * 9 + one_to_nine + 5 in
  let one_to_sixty = one_to_fifty + 5 * 9 + one_to_nine + 5 in
  let one_to_seventy = one_to_sixty + 5 * 9 + one_to_nine + 7 in
  let one_to_eighty = one_to_seventy + 7 * 9 + one_to_nine + 6 in
  let one_to_ninety = one_to_eighty + 6 * 9 + one_to_nine + 6 in
  let one_to_ninety_nine = one_to_ninety + 6 * 9 + one_to_nine in
  Printf.printf "%d\n%d\n" one_to_ninety_nine (100 * one_to_nine + one_to_ninety_nine * 10 + 10 * 9 * 99 + 7 * 9 + 11)
end
 