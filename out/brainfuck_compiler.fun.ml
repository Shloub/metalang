let main =
  let input = ' ' in
  let current_pos = 500 in
  let mem = Array.init 1000 (fun i -> 0) in
  ( mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    mem.(current_pos) <- mem.(current_pos) + 1;
    let current_pos = current_pos + 1 in
    ( mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      mem.(current_pos) <- mem.(current_pos) + 1;
      let rec a current_pos =
        if mem.(current_pos) <> 0
        then ( mem.(current_pos) <- mem.(current_pos) - 1;
               let current_pos = current_pos - 1 in
               ( mem.(current_pos) <- mem.(current_pos) + 1;
                 Printf.printf "%c" (char_of_int (mem.(current_pos)));
                 let current_pos = current_pos + 1 in
                 a current_pos))
        else () in
        a current_pos))

