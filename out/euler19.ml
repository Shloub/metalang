let is_leap year =
  (year mod 400) = 0 or ((year mod 100) <> 0 && (year mod 4) = 0)

let ndayinmonth month year =
  if month = 0 then
    31
  else if month = 1 then
    begin
      if is_leap year then
        29
      else
        28
    end
  else if month = 2 then
    31
  else if month = 3 then
    30
  else if month = 4 then
    31
  else if month = 5 then
    30
  else if month = 6 then
    31
  else if month = 7 then
    31
  else if month = 8 then
    30
  else if month = 9 then
    31
  else if month = 10 then
    30
  else if month = 11 then
    31
  else
    0

let () =
begin
  let month = ref( 0 ) in
  let year = ref( 1901 ) in
  let dayofweek = ref( 1 ) in
  (* 01-01-1901 : mardi *)
  let count = ref( 0 ) in
  while (!year) <> 2001
  do
      let ndays = ndayinmonth (!month) (!year) in
      dayofweek := ((!dayofweek) + ndays) mod 7;
      month := (!month) + 1;
      if (!month) = 12 then
        begin
          month := 0;
          year := (!year) + 1
        end;
      if ((!dayofweek) mod 7) = 6 then
        count := (!count) + 1
  done;
  Printf.printf "%d\n" (!count)
end
 