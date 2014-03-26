
open Stdlib
open Ast
open Printer

class posPrinter = object(self)
  inherit printer as super

  method hidden func f p =
    Format.fprintf f "\x1b[2m%a\x1b[22m" func p

  method ploc (f : Format.formatter) (loc : Ast.location) : unit = self#hidden Warner.ploc f loc

  method expr f e =
    let loc = Ast.PosMap.get (Expr.Fixed.annot e) in
    Format.fprintf f "%a%a" self#ploc loc super#expr e

  method instr f e =
    let loc = Ast.PosMap.get (Instr.Fixed.annot e) in
    Format.fprintf f "%a%a"
      self#ploc loc super#instr e

  method ptype f e =
    let loc = Ast.PosMap.get (Type.Fixed.annot e) in
    Format.fprintf f "%a%a"
      self#ploc loc super#ptype e

  method mutable_ f e =
    let loc = Ast.PosMap.get (Mutable.Fixed.annot e) in
    Format.fprintf f "%a%a"
      self#ploc loc super#mutable_ e

end
