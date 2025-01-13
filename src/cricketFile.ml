open Printf
open cricketAlgo


(* Reads teams *)
let read_wins team_list line =
  try Scanf.sscanf line "t %s %d " (fun tname twin -> team_list = {name=tname;win=twin;id=((length team_list) + 1)}::team_list)
  with e ->
    Printf.printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"


(* Reads games *)
let read_games game_list line =
  try Scanf.sscanf line "r  %s %s %d"
        (fun team1 team2 rm -> game_list = {team1=team1;team2=team2;remaining=rm}::game_list)
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads selected team *)
let read_selected_team selected_team line =
  try Scanf.sscanf line "s %s" (fun team -> selected_team = team)
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"


let read_cricket_file path cricket_data =
  let infile = open_in path in
    let rec loop cricket_data =

        if line = "" then cricket_data
        (* The first character of a line determines its content : t or r. *)
        else match line.[0] with
          | 't' -> read_wins cricket_data.team_list line
          | 'r' -> read_games cricket_data.game_list line
          | 'c' -> read_selected_team cricket_data.selected_team line
          (* It should be a comment, otherwise we complain. *)
          | _ -> read_comment line
         in      
          loop cricket_data

     with End_of_file -> cricket_data

  let final_cricket_data = loop {team_list=[];game_list= []; selected_team=""} in
  
  close_in infile ;
  final_cricket_data


