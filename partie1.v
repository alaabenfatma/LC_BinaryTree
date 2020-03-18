
(*partie1*)

Require Import untypedLC.

(*booleans*)
Definition ctr := \ x y·x.
Definition cfa := \ x y· y.
(*boolean functions*)
Definition cif := \ x y z· x y z.
Definition cand := \ a b· \x y · a (b a b)y.
Definition cor := \a b·\x y·a x(b x  y).
Definition cneg := \b · b cfa ctr.
Definition test := \x · \y · cif ctr x y.
(*codage de quelques constantes 0, 1, 2, 3.*)
Definition c0 := \f x·x.
Definition c1 := \f x ·f x.
Definition c2 := \f x· f ( c1 f x ).
Definition c3 := \f x· f ( c2 f x ).
Definition c4 := \f x· f ( c3 f x ).
Definition c5 := \f x· f ( c4 f x).
(* THE REST IS JUST FOR FUN :-) *)
Definition c6 := \f x· f ( c5 f x).
Definition c7 := \f x· f ( c6 f x).
Definition c8 := \f x· f ( c7 f x).
Definition c9 := \f x· f ( c8 f x).
Definition c10 := \f x· f ( c9 f x).
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

(*Injection*)
Definition inj1 := \x · \k l · k x.
Definition inj2 := \x · \k l · l x.

(*predecessor*)
(*On retourne c0 si la valeur = 1 ou 0. Sinon, on cherche n-1 d'une maniere iterative. *)
Definition cpred := \n · n (\g · \k · ceq0  k (cadd (g k) c1) (g c1)) (\a · c0) c0.
Compute show_cbn (cpred ).
Compute equiv_lexp (cpred c4) c3.
Compute equiv_lexp (cpred c2) c1.
(* PRED DE 0 ?? . IL FAUT RETORUNER  0 !*)
Compute equiv_lexp (cpred c0) c0.

(*factorial*)
(*(λ n f · ((n (λ f n · n (f (λ f x · (n f) (f x))))) (λ x · f)) (λ x · x))*)
Definition fact := \n ·\f ·n(\f ·\n ·n(f(\f ·\x ·n f(f x))))(\x ·f)(\x ·x).
Compute show_cbn fact.
Compute equiv_lexp (fact c3) c6.



