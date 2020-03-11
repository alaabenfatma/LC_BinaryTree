(*partie 2.2*)
(* ATTENTION !!!!!
Il faut lancer coqide avec la cmd = coqide -impredicative-set*) 
(*L'identité polymorphe*)
(*2.2.1*)
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
(*2.2.2*)
Definition pbool : Set := forall T : Set, T -> T -> T.
Definition ptr : pbool := fun T:Set => fun x y: T => x.
Definition pfa : pbool := fun T:Set => fun x y: T => y.
Print ptr.
Print pfa.
(*first negation*)

(*second negation*)