: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: is_leap { year }
  year 400 % 0 = year 100 % 0 <> year 4 % 0 = AND OR exit
;


: ndayinmonth { month year }
  month 0 =
  IF
    31 exit
  ELSE
    month 1 =
    IF
      year is_leap
      IF
        29 exit
      ELSE
        28 exit
      THEN
    ELSE
      month 2 =
      IF
        31 exit
      ELSE
        month 3 =
        IF
          30 exit
        ELSE
          month 4 =
          IF
            31 exit
          ELSE
            month 5 =
            IF
              30 exit
            ELSE
              month 6 =
              IF
                31 exit
              ELSE
                month 7 =
                IF
                  31 exit
                ELSE
                  month 8 =
                  IF
                    30 exit
                  ELSE
                    month 9 =
                    IF
                      31 exit
                    ELSE
                      month 10 =
                      IF
                        30 exit
                      ELSE
                        month 11 =
                        IF
                          31 exit
                        THEN
                      THEN
                    THEN
                  THEN
                THEN
              THEN
            THEN
          THEN
        THEN
      THEN
    THEN
  THEN
  0 exit
;

: main
  0 { month }
  1901 { year }
  1 { dayofweek }
  \  01-01-1901 : mardi 
  
  0 { count }
  BEGIN
    year 2001 <>
  WHILE
    month year ndayinmonth { ndays }
    dayofweek ndays + 7 % TO dayofweek
    month 1 + TO month
    month 12 =
    IF
      0 TO month
      year 1 + TO year
    THEN
    dayofweek 7 % 6 =
    IF
      count 1 + TO count
    THEN
  REPEAT
  count s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

