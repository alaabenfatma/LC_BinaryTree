(*partie 2.2*)
(* ATTENTION !!!!!
Il faut lancer coqide avec la cmd = coqide -impredicative-set*) 
(*L'identité polymorphe*)
Definition tid : Set := forall T : Set, T -> T.
Definition id : tid := fun T:Set => fun x : T => x.

(*TESTS OF IDENTITY*)
(* 5 est nat? *)
Compute id nat 5.
(* true est boolean? *)
Compute id bool true.
(* BAD TEST | UNCOMMENT *)
(*Compute id bool 0.*)

Definition nbtrue1 := 
fun b => match b with true => 1 | 
false => 0 end.

(*Verif : la fonction rend bien un nat*)
Compute id nat (nbtrue1 false).

Compute id tid id.