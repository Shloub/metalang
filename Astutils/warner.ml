let warn funname msg =
  Format.fprintf Format.std_formatter
    "Warning : in function %s,@\n@[<h>  %a@]@\n" funname msg ()

let err funname msg =
  begin
    Format.fprintf Format.std_formatter
      "Error : in function %s,@\n@[<h>  %a@]@\n" funname msg ();
    exit 1;
  end
