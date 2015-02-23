let () =
begin
  let one = 3 in
  let two = 3 in
  let three = 5 in
  let four = 4 in
  let five = 4 in
  let six = 3 in
  let seven = 5 in
  let eight = 5 in
  let nine = 4 in
  let ten = 3 in
  let eleven = 6 in
  let twelve = 6 in
  let thirteen = 8 in
  let fourteen = 8 in
  let fifteen = 7 in
  let sixteen = 7 in
  let seventeen = 9 in
  let eighteen = 8 in
  let nineteen = 8 in
  let twenty = 6 in
  let thirty = 6 in
  let forty = 5 in
  let fifty = 5 in
  let sixty = 5 in
  let seventy = 7 in
  let eighty = 6 in
  let ninety = 6 in
  let hundred = 7 in
  let thousand = 8 in
  Printf.printf "%d\n" (one + two + three + four + five);
  let hundred_and = 10 in
  let one_to_nine = one + two + three + four + five + six + seven + eight + nine in
  Printf.printf "%d\n" one_to_nine;
  let one_to_ten = one_to_nine + ten in
  let one_to_twenty = one_to_ten + eleven + twelve + thirteen + fourteen + fifteen + sixteen + seventeen + eighteen + nineteen + twenty in
  let one_to_thirty = one_to_twenty + twenty * 9 + one_to_nine + thirty in
  let one_to_forty = one_to_thirty + thirty * 9 + one_to_nine + forty in
  let one_to_fifty = one_to_forty + forty * 9 + one_to_nine + fifty in
  let one_to_sixty = one_to_fifty + fifty * 9 + one_to_nine + sixty in
  let one_to_seventy = one_to_sixty + sixty * 9 + one_to_nine + seventy in
  let one_to_eighty = one_to_seventy + seventy * 9 + one_to_nine + eighty in
  let one_to_ninety = one_to_eighty + eighty * 9 + one_to_nine + ninety in
  let one_to_ninety_nine = one_to_ninety + ninety * 9 + one_to_nine in
  Printf.printf "%d\n%d\n" one_to_ninety_nine (100 * one_to_nine +
                                                one_to_ninety_nine * 10 +
                                                hundred_and * 9 * 99 + hundred *
                                                9 + one + thousand)
end
 