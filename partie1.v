(*partie1*)

Require Import untypedLC.

(*booleans*)
Definition ctr := \ x y·x.
Definition cfa := \ x y· y.
(*boolean functions*)
Definition cif := \ x y z· x y z.
Definition cand := \ a b· \x y · a (b a b)y.
Definition cor := \a b·\x y·a x(b x  y).
Definition test := \x · \y · cif ctr x y.
(*codage de quelques constantes 0, 1, 2, 3.*)
Definition c0 := \f x·x.
Definition c1 := \f x ·f x.
Definition c2 := \f x· f ( f x ).
Definition c3 := \f x· f ( f (f x) ).
Definition c4 := \f x· f ( f (f (f x)) ).
Definition c5 := \f x· f ( f (f (f (f x)) )).
Definition c6 := \f x· f ( f (f (f (f (f x)) ))).
Definition c7 := \f x· f ( f (f (f (f (f (f x)) )))).
Definition c8 := \f x· f ( f (f (f (f (f (f (f x)) ))))).
Definition c9 := \f x· f ( f (f (f (f (f (f (f (f x)) )))))).
(*opérations successeur, addition et multiplica-tion, 
et du test à 0*)
Definition csucc := \n · \ f x·f(n f x).
Definition cadd := \n m·\f x·n f(m f x).
Definition cmult := \n m · \f· n(m f).
Definition ceq0 := \n·\x y· n(\z·x) y.

(*couples*)
Definition cpl := \x1 x2 · \k · k x1 x2.

(*operation sur couples*)
Definition kfst := \x1 x2 · x1.
Definition ksnd := \x1 x2 · x2.
Definition fst := \c · c  kfst.
Definition snd := \c · c  ksnd.

(*predecessor*)
Definition cpred := \n · \f · \x · n (\ g· \ h · h (g f)) (\ u·x) (\ u·u).

Compute equiv_lexp (cpred c4) c3.
Compute equiv_lexp (cpred c2) c1.


Definition cfg := \r · \n·(ceq0 n (cadd n (r r cpred n))  c1)  .
Definition cfact := (\x·x x) cfg.

Compute show_cbn (cfact c2).
Compute equiv_lexp (cfact c3) c6.
3+2+1+0
