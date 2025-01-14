open Graph
open Tools
let find_path gr idsrc iddest =
  let rec find_path_acu idsrc acu = if idsrc = iddest then acu else 
    let arc_list = (out_arcs gr idsrc) in (*retirer les elements qui sont deja dans l'acu pour retirer les boucles*)
      let rec find_next = function
        |[] -> []
        |arc::rest -> if List.exists (fun x -> x.tgt == arc.tgt) acu || arc.lbl == 0 then find_next rest else
          let result = find_path_acu (arc.tgt) (arc::acu) in 
           if result == [] then find_next rest else result
      in
      find_next arc_list
    in
  List.rev (find_path_acu idsrc [])
  ;;


let rec print_path = function 
  |[] -> ()
  |arc::l -> Printf.printf "%d ; %d \n" arc.src arc.tgt; print_path l

  
let min_list path =
  let rec min_list_acu acu = function
  |[] -> acu
  |x::rest -> min_list_acu (min x.lbl acu) rest
in min_list_acu max_int path


let rec update_path gr min = function
|[]-> gr
|arc::rest -> let gr = add_arc gr arc.src arc.tgt (-min) in  
              let gr = add_arc gr arc.tgt arc.src min in
              update_path gr min rest


let rec ffalgo gr idsrc iddest = match (find_path gr idsrc iddest) with
  |[] -> gr
  |path -> Printf.printf " min : %d \n%!" (min_list path);ffalgo (update_path gr (min_list path) path) idsrc iddest


(*gri is the initial graph and gre is the residual graph*)
let solution gri gre = 
let aux ngr arci = match (find_arc gre arci.src arci.tgt) with
  |None -> assert false
  |Some arce -> if arce.lbl < arci.lbl then Tools.add_arc ngr arci.src arci.tgt (arci.lbl - arce.lbl) else ngr
in
e_fold gri aux (Tools.clone_nodes gri) 