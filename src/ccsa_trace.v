Add LoadPath "src/".
Require Import types.
Require Import String.
Section Tree.
 Variable A:Type.
 Open Scope string_scope.

 (** Tree type *)
  
 Inductive Tree A: Type :=
 | leaf
 | node: A -> Tree A -> Tree A -> Tree A.


 (** Record type to hold node info *)

 Record State : Set := state { label: string;
                               chk1: Bool;
                               chk2: Bool;
                               out: message
                             }.

 Definition CCSATree := Tree State.
 
 (**  Find depth of a given tree *)

 Fixpoint depth (t:CCSATree) : nat :=
   match t with
   | leaf _ => 0
   | node _ x l r => 1 + (max (depth l) (depth r))
   end.


 Definition emptySt := state "" TRue TRue O.


 (** get folded term for the given level *)

 Fixpoint foldedTerm (a: CCSATree) (n:nat) :=
   match a, n with
   | leaf _, _ => O
   | node _ x _ _, 0 => (out x)
   | node _ x l r, S n => (If (chk1 x) then (foldedTerm l n) else (If (chk2 x) then (foldedTerm r n)  else O))
   end.

 (** trace of a protocol given as a tree *)
 
 Fixpoint ccsaTrace (a: CCSATree) (d: nat) :=
  match a, d with
  | _ , 0 => nil
  | xs , S n =>  app (ccsaTrace xs n) (cons (foldedTerm xs (S n)) nil)
  end.


 Definition lf {A:Type} := (leaf A).

 Variables theta1 theta2 theta3 theta4 : Bool.
 Variables t1 t2: message.
 Definition exTree := (node _ (state "q^00_00" theta1 theta2 t1) (node _ (state "q^10_00" theta3 theta4 t2) lf lf) lf).

 Close Scope string_scope.
End Tree.
