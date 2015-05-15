let main =
  ( Printf.printf "%s" "Hello World";
    let a = 5 in
    ( Printf.printf "%d \n%dfoo" ((4 + 6) * 2) a;
      let b = 1 + (1 + 1) * 2 * (3 + 8) / 4 - (1 - 2) - 3 = 12 && true in
      ( if b
        then Printf.printf "%s" "True"
        else Printf.printf "%s" "False";
        Printf.printf "%s" "\n";
        let c = (3 * (4 + 5 + 6) * 2 = 45) = false in
        ( if c
          then Printf.printf "%s" "True"
          else Printf.printf "%s" "False";
          Printf.printf "%s" " ";
          let d = (2 = 1) = false in
          ( if d
            then Printf.printf "%s" "True"
            else Printf.printf "%s" "False";
            Printf.printf " %d%d" ((4 + 1) / 3 / (2 + 1)) (4 * 1 / 3 / 2 * 1);
            let e = not (not (a = 0) && not (a = 4)) in
            ( if e
              then Printf.printf "%s" "True"
              else Printf.printf "%s" "False";
              let f = true && not false && not (true && false) in
              ( if f
                then Printf.printf "%s" "True"
                else Printf.printf "%s" "False";
                Printf.printf "%s" "\n")))))))

