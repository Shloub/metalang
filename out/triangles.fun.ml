let rec find0 len tab cache x y =
  (* 
	Cette fonction est récursive
	 *)
  if y = len - 1
  then tab.(y).(x)
  else if x > y
       then - 10000
       else if cache.(y).(x) <> 0
            then cache.(y).(x)
            else let result = 0 in
            let out0 = find0 len tab cache x (y + 1) in
            let out1 = find0 len tab cache (x + 1) (y + 1) in
            let result = if out0 > out1
                         then out0 + tab.(y).(x)
                         else out1 + tab.(y).(x) in
            ( cache.(y).(x) <- result;
              result)
let find len tab =
  let tab2 = Array.init len (fun i -> Array.init (i + 1) (fun j -> 0)) in
  find0 len tab tab2 0 0
let main =
  Scanf.scanf "%d"
  (fun len -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                let tab = Array.init len (fun i -> Array.init (i + 1) (fun j -> Scanf.scanf "%d"
                (fun tmp -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
                              tmp)))) in
                ( Printf.printf "%d\n" (find len tab);
                  let rec a k =
                    if k <= len - 1
                    then let rec b l =
                           if l <= k
                           then ( Printf.printf "%d " tab.(k).(l);
                                  b (l + 1))
                           else ( Printf.printf "%s" "\n";
                                  a (k + 1)) in
                           b 0
                    else () in
                    a 0)))

