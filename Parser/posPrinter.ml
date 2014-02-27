
open Stdlib
open Ast
open Printer

class posPrinter = object(self)
  inherit printer as super

  method expr f e =
    let loc = Ast.PosMap.get (Expr.Fixed.annot e) in
    Format.fprintf f "%a[%a]"
      Warner.ploc loc super#expr e

  method instr f e =
    let loc = Ast.PosMap.get (Instr.Fixed.annot e) in
    Format.fprintf f "%a[%a]"
      Warner.ploc loc super#instr e

  method ptype f e =
    let loc = Ast.PosMap.get (Type.Fixed.annot e) in
    Format.fprintf f "%a[%a]"
      Warner.ploc loc super#ptype e

  method mutable_ f e =
    let loc = Ast.PosMap.get (Mutable.Fixed.annot e) in
    Format.fprintf f "%a[%a]"
      Warner.ploc loc super#mutable_ e

end
