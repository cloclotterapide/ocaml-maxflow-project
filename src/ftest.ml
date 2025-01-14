open Gfile
open Tools
open FFalgo
open CricketAlgo
open CricketFile

let () =
  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 6 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  let cricket_data = read_cricket_file infile in
  let () = show_cricket_data cricket_data in

  let cricket_graph = cricketGraph cricket_data in
  
  let cricket_final = if Sys.argv.(5) = "1" then solution cricket_graph (ffalgo cricket_graph (-1) (-2)) else cricket_graph in 

  let cricket_final = gmap cricket_final (fun x-> string_of_int x)  in
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile cricket_final in

  let () = export cricket_final outfile in 
  
  ()
  (*
  (* Open file *)
  let graph = from_file infile in

  (*let graph = clone_nodes graph in *)
  let graph = gmap graph (fun x-> int_of_string x)  in

  let chemin = find_path graph 0 9 in
  let () = print_path chemin in 


  
  let chemin_min = min_list chemin in
  let () = Printf.printf " min : %d\n" chemin_min in


  let graph = FFalgo.solution graph (FFalgo.ffalgo graph 0 9) in

  let graph = gmap graph (fun x-> string_of_int x)  in
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  let () = export graph outfile in

  ()
 *)
