open FFalgo
open Graph
open Printf

type team =
  {name : String;
  win : int}

type match =
  {team1 : String;
  team2 : String;
  remaining : int}

(* Reads teams *)
let read_wins team_list line =
  try Scanf.sscanf line "%s %d " (fun tname twin -> team_list = {name=tname;win=twin}::team_list)
  with e ->
    Printf.printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"


(* Reads matches *)
let read_matchs matches_list line =
  try Scanf.sscanf line "%s %s %d"
        (fun team1 team2 rm -> matches_list = {team1=team1;team2=team2;remaining=rm}::matches_list)
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads a comment or fail. *)
let read_switch switch line =
  try Scanf.sscanf line " %s" = fun(switch -> switch = true)
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;



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