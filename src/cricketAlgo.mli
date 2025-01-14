open CricketFile
open Graph


(* Functions to build the graph based on cricket data *)
val add_teams : id graph -> selected_team -> game list -> team list -> id graph
val add_games : id graph -> team -> game list -> id graph
val add_game_team_arcs : id graph -> team -> 'a -> game list -> id graph

(* Utility functions *)
val get_win : string -> team list -> int
val get_remaining : string -> game list -> int

(* Main function to construct the cricket graph *)
val cricketGraph : cricket_data -> id graph