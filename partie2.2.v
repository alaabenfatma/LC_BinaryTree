
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
(*booleans*)
Definition pbool : Set := forall T : Set, T -> T -> T.
(*vrai*)
Definition ptr : pbool := fun T:Set => fun x:T => fun y:T => y .
(*faux*)
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
Compute conjonc ptr pfa.
Compute conjonc pfa ptr.

(*disonj*)
Definition disjonc : pbool -> pbool -> pbool := fun a b => a pbool a b.

Compute disjonc ptr pfa.
Compute disjonc pfa ptr.


(*3 si vrai. 5, sinon.*)
Definition foo35 : pbool -> nat := fun b => b nat 5 3.
Compute foo35 ptr.

(*BONUS : lui-meme*)
Definition bluimeme : pbool -> pbool := fun b => b pbool b b.

(*2.2.3.1*)

(*A -> B -> T) ->T*)
Definition pprod_nb : Set := forall T: Set, (nat -> bool -> T) -> T.
Definition pcpl_nb : nat -> bool -> pprod_nb := fun a b => fun T => fun k => k a b.

(* (5,true) *)
Compute pcpl_nb 5 true.
(*2.2.3.2*)
Definition pprod_bn : Set := forall T: Set, (bool -> nat -> T) -> T.
Definition pcpl_bn : bool -> nat -> pprod_bn := fun a b => fun T => fun k => k a b.
(* (true,5) *)
Compute pcpl_bn true 5.

(*2.2.3.3*)
Definition convertProd : pprod_nb -> pprod_bn := fun c => c pprod_bn (fun n b => pcpl_bn b n).
(*TEST : (5,true) => (true, 5)*)
Definition c1 := pcpl_nb 5 true.
Definition res := convertProd c1.
Compute c1.
Compute res.
(*produit universel*)
Definition pprod : Set -> Set -> Set := fun A B => forall T:Set, (A -> B -> T) -> T.
Definition pcpl : forall A B:Set, A -> B -> pprod A B := fun A B:Set => fun (a:A) (b:B) => fun T:Set => fun k:(A -> B -> T) => k a b.
(* couple = (99,true) *)
Compute pcpl nat bool 99 true.
(* couple = (1,0) *)
Compute pcpl nat nat 1 0.
(* couple = (1,(3, si vrai, 5 sinon) *)
Compute pcpl pbool nat ptr (foo35 ptr).


(*Choix (Sommes de Types) *)
(*On a juste implementé ça : A+B = ∀T, (A→T)→(B→T)→T.)*)
Definition psom (A B : Set) : Set := forall T:Set, (A -> T) -> (B -> T) -> T.
Definition inj1 (A B : Set) : A -> psom A B := fun a => fun T:Set => fun k1 : (A ->  T) => fun k2 : (B ->  T) => k1 a.
(*Inspirée par inj1*)
Definition inj2 (A B : Set) : B -> psom A B := fun b => fun T:Set => fun k1 : (A ->  T) => fun k2 : (B ->  T) => k2 b.

(*2.2.4  Entiers de Church avec typage polymorphe *)

(*Base form*)
(*On a re-utilisé les definitions de la partie1.v*)
Definition pnat := forall (T:Set), (T->T) -> (T->T).
Definition p0 : pnat := fun (T:Set) => fun (f:T->T) => fun (x:T) => x.
Definition p1 : pnat := fun (T:Set) => fun (f:T->T) => fun (x:T) => f x.
Definition p2 : pnat := fun (T:Set) => fun (f:T->T) => fun (x:T) => f (f x).
Definition p3 : pnat := fun (T:Set) => fun (f:T->T) => fun (x:T) => f (f (f x)).
Definition pS : pnat -> pnat :=  fun (n: pnat) => fun (T : Set) f  x => f (n  T f x).
(*Definition cadd := \n m·\f x·n f(m f x).*)
Definition padd : pnat -> pnat -> pnat := fun n m => fun f x => n f (m f x ).
(* 2 + 3 = 5 *)
Compute padd p2 p3.
(*Definition ceq0 := \n·\x y· n(\z·x) y.*)
Definition pmult : pnat -> pnat -> pnat := fun m n =>  fun T:Set => (fun f => n T (m T f)).
(* 2 X 3 = 6 *)
Compute pmult p2 p3.
(*Definition ceq0 := \n·\x y· n(\z·x) y.*)
Definition peq0 : pnat -> pbool := fun n => fun T:Set => fun (x:T) (y:T) => (n T (fun z => y) x).
(* 3 X 0 == 0 ? *)
Compute peq0 (pmult p3 p0).
(* 3 == 0 ? *)
Compute peq0  p3.

(* special pplus *)
Definition pplus : pnat -> pnat -> pnat := fun n : pnat => fun m : pnat =>  n pnat pS m.
(* Test : 1 + 3 *)
Compute pplus p1 p3.

