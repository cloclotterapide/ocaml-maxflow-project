open cricketAlgo
open Printf

(* Reads a line describing a team and adds it to the team list *)
val read_wins : team list -> string -> team list

(* Reads a line describing a game and adds it to the game list *)
val read_games : game list -> string -> game list

(* Reads a line containing the selected team *)
val read_selected_team : selected_team -> string -> selected_team

(* Reads the entire cricket file and builds the cricket data structure *)
val read_cricket_file : string -> cricket_data -> cricket_data