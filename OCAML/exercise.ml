(*10 run-length encoding of a list*)
let encode list =
    let rec aux count acc = function
      | [] -> [] (* Can only be reached if original list is empty *)
      | [x] -> (count+1, x) :: acc
      | a :: (b :: _ as t) -> if a = b then aux (count + 1) acc t
                              else aux 0 ((count+1,a) :: acc) t in
    List.rev (aux 0 [] list);;

(*14 Duplicate the elements of a list*)
let duplicate list = 
	let rec aux acc = function
		 [] -> acc
		| h :: t -> aux (h::h::acc) t
	in List.rev(aux [] list);;

(*15 Replicate the elements of a list n times*)
let replicate list n = 
	let rec aux counter acc = function
		 [] -> acc
		| h :: t as ls-> if n-counter = 0 then aux 0 acc t
						 else aux (counter+1) (h::acc) ls
	in List.rev(aux 0 [] list);;

(*17 Split list in two part*)
let split l n = 
	let rec aux counter l1 l2 = function
			[] -> ((List.rev(l1)), (List.rev(l2)))
		| h :: t -> if n-counter = 0 then aux n l1 (h::l2) t
					else aux (counter+1) (h::l1) l2 t
	in aux 0 [] [] l;;

(*18 Slice a list*)
let slice l i k = 
	let rec aux counter acc = function
			[] -> List.rev(acc)
		| h :: t -> if counter >= i && counter <= k then aux (counter+1) (h::acc) t
					else aux (counter+1) acc t
	in aux 0 [] l;;

(*20 Remove the kth element from a list*)
let remove_at k l =
	let rec aux counter acc = function
			[] -> List.rev(acc)
		| h :: t -> if counter = k then aux (counter+1) acc t
					else aux (counter+1) (h::acc) t
	in aux 0 [] l;;

(*21 Insert an element at a given position into a list*)
let insert_at el k l =
	let rec aux counter acc = function
			[] -> List.rev(acc)
		| h :: t -> if counter = k-1 then aux (counter+1) (el::h::acc) t
					else aux (counter+1) (h::acc) t
	in aux 0 [] l;;

(*22 List containing all integers within a given range*)
let range a b = 
	let rec aux acc h l =
		if h >= l then aux (h::acc) (h-1) l
		else acc
	in 
		if a < b then aux [] b a 
		else List.rev (aux [] a b);;	
		(*la strategia è creare la funzione universale da utilizzare con input diversi in base al caso*)

(*23 extract a given number of randomly selected elements from a list*)
let rand_select list n =

	(*funzione che estrae n volte gli elementi di una lista e li inserisce in un accumulatore*)
    (*Alla fine delle n volte (a meno di esaurimento della lista) estrae una tupla avente l'ultimo*)
    (*valore estratto ed il resto della lista*)
    let rec extract acc n = function
      | [] -> raise Not_found
      | h :: t -> if n = 0 then (h, acc @ t) else extract (h::acc) (n-1) t
    in

    (*funzione che richiama la extract con un numero di tentativi randomico inferiore alla lunghezza*)
    (*della lista stessa*)
    let extract_rand list len =
      extract [] (Random.int len) list
    in


    let rec aux n acc list len =
      if n = 0 then acc 
  	  else

      	(*tramite pattern matching picked rappresenta il valore estratto dalla extract_rand e rest il resto*)
      	(*della lista, presi nelle rispettive posizioni*)
        let picked, rest = 
        	extract_rand list len 
    	in

    	(*aux inserisce nell'accumulatore l'elemento preso randomicamente, fino ad esaurire il numero n*)
    	(*che rappresenta il numero di valori randomici da estrarre dalla lista. Se viene esaurito, è *)
    	(*restituito l'accumulatore, altrimenti prosegue l'inserimento estraendo ad ogni ciclo ricorsivo*)
        aux (n-1) (picked :: acc) rest (len-1)
    in

    (*len è la variabile che rappresenta la lunghezza della lista in input*)
    let len = List.length list 
	in

	(*questa è la prima chiamata di aux, che sceglie il minimo tra n e la lunghezza della lista, per gestire*)
	(*il caso in cui si richiedano troppi numeri, usa accumulatore vuoto, la lista e la sua lunghezza*)
    aux (min n len) [] list len;;

(*25 Random permutation of the elements of a list*)
let permutation list = 
	let rec extract acc n = function
		|	[] -> raise Not_found
		| hd :: tl -> if n = 0 then (hd, acc @ tl) 
	    			  else extract (hd::acc) (n-1) tl
	in 
	let extract_rand l len =
		extract [] (Random.int len) list
	in 
	let len = List.length list in
	let rec aux acc = function
			[] -> acc
		| h :: t -> let picked, rest = extract_rand list len in
					aux (picked::acc) t
	in aux [] list;;

(*26 Determine whether a given integer number is prime*)
let is_prime n =
	let rec create_list acc counter =	(*creo la lista di numeri da 1 a n*)
		if counter <= n then create_list (counter::acc) (counter+1)
		else List.rev acc
	in 
	let rec remove_mult el acc = function	(*rimuovo i multipli di el nella lista*)
			[] -> List.rev acc
		| h :: t -> if ((h mod el) = 0) && (h<>2) then remove_mult el acc t
					else remove_mult el (h::acc) t	
	in
	let n_list = create_list [] n 
	in 
	let rec visit acc = function
			[] -> acc
		| (hd :: tl) as l -> visit ((remove_mult hd [] l)::acc) tl
	in visit [] n_list;;
(*DA RIFARE*)

(*27 Determine the greatest common divisor of two positive integer numbers*)
let mcd a b =
	if b = 0 && a = 0 then raise Not_found
	else if b = 0 && b < a then a
    else if a = 0 && a < b then b
    else 
    let rec aux d r =
    	if r<>0 then aux r (d mod r) 
    	else d
    in if a > b then aux b (a mod b) else aux a (b mod a);;

(*28 Determine whether two positive integer numbers are coprime*)
let coprime a b =
	if (mcd a b) = 1 then true
	else false;;