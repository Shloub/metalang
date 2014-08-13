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
      let a = (fun month year ->
                  0) in
      (if (month = 0)
       then 31
       else let b = (fun month year ->
                        (a month year)) in
       (if (month = 1)
        then let c = (fun month year ->
                         (b month year)) in
        (if (is_leap year)
         then 29
         else 28)
        else let d = (fun month year ->
                         (b month year)) in
        (if (month = 2)
         then 31
         else let e = (fun month year ->
                          (d month year)) in
         (if (month = 3)
          then 30
          else let f = (fun month year ->
                           (e month year)) in
          (if (month = 4)
           then 31
           else let g = (fun month year ->
                            (f month year)) in
           (if (month = 5)
            then 30
            else let h = (fun month year ->
                             (g month year)) in
            (if (month = 6)
             then 31
             else let i = (fun month year ->
                              (h month year)) in
             (if (month = 7)
              then 31
              else let j = (fun month year ->
                               (i month year)) in
              (if (month = 8)
               then 30
               else let k = (fun month year ->
                                (j month year)) in
               (if (month = 9)
                then 31
                else let l = (fun month year ->
                                 (k month year)) in
                (if (month = 10)
                 then 30
                 else let m = (fun month year ->
                                  (l month year)) in
                 (if (month = 11)
                  then 31
                  else (m month year))))))))))))));;
let rec main =
  let month = 0 in
  let year = 1901 in
  let dayofweek = 1 in
  (*  01-01-1901 : mardi  *)
  let count = 0 in
  let rec o count dayofweek year month =
    (if (year <> 2001)
     then let ndays = (ndayinmonth month year) in
     let dayofweek = ((dayofweek + ndays) mod 7) in
     let month = (month + 1) in
     let q = (fun ndays count dayofweek year month ->
                 let p = (fun ndays count dayofweek year month ->
                             (o count dayofweek year month)) in
                 (if ((dayofweek mod 7) = 6)
                  then let count = (count + 1) in
                  (p ndays count dayofweek year month)
                  else (p ndays count dayofweek year month))) in
     (if (month = 12)
      then let month = 0 in
      let year = (year + 1) in
      (q ndays count dayofweek year month)
      else (q ndays count dayofweek year month))
     else begin
            (Printf.printf "%d" count);
            (Printf.printf "%s" "\n")
            end
     ) in
    (o count dayofweek year month);;

