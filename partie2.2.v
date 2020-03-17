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
Definition ptr : pbool := fun T:Set => fun x:T => fun y:T => y .
Definition pfa : pbool := fun T:Set => fun (x:T) (y:T) => x.
Print ptr.
Print pfa.

(*first negation*)
Definition cneg1 : pbool -> pbool := fun b => fun T:Set => fun x => fun y => b T x y.

Compute cneg1 ptr.
(*second negation*)
Definition cneg2 : pbool -> pbool:= fun b => b pbool pfa ptr.

Compute cneg2 ptr.

(*conj*)
Definition conjonc : pbool -> pbool -> pbool := fun a b => a pbool b a.
(*disonj*)
Definition disjonc : pbool -> pbool -> pbool := fun a b => a pbool a b.

(*3 si vrai. 5, sinon.*)
Definition foo35 : pbool -> nat := fun b => b nat 5 3.
Compute foo35 ptr.

(*BONUS : lui-meme*)
Definition bluimeme : pbool -> pbool := fun b => b pbool b b.

(*2.2.3.1*)
(*A -> B -> T) ->T*)
Definition pprod_nb : Set := forall T: Set, (nat -> bool -> T) -> T.
Definition pcpl_nb : nat -> bool -> pprod_nb := fun a b => fun T => fun k => k a b.
(*2.2.3.2*)
Definition pprod_bn : Set := forall T: Set, (bool -> nat -> T) -> T.
Definition pcpl_bn : bool -> nat -> pprod_bn := fun a b => fun T => fun k => k a b.
(*2.2.3.3*)
Definition convertProd : pprod_nb -> pprod_bn := fun c => c pprod_bn (fun n b => pcpl_bn b n).
(*TEST : (5,true) => (true, 5)*)
Definition c1 := pcpl_nb 5 true.
Definition res := convertProd c1.
Compute c1.
Compute res.