
type element = {name: string; number: int};;

let alkaline_earth_metals = [ 
  {name = "barium"; number = 56};
  {name = "beryllium"; number = 4};
  {name = "calcium"; number = 20};
  {name = "magnesium"; number = 12};
  {name = "radium"; number = 88};
  {name = "strontium"; number = 38};
];;

let print_elements = function
     [] -> Printf.printf "[]\n"
    | l ->  let print_element el =
              Printf.printf "(%s, %d)\n" el.name el.number
            in 
              List.iter (print_element) l;;

(*Element's name sorting*)
let rec name_sort lst =
   match lst with
     [] -> []
   | head :: tail -> insert_name head (name_sort tail)
 and insert_name elt lst =
   match lst with
     [] -> [elt]
   | head :: tail -> if elt <= head then elt :: lst else head :: insert_name elt tail;;


(*Element's number sorting*)
let rec element_sort lst =
   match lst with
     [] -> []
   | head :: tail -> insert_num head (element_sort tail)
 and insert_num elt lst =
   match lst with
     [] -> [elt]
   | head :: tail -> if elt.number <= head.number then elt :: lst else head :: insert_num elt tail;;

(*The last element of the list*)
let rec latest (l: element list) = 
  match l with
    [] -> []
  | x :: [] -> [x]
  | h :: t -> latest t;; 