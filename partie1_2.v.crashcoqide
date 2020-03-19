(*2eme partie*)
(*booleans*)
Variable T: Set.
Section booleans.
Definition cbool := T -> T -> T.
Definition ccond := cbool -> T -> T -> T.
(*true*)
Definition ctr : cbool := fun x y => x.
(*false*)
Definition cfa : cbool := fun x y => y.
(*if*)
Definition cif : ccond := fun x y z => x y z.
(*not*)
Definition cnot : cbool -> cbool := fun b x y => b y x.
Compute cnot ctr.
Compute cnot cfa.
(*and*)
Definition cand : cbool -> cbool -> cbool := fun a b x y => a (b x y) y.
Compute cand cfa ctr.
(*or*)
Definition cor : cbool -> cbool -> cbool := fun a b x y =>  a x (b x y).
Compute cor cfa ctr.
End booleans.

Section entiers.
Definition cnat := (T->T) -> (T->T).
Definition c0 : cnat := fun f x => x.
Definition c1 : cnat := fun f x => f x.
Definition c2 : cnat := fun f x => f ( f x ).
Definition c3 : cnat := fun f x => f ( f (f x) ) .

Definition csucc : cnat -> cnat := fun n f x => (f (n f x)).
(*test c2. il faut trouver c3 comme result*)
Compute csucc c2.

Definition cadd : cnat -> cnat -> cnat:= fun n m f x => n f (m f x).
(*test c3 + c1. il faut trouver c4 comme result (4 x)*)
Compute cadd c3 c1.
Definition cmult : cnat -> cnat -> cnat  := fun n m f  => n (m f).
(*2*3 = 6*)
Compute cmult c2 c3.
Definition ceq0 : cnat -> cbool  := fun n x y => n (fun z => y)x.
(* c0 == 0? *)
Compute ceq0  c0.
End entiers.