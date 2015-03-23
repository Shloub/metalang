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
: nbPassePartout { n passepartout m serrures }
  0 { max_ancient }
  0 { max_recent }
  m 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    serrures i cells + @ 0 cells + @ 1 NEGATE = serrures i cells + @ 1 cells + @ max_ancient > AND
    IF
      serrures i cells + @ 1 cells + @ TO max_ancient
    THEN
    serrures i cells + @ 0 cells + @ 1 = serrures i cells + @ 1 cells + @ max_recent > AND
    IF
      serrures i cells + @ 1 cells + @ TO max_recent
    THEN
   1 + REPEAT 2DROP
  0 { max_ancient_pp }
  0 { max_recent_pp }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    passepartout i cells + @ { pp }
    pp 0 cells + @ max_ancient >= pp 1 cells + @ max_recent >= AND
    IF
      DROP DROP 1 exit
    THEN
    max_ancient_pp pp 0 cells + @ max TO max_ancient_pp
    max_recent_pp pp 1 cells + @ max TO max_recent_pp
   1 + REPEAT 2DROP
  max_ancient_pp max_ancient >= max_recent_pp max_recent >= AND
  IF
    2 exit
  ELSE
    0 exit
  THEN
;

: main
  read-int { n }
  skipspaces
  HERE n cells allot { passepartout }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE 2 cells allot { out0 }
    2 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      read-int { out01 }
      skipspaces
      out01 out0 j cells + !
     1 + REPEAT 2DROP
    out0 passepartout i cells + !
   1 + REPEAT 2DROP
  read-int { m }
  skipspaces
  HERE m cells allot { serrures }
  m 1 - 0 BEGIN 2dup >= WHILE DUP { k }
    HERE 2 cells allot { out1 }
    2 1 - 0 BEGIN 2dup >= WHILE DUP { l }
      read-int { out_ }
      skipspaces
      out_ out1 l cells + !
     1 + REPEAT 2DROP
    out1 serrures k cells + !
   1 + REPEAT 2DROP
  n passepartout m serrures nbPassePartout s>d 0 d.r
  ;
main
BYE

