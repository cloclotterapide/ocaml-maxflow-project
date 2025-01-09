open FFalgo
open Graph
open Printf

type team =
  {name : String;
  win : int}


(* Reads a line with a node. *)
let read_wins team_list line =
  try Scanf.sscanf line "%s %d " (fun tname twin -> team_list = {name=tname;win=twin}::team_list)
  with e ->
    Printf.printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Ensure that the given node exists in the graph. If not, create it. 
 * (Necessary because the website we use to create online graphs does not generate correct files when some nodes have been deleted.) *)
let ensure graph id = if node_exists graph id then graph else new_node graph id

(* Reads a line with an arc. *)
let read_matchs graph line =
  try Scanf.sscanf line "%s %s %d"
        (fun src tgt lbl -> let lbl = String.trim lbl in new_arc (ensure (ensure graph src) tgt) { src ; tgt ; lbl } )
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads a comment or fail. *)
let read_comment graph line =
  try Scanf.sscanf line " %%" graph
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "from_file"



let export graph path =

  (* Open a write-file. *)
  let ff = open_out path in

  (* Write in this file. *)
  fprintf ff "digraph finite_state_machine {\n
  fontname=\"Helvetica,Arial,sans-serif\"\n
	node [fontname=\"Helvetica,Arial,sans-serif\"]\n
	edge [fontname=\"Helvetica,Arial,sans-serif\"]\n
	rankdir=LR;\nnode [shape = circle];" ;

  (* Write all arcs *)
  let _ = e_fold graph (fun count arc -> fprintf ff "%d -> %d [label = \"%s\"];\n" arc.src arc.tgt arc.lbl ; count + 1) 0 in
  
  fprintf ff "}\n" ;
  
  close_out ff ;
  ()


let from_file path =

  let infile = open_in path in

  (* Read all lines until end of file. *)
  let rec loop graph =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let graph2 =
        (* Ignore empty lines *)
        if line = "" then graph

        (* The first character of a line determines its content : n or e. *)
        else match line.[0] with
          | 'n' -> read_node graph line
          | 'e' -> read_arc graph line

          (* It should be a comment, otherwise we complain. *)
          | _ -> read_comment graph line
      in      
      loop graph2

    with End_of_file -> graph (* Done *)
  in

  let final_graph = loop empty_graph in
  
  close_in infile ;
  final_graph