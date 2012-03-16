let warn funname msg =
  Format.fprintf Format.std_formatter
    "Warning : in function %s,@[<h>@\n%a@]@\n" funname msg ()
