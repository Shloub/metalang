(*
* Copyright (c) 2012, Prologin
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

(** Standard library

@see <http://prologin.org> Prologin
@author Prologin (info\@prologin.org)
@author Maxime Audouin (coucou747\@gmail.com)
@author Arthur Wendling (art.wendling\@gmail.com)
*)

(** {2 Standard operators } *)

val ( $ ) : ('a -> 'b) -> 'a -> 'b
val ( <| ) : ('a -> 'b) -> 'a -> 'b
val ( |> ) : 'a -> ('a -> 'b) -> 'b
val ( @* ) : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b
val ( @$ ) : ('a -> 'b) -> 'a -> 'b
val ( @** ) : ('a -> 'b) -> ('c -> 'd -> 'a) -> 'c -> 'd -> 'b

(** {2 Utils functions } *)
val id : 'a -> 'a
val curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
val uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c
val map_fst : ('a -> 'b) -> 'a * 'c -> 'b * 'c
val map_snd : ('a -> 'b) -> 'c * 'a -> 'c * 'b

val const : 'a -> 'b -> 'a
val flip : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c

val cons : 'a -> 'a list -> 'a list
val snoc : 'a list -> 'a -> 'a list

(** {2 type conversion functions } *)

val int : float -> int
val float : int -> float

val float_of_char : char -> float
val float_of_bool : bool -> float
val int_of_bool : bool -> int

(** {2 Standard modules } *)

module Int :
sig
  type t = int
  val compare : int -> int -> int
  val sqrt : int -> int
  val abs : int -> int
  val exp : int -> int -> int
end

module Option :
sig
  val extract : 'a option -> 'a
  val map_default : 'a -> ('b -> 'a) -> 'b option -> 'a
  val iter : ('a -> unit) -> 'a option -> unit
  val is_none : 'a option -> bool
  val is_some : 'a option -> bool
  val default : 'a -> 'a option -> 'a
  val return : 'a -> 'a option
  val bind : ('a -> 'b option) -> 'a option -> 'b option
  val map : ('a -> 'b) -> 'a option -> 'b option
  val catch : ('a -> 'b) -> 'a -> 'b option
  val snoc : 'a list -> 'a option -> 'a list
end

module Either : sig
  type ('a, 'b) t = A of 'a | B of 'b
end

module List :
sig
  val collect : ('a -> 'b list) -> 'a list -> 'b list
  val indexof : 'a ->'a list -> int
  val length : 'a list -> int
  val hd : 'a list -> 'a
  val tl : 'a list -> 'a list
  val nth : 'a list -> int -> 'a
  val rev : 'a list -> 'a list
  val append : 'a list -> 'a list -> 'a list
  val rev_append : 'a list -> 'a list -> 'a list
  val concat : 'a list list -> 'a list
  val flatten : 'a list list -> 'a list
  val iter : ('a -> unit) -> 'a list -> unit
  val map : ('a -> 'b) -> 'a list -> 'b list
  val mapi : (int -> 'a -> 'b) -> 'a list -> 'b list
  val rev_map : ('a -> 'b) -> 'a list -> 'b list
  val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
  val fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
  val iter2 : ('a -> 'b -> unit) -> 'a list -> 'b list -> unit
  val map2 : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
  val rev_map2 : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
  val fold_left2 : ('a -> 'b -> 'c -> 'a) -> 'a -> 'b list -> 'c list -> 'a
  val fold_right2 :
    ('a -> 'b -> 'c -> 'c) -> 'a list -> 'b list -> 'c -> 'c
  val for_all : ('a -> bool) -> 'a list -> bool
  val exists : ('a -> bool) -> 'a list -> bool
  val for_all2 : ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
  val exists2 : ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
  val mem : 'a -> 'a list -> bool
  val memq : 'a -> 'a list -> bool
  val find : ('a -> bool) -> 'a list -> 'a
  val filter : ('a -> bool) -> 'a list -> 'a list
  val find_all : ('a -> bool) -> 'a list -> 'a list
  val partition : ('a -> bool) -> 'a list -> 'a list * 'a list
  val assoc : 'a -> ('a * 'b) list -> 'b
  val assq : 'a -> ('a * 'b) list -> 'b
  val mem_assoc : 'a -> ('a * 'b) list -> bool
  val mem_assq : 'a -> ('a * 'b) list -> bool
  val remove_assoc : 'a -> ('a * 'b) list -> ('a * 'b) list
  val remove_assq : 'a -> ('a * 'b) list -> ('a * 'b) list
  val split : ('a * 'b) list -> 'a list * 'b list
  val combine : 'a list -> 'b list -> ('a * 'b) list
  val sort : ('a -> 'a -> int) -> 'a list -> 'a list
  val stable_sort : ('a -> 'a -> int) -> 'a list -> 'a list
  val fast_sort : ('a -> 'a -> int) -> 'a list -> 'a list
  val merge : ('a -> 'a -> int) -> 'a list -> 'a list -> 'a list
  val zip : 'a list -> 'b list -> ('a * 'b) list
  val zip_with : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
  val unzip : ('a * 'b) list -> 'a list * 'b list
  val forall : ('a -> bool) -> 'a list -> bool
  val init : (int -> 'a) -> int -> 'a list
  val seq : int -> int -> int list
  val ( -- ) : int -> int -> int list
  val insert : int -> 'a -> 'a list -> 'a list
  val last : 'a list -> 'a
  val split_at : int -> 'a list -> 'a list * 'a list
  val take : int -> 'a list -> 'a list
  val take_while : ('a -> bool) -> 'a list -> 'a list
  val shuffle : 'a list -> 'a list
  val iteri : (int -> 'a -> 'b) -> 'a list -> unit
  val filter_map : ('a -> 'b option) -> 'a list -> 'b list
  val fold_left_filter_map :
    ('a -> 'b -> 'a * 'c option) -> 'a -> 'b list -> 'a * 'c list
  val fold_left_map :
    ('a -> 'b -> 'a * 'c) -> 'a -> 'b list -> 'a * 'c list
  val find_opt : ('a -> bool) -> 'a list -> 'a option
  val join : 'a -> 'a list -> 'a list
val pack : int -> 'a list -> 'a list list
end

module String :
sig

  type t = string
  val join : string list -> string
  val split : string -> char -> string list
  val ends_with : string -> string -> bool
  val starts_with : string -> string -> bool
  val length : string -> int
  val get : string -> int -> char
  val set : string -> int -> char -> unit
  val create : int -> string
  val make : int -> char -> string
  val from_char : char -> string
  val copy : string -> string
  val sub : string -> int -> int -> string
  val fill : string -> int -> int -> char -> unit
  val blit : string -> int -> string -> int -> int -> unit
  val concat : string -> string list -> string
  val iter : (char -> unit) -> string -> unit
  val escaped : string -> string
  val rindex : string -> char -> int
  val index_from : string -> int -> char -> int
  val rindex_from : string -> int -> char -> int
  val contains : string -> char -> bool
  val contains_from : string -> int -> char -> bool
  val rcontains_from : string -> int -> char -> bool
  val uppercase : string -> string
  val lowercase : string -> string
  val capitalize : string -> string
  val uncapitalize : string -> string
  val compare : t -> t -> int
  val equals : t -> t -> bool
  val lines : string -> string list
  val unlines : string list -> string
  val words : string -> string list
  val unwords : string list -> string
  val match_from : string -> string -> int -> bool
  val index : string -> string -> int -> int
  val is_sub : string -> string -> bool
  val is_prefix : string -> string -> bool
  val is_capitalised : string -> bool
  val fold_left : ('a -> char -> 'a) -> 'a -> string -> 'a
  val exists : (char -> bool) -> string -> bool
  val for_all : (char -> bool) -> string -> bool
  val list_of_map : (char -> 'a) -> string -> 'a list
  val of_list : char list -> string
  val of_char : char -> string
  val list_of_fold_map :
    ('a -> char -> 'a * 'b) -> string -> 'a -> 'a * 'b list
  val unescape : string -> string
  val replace : string -> string -> string -> string
  val chararray : string -> char array
end

(** {2 Collections} *)
module type SigSet = sig
  type elt
  type t
  val empty : t
  val is_empty : t -> bool
  val mem : elt -> t -> bool
  val add : elt -> t -> t
  val singleton : elt -> t
  val remove : elt -> t -> t
  val union : t -> t -> t
  val inter : t -> t -> t
  val diff : t -> t -> t
  val compare : t -> t -> int
  val equal : t -> t -> bool
  val subset : t -> t -> bool
  val iter : (elt -> unit) -> t -> unit
  val fold : (elt -> 'a -> 'a) -> t -> 'a -> 'a
  val for_all : (elt -> bool) -> t -> bool
  val exists : (elt -> bool) -> t -> bool
  val filter : (elt -> bool) -> t -> t
  val partition : (elt -> bool) -> t -> t * t
  val cardinal : t -> int
  val elements : t -> elt list
  val min_elt : t -> elt
  val max_elt : t -> elt
  val choose : t -> elt
  val split : elt -> t -> t * bool * t
  val from_list : elt list -> t
end

module MakeSet : functor (K : Set.OrderedType) -> SigSet with type elt = K.t

module type SigMap = sig
    type key
    type 'a t
    val empty : 'a t
    val is_empty : 'a t -> bool
    val mem : key -> 'a t -> bool
    val add : key -> 'a -> 'a t -> 'a t
    val singleton : key -> 'a -> 'a t
    val remove : key -> 'a t -> 'a t
    val compare : ('a -> 'a -> int) -> 'a t -> 'a t -> int
    val equal : ('a -> 'a -> bool) -> 'a t -> 'a t -> bool
    val iter : (key -> 'a -> unit) -> 'a t -> unit
    val fold : (key -> 'a -> 'b -> 'b) -> 'a t -> 'b -> 'b
    val for_all : (key -> 'a -> bool) -> 'a t -> bool
    val exists : (key -> 'a -> bool) -> 'a t -> bool
    val filter : (key -> 'a -> bool) -> 'a t -> 'a t
    val partition : (key -> 'a -> bool) -> 'a t -> 'a t * 'a t
    val cardinal : 'a t -> int
    val bindings : 'a t -> (key * 'a) list
    val min_binding : 'a t -> key * 'a
    val max_binding : 'a t -> key * 'a
    val choose : 'a t -> key * 'a
    val split : key -> 'a t -> 'a t * 'a option * 'a t
    val find : key -> 'a t -> 'a
    val map : ('a -> 'b) -> 'a t -> 'b t
    val mapi : (key -> 'a -> 'b) -> 'a t -> 'b t
    val merge : (key -> 'a option -> 'a option -> 'a option) -> 'a t -> 'a t -> 'a t
    val to_list : 'a t -> (key * 'a) list
    val from_list : (key * 'a) list -> 'a t
    val find_opt : key -> 'a t -> 'a option
  end

module MakeMap : functor (K : Map.OrderedType) -> SigMap with type key = K.t

(** {3 Collections prédéfinies} *)

module IntSet : SigSet with type elt = int
module IntMap : SigMap with type key = int

module StringMap : SigMap with type key = string
module StringSet : SigSet with type elt = string

(** {Haskell story for children} *)


module type Applicative = sig
  type 'a t
  val ret : 'a -> 'a t
  val (<*>) : ('a -> 'b) t -> 'a t -> 'b t
end
module type Monade = sig
  include Applicative
  val (=<<) : ('a -> 'b t) -> 'a t -> 'b t
end

module ListApp : functor (F : Applicative) ->
  sig val fold_left_map : ('a -> 'b F.t) -> 'a list -> 'b list F.t end

module Applicatives : sig
  module FoldMap : functor (Acc : sig type t end) -> Monade with type 'a t = Acc.t -> Acc.t * 'a
  module Fold : functor (Acc : sig type t end) -> Applicative with type 'a t = Acc.t -> Acc.t
  module Map: Monade with type 'a t = 'a
  module Accumule : functor (Acc : sig type t 
    val merge : t -> t -> t
    val zero : t
  end) -> Applicative with type 'a t = Acc.t * 'a
end

module type FoldMapApplicative = sig
  type 'a t
  module Make : functor (F:Applicative) -> sig
    val foldmap : ('a -> 'ra F.t) -> 'a t -> 'ra t F.t
  end
end

module FromFoldMap : functor(F : FoldMapApplicative) -> sig
  val foldmap : ('b -> 'a -> 'a * 'd) -> 'b F.t -> 'a -> 'a * 'd F.t
  val fold : ('b -> 'a -> 'a) -> 'b F.t -> 'a -> 'a
  val map : ('a -> 'b) -> 'a F.t -> 'b F.t

end




(** {2 Fix module} *)
(** les modules dérécursivés *)

module type Fixable = sig
  type ('a, 'b) tofix
  val map : ('a -> 'b) -> ('a, 'c) tofix -> ('b, 'c) tofix
  val next : unit -> int
end

module Fix : functor (F : Fixable ) ->
sig
  type 'a t = F of int * ('a t, 'a) F.tofix
  val annot : 'a t -> int
  val unfix : 'a t -> ('a t , 'a) F.tofix
  val fix : ('a t , 'a) F.tofix -> 'a t
  val fixa : int -> ('a t , 'a) F.tofix -> 'a t
  val map : ('a -> 'b) -> ('a, 'c) F.tofix -> ('b, 'c) F.tofix
  val dmap : ('a t -> 'a t) -> 'a t -> 'a t
  val dfold : (('a, 'b) F.tofix -> 'a) -> 'b t -> 'a
end

module type Fixable2 = sig
  type ('a, 'b) tofix

  module Make : functor (F:Applicative) -> sig
    val foldmap : ('a -> 'ra F.t) -> ('b -> 'rb F.t) -> ('a, 'b) tofix -> ('ra, 'rb) tofix F.t
  end

  val next : unit -> int
end

module Fix2 : functor (F : Fixable2 ) ->
sig

  type 'a t = F of int * ('a t, 'a) F.tofix
  val annot : 'a t -> int
  val unfix : 'a t -> ('a t , 'a) F.tofix
  val fix : ('a t , 'a) F.tofix -> 'a t
  val fixa : int -> ('a t , 'a) F.tofix -> 'a t

  module Surface : sig
    val map : ('a -> 'b) -> ('a, 'c) F.tofix -> ('b, 'c) F.tofix
    val mapt : ('a t -> 'a t) -> 'a t -> 'a t
    val foldmap : ('b -> 'a -> 'a * 'c) -> ('b, 'd) F.tofix -> 'a -> 'a * ('c, 'd) F.tofix
    val foldmapt : ('b t -> 'a -> 'a * 'b t) -> 'b t -> 'a -> 'a * 'b t
    val fold : ('a -> 'b -> 'a) -> 'a -> ('b, 'd) F.tofix -> 'a

    val foldmap2 : ('a -> 'b -> 'b * 'c) ->
      ('d -> 'b -> 'b * 'e) ->
        ('a, 'd) F.tofix -> 'b -> 'b * ('c, 'e) F.tofix

    val fold2 : ('a -> 'b -> 'b) -> ('c -> 'b -> 'b) -> ('a, 'c) F.tofix -> 'b -> 'b
    val map2 : ('a -> 'b) -> ('c -> 'd) -> ('a, 'c) F.tofix -> ('b, 'd) F.tofix
  end

  module Apply : functor (A : Applicative) ->
  sig
    module M :
      sig
        val foldmap :
          ('a -> 'ra A.t) ->
          ('b -> 'rb A.t) -> ('a, 'b) F.tofix -> ('ra, 'rb) F.tofix A.t
      end
    val fm2 :
      (('a, 'b) F.tofix A.t -> 'a A.t) -> ('c -> 'b A.t) -> 'c t -> 'a A.t
    val fm2i :
      (int -> ('a, 'b) F.tofix A.t -> 'a A.t) -> (int -> 'c -> 'b A.t) -> 'c t -> 'a A.t
    val fm : (('a, 'b) F.tofix A.t -> 'a A.t) -> 'b t -> 'a A.t

    val map : ('a ->'b A.t) -> 'a t -> 'b t A.t
    val mapi : (int -> 'a ->'b A.t) -> 'a t -> 'b t A.t

  end

  module Deep : sig
    val map : ('a t -> 'a t) -> 'a t -> 'a t
    val mapg : ('a -> 'b) -> 'a t -> 'b t

    val map2 :
        (('c t, 'b) F.tofix -> ('c t, 'c) F.tofix) ->
          ('a -> 'b) -> 'a t -> 'c t

    val fold : (('a, 'b) F.tofix -> 'a) -> 'b t -> 'a
    val folda : (int -> ('a, 'b) F.tofix -> 'a) -> 'b t -> 'a

    val exists : ('a t -> bool) -> 'a t -> bool

    val foldmap2i_topdown :
        (int -> ('a, 'rb) F.tofix -> 'acc -> 'acc * 'a) ->
          ('b -> 'acc -> 'acc * 'rb) -> 'b t -> 'acc -> 'acc * 'a

    val foldmap2_topdown :
        (('a, 'rb) F.tofix -> 'acc -> 'acc * 'a) ->
          ('b -> 'acc -> 'acc * 'rb) -> 'b t -> 'acc -> 'acc * 'a

    val foldg : ('a -> 'b -> 'b) -> 'a t -> 'b -> 'b

    val fold2_bottomup : (('a, 'rb) F.tofix -> 'a) -> ('b -> 'rb) -> 'b t -> 'a
    val foldmapg : ('b -> 'a -> 'a * 'c) -> 'b t -> 'a -> 'a * 'c t
  end

end
module Printers : sig
  val print_list :
    ('a -> 'b -> unit) ->
    ('a ->
     ('a -> 'b -> unit) -> 'b -> ('a -> 'b list -> unit) -> 'b list -> unit) ->
    'a -> 'b list -> unit
end
