: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: main
  100 { lim }
  lim lim 1 + * 2 // { sum }
  sum sum * { carressum }
  lim lim 1 + * 2 lim * 1 + * 6 // { sumcarres }
  carressum sumcarres - s>d 0 d.r
  ;
main
BYE

