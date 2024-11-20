open Graph

(*returns a new graph having the same nodes than gr, but no arc*)
let clone_nodes gr = n_fold gr (new_node) empty_graph

(* maps all arcs of gr by function f*)
let gmap gr f = e_fold gr (fun bgr arc -> new_arc bgr {arc with lbl=(f arc.lbl)}) (clone_nodes gr)

(*adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created.*)
let add_arc gr id1 id2 n = match (find_arc gr id1 id2) with 
  |None -> new_arc gr {src= id1;tgt=id2;lbl=n}
  |Some arc -> new_arc gr {src= id1;tgt=id2;lbl=n+arc.lbl}


