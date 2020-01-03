#load "str.cma";;

let is_palindrome text =
	let regex = Str.regexp "[,|;|.|:|-|_|?|!| ]" in 
	let n_text = Str.global_replace regex "" (String.lowercase_ascii (text)) in
	let rec inverse acc s i =
		if i < String.length s then inverse ((String.sub s i 1)::acc) s (i+1)
		else acc
	in
	String.equal (String.concat "" (inverse [] n_text 0)) n_text;;
	
let (-) s1 s2 = 
	let remove_char ch1 =
		if (String.contains s2 ch1) then '*'
		else ch1
	in String.concat "" (String.split_on_char '*' (String.map remove_char s1));;
