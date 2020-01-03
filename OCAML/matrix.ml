
let print_matrix ls = 
	let rec print_lines = function
			[] -> Printf.printf "\n"
		| h :: t -> Printf.printf "%d\t" h; print_lines t
	in 
		let rec aux = function
				[] -> Printf.printf ""
			| hd :: tl -> print_lines hd; aux tl
		in aux ls;;

let zeroes n m =
	let rec line acc m1=
		if m1<>0 then line (0::acc) (m1-1)
		else lines acc [] n
	and lines ln acc n1 =
		if n1<>0 then lines ln (ln::acc) (n1-1)
		else acc
	in line [] m;;

let identity n = 
	let rec aux acc r c = 
		if r = c then aux (1::acc) (r+1) c
		else if r = n then acc
		else aux (0::acc) (r+1) c
	in 
		let rec generate acc r c =
			if (r<n)&&(c<n) then generate ((aux [] r c)::acc) 0 (c+1)
		else acc
	in generate [] 0 0;;

let init n =
	let rec aux acc r c counter = 
		if r = n then List.rev acc
		else aux (counter::acc) (r+1) c (counter+1)
	in 
		let rec generate acc r c counter =
			if (r<n)&&(c<n) then generate ((aux [] r c counter)::acc) 0 (c+1) (counter+n)
		else acc
	in List.rev (generate [] 0 0 0);;

let transpose ls = 
	let rec get_el acc i = function
			[] -> List.rev acc
		| h :: t -> get_el ((List.nth h i)::acc) i t
	in 
	let n = List.length ls in
	let rec visit_matrix acc i = 
		if i<n then visit_matrix ((get_el [] i ls)::acc) (i+1)
		else List.rev acc 
	in visit_matrix [] 0;;
 
 (*Funzione che effettua il map di f sulla lista lists*)
let rec mapn f lists =
  assert (lists <> []); (*Lista ovviamente non vuota*)
  if List.mem [] lists then	(*Se la lista è vuota ritorno vuoto*)
    []
  else						
    f (List.map List.hd lists) :: mapn f (List.map List.tl lists);;
(*Altrimenti ottengo la lista dei primi elementi di ogni riga della matrice e vi applico la funzione, *)
(*inserendo il risultato in una lista in cui accodo le chiamate ricorsive sul resto degli elementi della *)
(*matrice, in modo da ottenere una lista contenente la trasposta "flattened" *)

 
let ( * ) m1 m2 =
  List.map
    (fun row ->
      mapn
       (fun column ->
         List.fold_left (+) 0
          (List.map2 ( * ) row column))
       m2)
    m1;;

(*column effettua la somma ricorsiva sulle moltiplicazioni tra riga e colonna, applicandovi la mapn*)
(*che restituisce la trasposizione dei risultati ottenendo la nuova matrice risultante*)