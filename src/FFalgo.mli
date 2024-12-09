open Graph

val find_path :int graph -> id -> id -> int arc list

val print_path :'a arc list -> unit

val min_list : int Graph.arc list -> int

val update_path : id graph -> id -> 'a arc list -> id graph

val ffalgo : id graph -> id -> id -> id graph

val solution : id graph -> id graph -> id graph