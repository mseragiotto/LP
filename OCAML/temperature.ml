
let c_to_c c = c ;;

let c_to_f c = (c*.(9.0/.5.0))+.32.0 ;;

let c_to_k c = c +. 273.15 ;;

let c_to_ra c = (c+.273.15)*.(9.0/.5.0) ;;

let c_to_d c = (100.0-.c)*.(3.0/.2.0) ;;

let c_to_n c = c*.(33.0/.100.0) ;;

let c_to_re c = c*.(4.0/.5.0) ;;

let c_to_ro c = c*.(21.0/.40.0)+.7.5 ;;


let f_to_c f = (f-.32.0)*.(5.0/.9.0) ;;

let f_to_f f = f ;;

let f_to_k f = (f+.459.67)*.(5.0/.9.0) ;;

let f_to_ra f = f+.459.67 ;;

let f_to_d f = (212.0-.f)*.(5.0/.6.0) ;;

let f_to_n f = (f-.32.0)*.(11.0/.60.0) ;;

let f_to_re f = (f-.32.0)*.(4.0/.9.0) ;;

let f_to_ro f = (f-.32.0)*.(7.0/.24.0)+.7.5 ;;


let k_to_c k = k-.273.15 ;;

let k_to_f k = k*.(9.0/.5.0)-.459.67 ;;

let k_to_k k = k ;;

let k_to_ra k = k*.(9.0/.5.0) ;;

let k_to_d k = (373.15-.k)*.(3.0/.2.0) ;;

let k_to_n k = (k-.273.15)*.(33.0/.100.0) ;;

let k_to_re k = (k-.273.15)*.(4.0/.5.0) ;;

let k_to_ro k = (k-.273.15)*.(21.0/.40.0)+.7.5 ;;


let ra_to_c ra = (ra-.491.67)*.(5.0/.9.0) ;;

let ra_to_f ra = ra-.459.67 ;;

let ra_to_k ra = ra*.(5.0/.9.0) ;;

let ra_to_ra ra = ra ;;

let ra_to_d ra = (671.67-.ra)*.(5.0/.6.0) ;;

let ra_to_n ra = (ra-.491.67)*.(11.0/.60.0) ;;

let ra_to_re ra = (ra-.491.67)*.(4.0/.9.0) ;;

let ra_to_ro ra = (ra-.491.67)*.(7.0/.24.0)+.7.5 ;;


let d_to_c d = 100.0-.d*.(2.0/.3.0) ;;

let d_to_f d =  212.0-.d*.(6.0/.5.0) ;;

let d_to_k d = 373.15-.d*.(2.0/.3.0) ;;

let d_to_ra d =  671.67-.d*.(6.0/.5.0) ;;

let d_to_d d = d ;;

let d_to_n d = 33.0-.d*.(11.0/.50.0) ;;

let d_to_re d = 80.0-.d*.(8.0/.15.0) ;;

let d_to_ro d = 60.0-.d*.(7.0/.20.0) ;;


let n_to_c n = n*.(100.0/.33.0) ;;

let n_to_f n = n*.(60.0/.11.0)+.32.0 ;;

let n_to_k n = n*.(100.0/.33.0)+.273.15 ;;

let n_to_ra n = n*.(60.0/.11.0)+.491.67 ;;

let n_to_d n = (33.0-.n)*.(50.0/.11.0) ;;

let n_to_n n = n ;;

let n_to_re n = n*.(80.0/.33.0) ;;

let n_to_ro n = n*.(35.0/.22.0)+.7.5 ;;


let re_to_c re = re*.(5.0/.4.0) ;;

let re_to_f re = re*.(9.0/.4.0)+.32.0 ;;

let re_to_k re = re*.(5.0/.4.0)+.273.15 ;;

let re_to_ra re = re*.(9.0/.4.0)+.491.67 ;;

let re_to_d re = (80.0-.re)*.(15.0/.8.0) ;;

let re_to_n re = re*.(33.0/.80.0) ;;

let re_to_re re = re ;;

let re_to_ro re = re*.(21.0/.32.0)+.7.5 ;;


let ro_to_c ro = (ro-.7.5)*.(40.0/.21.0) ;;

let ro_to_f ro = (ro-.7.5)*.(24.0/.7.0)+.32.0 ;;

let ro_to_k ro = (ro-.7.5)*.(40.0/.21.0)+.273.15 ;;

let ro_to_ra ro = (ro-.7.5)*.(24.0/.7.0)+.491.67 ;;

let ro_to_d ro = (60.0-.ro)*.(20.0/.7.0) ;;

let ro_to_n ro = (ro-.7.5)*.(22.0/.35.0) ;;

let ro_to_re ro = (ro-.7.5)*.(32.0/.21.0) ;;

let ro_to_ro ro = ro ;;


let c_list = [c_to_c; c_to_f; c_to_k; c_to_ra; c_to_d; c_to_n; c_to_re; c_to_ro];;

let f_list = [f_to_c; f_to_f; f_to_k; f_to_ra; f_to_d; f_to_n; f_to_re; f_to_ro];;

let k_list = [k_to_c; k_to_f; k_to_k; k_to_ra; k_to_d; k_to_n; k_to_re; k_to_ro];;

let ra_list = [ra_to_c; ra_to_f; ra_to_k; ra_to_ra; ra_to_d; ra_to_n; ra_to_re; ra_to_ro];;

let d_list = [d_to_c; d_to_f; d_to_k; d_to_ra; d_to_d; d_to_n; d_to_re; d_to_ro];;

let n_list = [n_to_c; n_to_f; n_to_k; n_to_ra; n_to_d; n_to_n; n_to_re; n_to_ro];;

let re_list = [re_to_c; re_to_f; re_to_k; re_to_ra; re_to_d; re_to_n; re_to_re; re_to_ro];;

let ro_list = [ro_to_c; ro_to_f; ro_to_k; ro_to_ra; ro_to_d; ro_to_n; ro_to_re; ro_to_ro];;

let lists = [("C",c_list); ("F",f_list); ("K",k_list); ("Ra",ra_list); ("D",d_list); ("N",n_list); ("Re",re_list); ("Ro",ro_list)] ;;

let apply_conv l n acc =
	let rec aux acc1 = function
			[] -> acc1
		| h :: t -> aux ((List.map h [n])::acc1) t
	in aux acc l ;;

let conv_table n =
	let rec aux acc = function
			[] -> acc
		| h :: t -> aux (apply_conv (snd h) n acc) t
	in aux [] lists ;;

let extract_el l =
	let rec aux acc = function
			[] -> acc
		| (_::_::_)::_ | [] :: _-> raise Not_found
		| [h] :: t -> aux (h::acc) t
	in aux [] l ;;

let format_conv_table n =
	let rec aux acc counter = function
			[] -> List.rev acc 
		| h1 :: h2 :: h3 :: h4 :: h5 :: h6 :: h7 :: h8 :: t -> 
		let name = fst (List.nth lists counter) in
			aux ((Printf.sprintf "%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t\n" name h1 h2 h3 h4 h5 h6 h7 h8)::acc) (counter+1) t	
	in aux [] 0 (extract_el(conv_table n));;

let print_table n = Printf.printf "\tC\tF\tK\tRa\tD\tN\tRe\tRo\n%s" (String.concat "" (format_conv_table n)) ;;

let get_temperatures n scale =
	let func_list =
		match scale with
			| "" -> raise Not_found
			| "C" -> List.nth lists 0
			| "F" -> List.nth lists 1
			| "K" -> List.nth lists 2
			| "Ra" -> List.nth lists 3
			| "D" -> List.nth lists 4
			| "N" -> List.nth lists 5
			| "Re" -> List.nth lists 6
			| "Ro" -> List.nth lists 7
	in let rec print_line counter = function
			[] -> Printf.printf "\n"
		| h::t -> let name = fst (List.nth lists counter) in
					Printf.printf "%.2f%s " h name; print_line (counter+1) t
	in print_line 0 (extract_el(apply_conv (snd func_list) n []));;


