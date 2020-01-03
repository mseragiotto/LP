open Pervasives
open Printf
open Filename
 
let read_file filename = 
	let channel = open_in filename in
	let s = really_input_string channel (in_channel_length channel) in
	close_in channel;
	String.lowercase_ascii (String.trim s)

let frequencies text =
	let t_list = String.split_on_char ' ' text in 
	let f_list = [] in 
	let rec contains el = function
				[] -> false
			| (s, n)::t ->  if s = el then true
							else contains el t
	in
	let rec update acc el = function
				[] ->  if (contains el acc) then acc
							else (el,1)::acc		  
			| (s, n)::t ->  if s = el then update ((s,(n+1))::acc) el t
							else update ((s,n)::acc) el t
	in
	let rec aux acc = function
		[] -> acc
		| h :: t -> aux (update [] h acc) t
	in aux f_list t_list ;;

let get_frequencies filename = 
	frequencies (read_file filename);;
