type selected_team = string

type team = {
  name: string;
  win: int;
  id: int
}

type game = {
  team1: team;
  team2: team;
  remaining: int
}

type cricket_data ={
  team_list : team list;
  game_list : game list;
  selected_team : selected_team
} 


(* Reads teams *)
let read_wins team_list line =
  try Scanf.sscanf line "t %s %d " (fun tname twin -> {name=tname;win=twin;id=((List.length team_list) + 1)}::team_list)
  with e ->
    Printf.printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"


let rec get_team_from_name name = function
  |[] ->{name="no team with this name";win=(-100);id=(-100)} 
  |team::rest -> if team.name = name then team else get_team_from_name name rest

(* Reads games *)
let read_games game_list line tlist =
  try Scanf.sscanf line "r  %s %s %d"
        (fun team1 team2 rm ->{team1=(get_team_from_name team1 tlist);team2=(get_team_from_name team2 tlist);remaining=rm}::game_list)
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads selected team *)
let read_selected_team line =
  try Scanf.sscanf line "s %s" (fun team -> team)
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"


let read_cricket_file path =
    let infile = open_in path in
    let rec read_cricket_aux cricket_data =
        try
          let line = input_line infile in
          let line = String.trim line in
          let cricket_data =
            if line = "" then cricket_data
            (* The first character of a line determines its content : t or r. *)
            else match line.[0] with
            | 't' -> {cricket_data with team_list = read_wins cricket_data.team_list line}
            | 'r' -> {cricket_data with game_list = read_games cricket_data.game_list line cricket_data.team_list}
            | 's' -> {cricket_data with selected_team = read_selected_team line}
              (* It should be a comment, otherwise we complain. *)
              | _ -> cricket_data
          in    
            read_cricket_aux cricket_data

        with End_of_file -> cricket_data in

    let final_cricket_data = read_cricket_aux {team_list=[];game_list= []; selected_team=""} 
  in
  
  close_in infile ;
  final_cricket_data