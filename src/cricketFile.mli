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
  selected_team : string
} 

val get_team_from_name : selected_team -> team list -> team 

(* Reads a line describing a team and adds it to the team list *)
val read_wins : team list -> string -> team list

(* Reads a line describing a game and adds it to the game list *)
val read_games : game list -> selected_team -> team list -> game list

(* Reads a line containing the selected team *)
val read_selected_team : selected_team -> selected_team

(* Reads the entire cricket file and builds the cricket data structure *)
val read_cricket_file : string -> cricket_data

val show_team : team -> string

val show_game : game -> string

val show_cricket_data : cricket_data -> unit