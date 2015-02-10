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

let main =
  let input = ' ' in
  let current_pos = 500 in
  let mem = (Array.init_withenv 1000 (fun  i () -> let a = 0 in
  ((), a)) ()) in
  (
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    mem.(current_pos) <- (mem.(current_pos) + 1);
    let current_pos = (current_pos + 1) in
    (
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      mem.(current_pos) <- (mem.(current_pos) + 1);
      let rec b current_pos =
        (if (mem.(current_pos) <> 0)
         then (
                mem.(current_pos) <- (mem.(current_pos) - 1);
                let current_pos = (current_pos - 1) in
                (
                  mem.(current_pos) <- (mem.(current_pos) + 1);
                  (Printf.printf "%c" (char_of_int (mem.(current_pos))));
                  let current_pos = (current_pos + 1) in
                  (b current_pos)
                  )
                
                )
         
         else ()) in
        (b current_pos)
      )
    
    )
  

