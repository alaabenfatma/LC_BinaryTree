Require Import untypedLC.
(*true | false*)
Definition ctr := \x y·x.
Definition cfa := \x y·y.
Definition cif := \b m n·b m n.

Compute (show_cbn cif).
Definition c0 := \f x·x.
Definition c1 := \f x ·f x.
Definition c2 := \f x· f ( f x ).
Definition c3 := \f x· f ( f (f x) ).

Definition cand :=  \a b· \x y·a(b a b)y.
Compute (show_cbn cand).

Definition cor := \a b·\x y·a x(b x  y).
Compute (show_cbn cor).

Definition test := \x · \y · cif ctr x y.
Compute (show_cbn test).

(*test and*)

Compute equiv_lexp (cand ctr cfa) c3.