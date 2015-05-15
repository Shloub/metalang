let is_pair i =
  let j = 1 in
  let a = (fun j -> let j = 6 in
  let j = if i < 20
          then let j = if i = 22
                       then 0
                       else j in
          8
          else j in
  i mod 2 = 0) in
  if i < 10
  then let j = 2 in
  if i = 0
  then let j = 4 in
  true
  else let j = 3 in
  if i = 2
  then let j = 4 in
  true
  else let j = 5 in
  a j
  else a j
let main =
  ()

