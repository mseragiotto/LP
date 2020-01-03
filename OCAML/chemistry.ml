type element = { name : string; number : int} ;;

let alkaline_earth_metals = [
{name="beryllium"; number=4};
{name="magnesium"; number=12};
{name="calcium"; number=20};
{name="strontium"; number=38};
{name="barium"; number=56};
{name="radium"; number=88}
] ;;

let sort l =
	let rec aux acc max = function
			[] -> acc
		| h :: t -> if h.number > max then aux (h::acc) h.number t
					else aux acc max t
	in aux [] 0 l ;;

let highest l =
	let high_element = sort l in
	match high_element with
			[] -> raise Not_found
		| h :: t -> h ;;

let inverse_sort l = List.rev (sort l) ;;

let noble_gases = [
{name="helium"; number=2};
{name="neon"; number=10};
{name="argon"; number=18};
{name="krypton"; number=36};
{name="xenon"; number=54};
{name="radon"; number=86}
] ;;

let rec name_sort lst =
   match lst with
    	[] -> []
    | head :: tail -> insert_name head (name_sort tail)
 and insert_name elt lst =
   match lst with
    	[] -> [elt]
    | head :: tail -> if elt <= head then elt :: lst else head :: insert_name elt tail;;

let merge_and_sort l1 l2 = 
	let merged_list =
	match (l1,l2) with
			[],[] -> []
		| [], [_] -> l2
		| [_], [] -> l1
		| _,_ -> List.append l1 l2 
	in name_sort merged_list;;

