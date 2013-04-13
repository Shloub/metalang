
type case_state = {
  mutable left : bool;
  mutable right : bool;
  mutable top : bool;
  mutable bottom : bool;
  mutable free : bool;
};;

type laby = {
  mutable sizeX : int;
  mutable sizeY : int;
  mutable cases : case_state array array;
};;

let rec can_open_right state x y =
  (x < (state.sizeX - 1)) && state.cases.(x + 1).(y).free

let rec can_open_left state x y =
  (x > 0) && state.cases.(x - 1).(y).free

let rec can_open_bottom state x y =
  (y < (state.sizeY - 1)) && state.cases.(x).(y + 1).free

let rec can_open_top state x y =
  (y > 0) && state.cases.(x).(y - 1).free

let rec open_left state x y =
  state.cases.(x - 1).(y).right <- false;
  state.cases.(x).(y).left <- false;
  state.cases.(x - 1).(y).free <- false;
  state.cases.(x).(y).free <- false

let rec open_right state x y =
  state.cases.(x).(y).right <- false;
  state.cases.(x + 1).(y).left <- false;
  state.cases.(x).(y).free <- false;
  state.cases.(x + 1).(y).free <- false

let rec open_top state x y =
  state.cases.(x).(y - 1).bottom <- false;
  state.cases.(x).(y).top <- false;
  state.cases.(x).(y - 1).free <- false;
  state.cases.(x).(y).free <- false

let rec open_bottom state x y =
  state.cases.(x).(y + 1).top <- false;
  state.cases.(x).(y).bottom <- false;
  state.cases.(x).(y + 1).free <- false;
  state.cases.(x).(y).free <- false

let rec init x y =
  let cases = Array.init (x) (fun i ->
    let cases_x = Array.init (y) (fun j ->
      let reco = {
        left=true;
        right=true;
        top=true;
        bottom=true;
        free=true;
      } in
      reco) in
    cases_x) in
  let out_ = {
    sizeX=x;
    sizeY=y;
    cases=cases;
  } in
  out_

let rec print_lab l =
  for x = 0 to l.sizeX - 1 do
    Printf.printf "%s" ("__")
  done;
  Printf.printf "%s" ("\n");
  for y = 0 to l.sizeY - 1 do
    for x = 0 to l.sizeX - 1 do
      if l.cases.(x).(y).left then
        if l.cases.(x).(y).bottom then
          Printf.printf "%s" ("|_")
        else
          Printf.printf "%s" ("| ")
      else if l.cases.(x).(y).bottom then
        Printf.printf "%s" ("__")
      else
        Printf.printf "%s" ("  ")
    done;
    Printf.printf "%s" ("|\n")
  done;
  Printf.printf "%s" ("\n")

let rec gen lab x y =
  let h = 4 in
  let order = Array.init (h) (fun i ->
    i) in
  for i = 0 to 2 do
    let j = (Random.int (4 -
i)) in
    let k = order.(i) in
    order.(i) <- order.(j);
    order.(j) <- k
  done;
  for i = 0 to 3 do
    if (0 = order.(i)) && (can_open_left lab x y) then
      begin
        open_left lab x y;
        gen lab (x - 1) y
      end;
    if (1 = order.(i)) && (can_open_right lab x y) then
      begin
        open_right lab x y;
        gen lab (x + 1) y
      end;
    if (2 = order.(i)) && (can_open_top lab x y) then
      begin
        open_top lab x y;
        gen lab x (y - 1)
      end;
    if (3 = order.(i)) && (can_open_bottom lab x y) then
      begin
        open_bottom lab x y;
        gen lab x (y + 1)
      end
  done

let () =
begin
  let lab = init 10 10 in
  gen lab 0 0;
  print_lab lab
end
 