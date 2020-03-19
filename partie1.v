
(*partie1*)

Require Import untypedLC.

(*booleans*)
Definition ctr := \ x y·x.
Definition cfa := \ x y· y.
(*boolean functions*)
Definition cif := \ x y z· x y z.
Definition cand := \ a b· \x y · a (b a b)y.
Compute equiv_lexp (cand cfa ctr) cfa.
Definition cor := \a b·\x y·a x(b x  y).
Compute equiv_lexp (cor cfa ctr) ctr.
Definition cneg := \b · b cfa ctr.
Compute equiv_lexp (cneg cfa) ctr.
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
(* succ c9 = c10 ? *)
Compute equiv_lexp (csucc c9) c10.
Definition cadd := \n m·\f x·n f(m f x).
(* c9 + c1 = c10 ? *)
Compute equiv_lexp (cadd c9 c1) c10.
Definition cmult := \n m · \f· n(m f).
(* c2 * c5 = c10 ? *)
Compute equiv_lexp (cmult c2 c5) c10.
Definition ceq0 := \n·\x y· n(\z·y) x.
(* c0 = c0 *)
Compute equiv_lexp (ceq0 c0) ctr.
(*couples*)
Definition cpl := \x1 x2 · \k · k x1 x2.

(*operation sur couples*)
(*voir tests au-dessous*)
Definition kfst := \x1 x2 · x1.
Definition ksnd := \x1 x2 · x2.
Definition fst := \c · c  kfst.
Definition snd := \c · c  ksnd.
(*TEST COUPLES*)
Definition cc := cpl c5 c9.
Compute equiv_lexp (cc kfst) c5.
Compute equiv_lexp (cc ksnd) c9.
Compute equiv_lexp (fst cc) c5.
Compute equiv_lexp (snd cc) c9.

(*Injection*)
Definition inj1 := \x · \k l · k x.
Definition inj2 := \x · \k l · l x.
(*INJECTION TEST *)
(*Injected value = number of occurances of the f in the right-side of the equation*)
Compute show_cbn (inj1 (cpl c1 c0) c3).

(*predecessor*)
(* EXPLICATION : 
On prend un entier N.
si N = 1 ou 0. On retourne 0.
Sinon, on ajoute +1 a notre variable SECOND jusqu'a x = n-1 
C'est grace a l'usage de couples
i.e : 5 (0,0) -> 5 (0,1) -> 5 (1,2) -> 5 (2,3) -> 5 (3,4) -> 5 (4,5) <=> 4 ! *)
Definition iter := \x · cpl (snd x) (csucc (snd x)).
Definition cpred := \n · fst ( n iter (cpl c0 c0)).
Compute show_cbn (cpred ).
Compute equiv_lexp (cpred c4) c3.
Compute equiv_lexp (cpred c2) c1.
(* PRED DE 0 ?? . IL FAUT RETORUNER  0 !*)
Compute equiv_lexp (cpred c0) c0.

(*factorial*)
(*The Y combinator*)
Definition Y := \f·(\x·f( x x)) (\x · f (x x)).
(*if n = 1, return 1, else cmult n * (n-1)*)
Definition cfonc := \r·\n·cif (ceq0 n) c1 (cmult n (r (cpred n))) .
Definition cfact := Y cfonc.
Compute equiv_lexp (cfact c3) c6.



