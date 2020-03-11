(*2eme partie*)
(*booleans*)
Section booleans.
Variable T: Set.
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
(*and*)
Definition cand : cbool -> cbool -> cbool := fun a b x y => a (b x y) y.
(*or*)
Definition cor : cbool -> cbool -> cbool := fun a b x y =>  a x (b x y).

End booleans.
