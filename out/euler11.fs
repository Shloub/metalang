VARIABLE buffer-index
1000 buffer-index !
VARIABLE NEOF
1 NEOF !
VARIABLE buffer-max
0 buffer-max !
create bufferc 128 allot
: next-char
  buffer-index @ 1 + buffer-index !
  buffer-index @ buffer-max @ > IF
    0 buffer-index !
    bufferc 128 stdin read-line DROP -1 = NEOF ! buffer-max !
    10 bufferc buffer-max @ + !
  THEN ;
: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;
: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT ;
: read-int
  [char] - current-char = IF -1 next-char ELSE 1 THEN
  0 BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT * ;
: find0 recursive { n m x y dx dy }
  x 0 < x 20 = OR y 0 < OR y 20 = OR
  IF
    1 NEGATE exit
  ELSE
    n 0 =
    IF
      1 exit
    ELSE
      m y cells + @ x cells + @ n 1 - m x dx + y dy + dx dy find0 * exit
    THEN
  THEN
;

struct
  cell% field ->tuple_int_int_field_0
  cell% field ->tuple_int_int_field_1
end-struct tuple_int_int%

: main
  HERE 8 cells allot { directions }
  8 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i 0 =
    IF
      tuple_int_int% %allot { c }
      0 c ->tuple_int_int_field_0 !
      1 c ->tuple_int_int_field_1 !
      c directions i cells + !
    ELSE
      i 1 =
      IF
        tuple_int_int% %allot { d }
        1 d ->tuple_int_int_field_0 !
        0 d ->tuple_int_int_field_1 !
        d directions i cells + !
      ELSE
        i 2 =
        IF
          tuple_int_int% %allot { e }
          0 e ->tuple_int_int_field_0 !
          1 NEGATE e ->tuple_int_int_field_1 !
          e directions i cells + !
        ELSE
          i 3 =
          IF
            tuple_int_int% %allot { f }
            1 NEGATE f ->tuple_int_int_field_0 !
            0 f ->tuple_int_int_field_1 !
            f directions i cells + !
          ELSE
            i 4 =
            IF
              tuple_int_int% %allot { g }
              1 g ->tuple_int_int_field_0 !
              1 g ->tuple_int_int_field_1 !
              g directions i cells + !
            ELSE
              i 5 =
              IF
                tuple_int_int% %allot { h }
                1 h ->tuple_int_int_field_0 !
                1 NEGATE h ->tuple_int_int_field_1 !
                h directions i cells + !
              ELSE
                i 6 =
                IF
                  tuple_int_int% %allot { k }
                  1 NEGATE k ->tuple_int_int_field_0 !
                  1 k ->tuple_int_int_field_1 !
                  k directions i cells + !
                ELSE
                  tuple_int_int% %allot { l }
                  1 NEGATE l ->tuple_int_int_field_0 !
                  1 NEGATE l ->tuple_int_int_field_1 !
                  l directions i cells + !
                THEN
              THEN
            THEN
          THEN
        THEN
      THEN
    THEN
   1 + REPEAT 2DROP
  0 { max0 }
  HERE 20 cells allot { m }
  20 1 - 0 BEGIN 2dup >= WHILE DUP { o }
    HERE 20 cells allot { p }
    20 1 - 0 BEGIN 2dup >= WHILE DUP { q }
      read-int p q cells + !
      skipspaces
     1 + REPEAT 2DROP
    p m o cells + !
   1 + REPEAT 2DROP
  7 0 BEGIN 2dup >= WHILE DUP { j }
    directions j cells + @ { r }
    r ->tuple_int_int_field_0 @ { dx }
    r ->tuple_int_int_field_1 @ { dy }
    19 0 BEGIN 2dup >= WHILE DUP { x }
      19 0 BEGIN 2dup >= WHILE DUP { y }
        max0 4 m x y dx dy find0 max TO max0
       1 + REPEAT 2DROP
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  max0 s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

