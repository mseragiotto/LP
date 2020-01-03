let alkaline_earth_metals = [("beryllium",6);("magnesium",12);("calcium",20);("strontium",38);("barium",56);("radium",88)];;

(*1 - Write a function that returns the highest atomic number in alkaline_earth_metals.*)

(*Ordinamento generico lista*)
let rec generic_sort lst =
   match lst with
     [] -> []
   | head :: tail -> insert head (generic_sort tail)
 and insert elt lst =
   match lst with
     [] -> [elt]
   | head :: tail -> if elt <= head then elt :: lst else head :: insert elt tail;;


(*Ordinamento per seconda componente elemento lista*)
let rec sort lst =
   match lst with
     [] -> []
   | head :: tail -> insert_num head (sort tail)
 and insert_num elt lst =
   match lst with
     [] -> [elt]
   | head :: tail -> if (snd elt) <= (snd head) then elt :: lst else head :: insert_num elt tail;;

(*Estrazione elemento con numero atomico più grande*)

let rec last_element lst =
	match lst with  
	 [] -> []
	| h :: [] -> h
	| hd :: tl -> last_element tl 

let highest lst =
	let sorted_list = sort lst in
	last_element sorted_list


(*Write a function that sorts alkaline_earth_metals in ascending order (from the lightest to the heaviest).*)


(*Put into a second list, called noble_gases, the noble gases: helium (2), neon (10), argon (18), krypton (36), xenon (54), and radon (86).*)

let noble_gases = [("helium",2);("neon",10);("argon",18);("krypton",36);("xenon",54);("radon",86)];;

(*Write a function (or a group of functions) that merges the two lists and print the result as couples (name, atomic number) sorted in ascending order on the element names.*)

