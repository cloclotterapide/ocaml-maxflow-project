

type team = {
  id: int;
  name: string;
  win: int;  
}

type game = {
  team1: team;
  team2: team;
  remaining: int;  
}


(* Functions to build the graph based on cricket data *)
val add_teams : graph -> string -> team list -> graph
val add_games : graph -> string -> game list -> graph
val add_game_team_arcs : graph -> string -> team list -> game list -> graph

(* Utility functions *)
val get_win : string -> team list -> int
val get_remaining : string -> game list -> int

(* Main function to construct the cricket graph *)
val cricketGraph : team -> team list -> game list -> graph