module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let rec is_leap =
  (fun year ->
      (((year mod 400) = 0) || (((year mod 100) <> 0) && ((year mod 4) = 0))));;
let rec ndayinmonth =
  (fun month year ->
      ((fun a ->
           (if (month = 0)
            then 31
            else ((fun b ->
                      (if (month = 1)
                       then ((fun c ->
                                 (if (is_leap year)
                                  then 29
                                  else 28)) (fun month year ->
                                                (b month year)))
                       else ((fun d ->
                                 (if (month = 2)
                                  then 31
                                  else ((fun e ->
                                            (if (month = 3)
                                             then 30
                                             else ((fun f ->
                                                       (if (month = 4)
                                                        then 31
                                                        else ((fun g ->
                                                                  (if (month = 5)
                                                                   then 30
                                                                   else ((fun
                                                                    h ->
                                                                   (if (month = 6)
                                                                    then 31
                                                                    else ((fun
                                                                     i ->
                                                                    (
                                                                    if (month = 7)
                                                                    then 31
                                                                    else ((fun
                                                                     j ->
                                                                    (
                                                                    if (month = 8)
                                                                    then 30
                                                                    else ((fun
                                                                     k ->
                                                                    (
                                                                    if (month = 9)
                                                                    then 31
                                                                    else ((fun
                                                                     l ->
                                                                    (
                                                                    if (month = 10)
                                                                    then 30
                                                                    else ((fun
                                                                     m ->
                                                                    (
                                                                    if (month = 11)
                                                                    then 31
                                                                    else (m month year))) (fun
                                                                     month year ->
                                                                    (l month year))))) (fun
                                                                     month year ->
                                                                    (k month year))))) (fun
                                                                     month year ->
                                                                    (j month year))))) (fun
                                                                     month year ->
                                                                    (i month year))))) (fun
                                                                     month year ->
                                                                    (h month year))))) (fun
                                                                    month year ->
                                                                   (g month year))))) (fun
                                                         month year ->
                                                        (f month year))))) (fun
                                              month year ->
                                             (e month year))))) (fun month year ->
                                                                    (d month year))))) (fun
                        month year ->
                       (b month year))))) (fun month year ->
                                              (a month year))))) (fun
       month year ->
      0)));;
let rec main =
  ((fun month ->
       ((fun year ->
            ((fun dayofweek ->
                 (*  01-01-1901 : mardi  *)
                 ((fun count ->
                      let rec o count dayofweek year month =
                        (if (year <> 2001)
                         then ((fun ndays ->
                                   ((fun dayofweek ->
                                        ((fun month ->
                                             ((fun q ->
                                                  (if (month = 12)
                                                   then ((fun month ->
                                                             ((fun year ->
                                                                  (q ndays count dayofweek year month)) (year + 1))) 0)
                                                   else (q ndays count dayofweek year month))) (fun
                                              ndays count dayofweek year month ->
                                             ((fun p ->
                                                  (if ((dayofweek mod 7) = 6)
                                                   then ((fun count ->
                                                             (p ndays count dayofweek year month)) (count + 1))
                                                   else (p ndays count dayofweek year month))) (fun
                                              ndays count dayofweek year month ->
                                             (o count dayofweek year month)))))) (month + 1))) ((dayofweek + ndays) mod 7))) (ndayinmonth month year))
                         else (Printf.printf "%d" count;
                         (Printf.printf "%s" "\n";
                         ()))) in
                        (o count dayofweek year month)) 0)) 1)) 1901)) 0);;

