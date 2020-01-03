module Graph = struct
	
	type 'a graph = Graph of ('a list) * (('a * 'a) list)
	let empty() = Graph([], [])

	type node = string
	type vertices = node * node

	
	let nodes = []
	let archList = []

	let addNode n =
		List.append [n] nodes

	let rec removeNode n acc = function
			[] -> acc
		| h::t -> 	if h=n then removeNode n acc
					else removeNode n (h::acc)

	let rec contains n = function
			[] -> false
		| h::t ->	if h=n then true
					else contains n t

	let rec