let is_leap year =
  (((year mod 400) = 0) || (((year mod 100) <> 0) && ((year mod 4) = 0)))
let ndayinmonth month year =
  (if (month = 0)
   then 31
   else (if (month = 1)
         then (if (is_leap year)
               then 29
               else 28)
         else (if (month = 2)
               then 31
               else (if (month = 3)
                     then 30
                     else (if (month = 4)
                           then 31
                           else (if (month = 5)
                                 then 30
                                 else (if (month = 6)
                                       then 31
                                       else (if (month = 7)
                                             then 31
                                             else (if (month = 8)
                                                   then 30
                                                   else (if (month = 9)
                                                         then 31
                                                         else (if (month = 10)
                                                               then 30
                                                               else (if (month = 11)
                                                                     then 31
                                                                     else 0))))))))))))
let main =
  let month = 0 in
  let year = 1901 in
  let dayofweek = 1 in
  (*  01-01-1901 : mardi  *)
  let count = 0 in
  let rec a count dayofweek month year =
    (if (year <> 2001)
     then let ndays = (ndayinmonth month year) in
     let dayofweek = ((dayofweek + ndays) mod 7) in
     let month = (month + 1) in
     ((fun  (month, year) -> (if ((dayofweek mod 7) = 6)
                              then let count = (count + 1) in
                              (a count dayofweek month year)
                              else (a count dayofweek month year))) (if (month = 12)
                                                                     then let month = 0 in
                                                                     let year = (year + 1) in
                                                                     (month, year)
                                                                     else (month, year)))
     else (
            (Printf.printf "%d\n" count)
            )
     ) in
    (a count dayofweek month year)

