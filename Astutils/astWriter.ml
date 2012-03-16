open Stdlib

module type SigAst = sig
  type t
  val foldmap : ('acc -> t -> 'acc * t) -> 'acc -> t -> 'acc * t
end

module F (T : SigAst) = struct
  module Surface = struct
    let fold f0 acc t =
      let f acc t =
	(f0 acc t), t
      in
      let (acc, t) =
	T.foldmap f acc t
      in acc
  end
  module Deep = struct
    let fold f0 acc t =
      let rec f acc t =
	let acc, t = T.foldmap f acc t in
	(f0 acc t), t
      in
      let (acc, t) =
	T.foldmap f acc t in
      let (acc, t) = f acc t
      in acc
  end
  module Traverse = struct
    let rec foldmap f acc t =
      T.foldmap (f (foldmap f)) acc t

    let rec map f t =
      let f2 tra acc t =
	acc, f (fun t ->
	  let (), t = tra () t
	  in t) t
      in let (), t = foldmap f2 () t in
	 t

    let rec fold f acc t =
      let f2 tra acc t =
	let acc = f (fun acc t ->
	  let acc, t = tra acc t
	  in acc
	) acc t
	in acc, t
      in let acc, _ = foldmap f2 acc t in
	 acc

  end
end
