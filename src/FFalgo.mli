open Graph
(*Find a path between to node and return the list of arcs visited*)
val find_path :int graph -> id -> id -> int arc list

(*print a path*)
val print_path :'a arc list -> unit

(*return the value of the arc with the lowest label *)
val min_list : int arc list -> int

(*Update the path with a new arc*)
val update_path : id graph -> id -> 'a arc list -> id graph

(*Applu the Ford Fulkerson algorithm from one node to another and returns the residual graph*)
val ffalgo : id graph -> id -> id -> id graph

(*Returns the *)
val solution : id graph -> id graph -> id graph