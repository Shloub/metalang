
let () = begin
  let a = Stdlib.String.replace "o" "\\o" "toto" in
  Format.printf "a=%S\n" a;
  assert (a = "t\\ot\\o");
end
