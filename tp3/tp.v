Definition p12 := fun x => 2 + x.
Print p12.
Definition p13 := p12 3.

Compute p12 5.
Compute p13.
Definition f := (fun x y => x - y) 8 10.
Compute f.

Section sec_1.

Variable y : nat.

Definition ply := fun x y => x + y.

Compute ply 10 5.
End sec_1.

Variable T : Set.
Variable y : T.

Section type_boolean.
Variable T: Set.
Definition cbool := T -> T -> T.
Definition ccond := cbool -> T -> T -> T.
(*true*)
Definition ctr : cbool := fun x y => x.
(*false*)
Definition cfa : cbool := fun x y => y.

Definition cif : ccond := fun x y z => x y z.

Compute cif ctr.
Definition cnot : ccond := fun b x y => b y x.
Compute cnot ctr.