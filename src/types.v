
  
(** Mutually dependent inductive types: [Bool] and [message] 
Note that type [Bool] is different from the built-in type [bool]
 *)
(** [ilist]: length-indexed list *)

Inductive ilist A : nat -> Type :=
| Nil : ilist A 0
| Cons: forall n, A-> ilist A n  -> ilist A (S n).

Type ilist_ind.

Inductive message: Type :=
(** Core symbols *)
| Mvar: nat -> message  (** Variable of type message *)
| O: message(** Empty message *)
| N: nat -> message(** Names *)
| ifm_then_else_: Bool -> message-> message-> message
| pair: message-> message-> message
| pi1: message-> message
| pi2: message-> message
| to: message -> message
| L: message-> message
| f: forall n, ilist message n -> message(** Attacker's computation *)
with Bool : Type :=
(** Core symbols *)
| Bvar: nat -> Bool
| TRue: Bool
| FAlse: Bool
| eqb : Bool -> Bool -> Bool
| eqm : message-> message-> Bool
| ifb_then_else_ :  Bool -> Bool -> Bool -> Bool.

(** Notations *)

Notation "'If' c1 'then' c2 'else' c3" := (ifm_then_else_ c1 c2 c3)
(at level 200, right associativity, format
                                      "'[v   ' 'If'  c1 '/' '[' 'then'  c2  ']' '/' '[' 'else'  c3 ']' ']'").

  Notation "'IF' c1 'then' c2 'else' c3" := (ifb_then_else_ c1 c2 c3)
(at level 200, right associativity, format
"'[v   ' 'IF'  c1 '/' '[' 'then'  c2  ']' '/' '[' 'else'  c3 ']' ']'").
