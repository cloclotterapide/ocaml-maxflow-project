open cricketFile
open FFalgo 


let cricketGraph cricket_data cricketGraph =
  let selected_team = cricket_data.selected_team in
  let team_list = cricket_data.team_list in
  let game_list = cricket_data.game_list in
  let graph = empty_graph in
  (*source and dest nodes*)
  let graph = new_node graph (-1) in
  let graph = new_node graph (-2) in
  let graph = add_teams graph selected_team team_list game_list in
  let graph = add_games graph selected_team game_list in
  let graph = add_game_team_arcs graph selected_team team_list game_list


let rec get_win team_name = function
  |[] -> failwith "no team with this name"
  |team::rest -> if team.name == team_name then team.win else get_win rest 


let rec get_remaining team_name = function
  |[] -> 0
  |{team1=team1;team2=team2;remaining=rm}::rest -> if team2=team_name || team1= team_name then rm + get_remaining team_name rest
  else get_remaining team_name rest


(*let test = get_remaining "coco" [{team1="coco";team2="n";remaining=3};{team1="c";team2="coco";remaining=1};{team1="t";team2="c";remaining=1};{team1="team_name";team2="coco";remaining=0}]*) 


let rec add_teams graph selected_team game_list = function
  |[] -> graph
  |team::rest -> if team.name = selected_team then graph else
    let graph = new_node graph team.id in 
    let graph = new_arc graph team.id (-1) ((get_win selected_team) + (get_remaining selected_team game_list) - (get_win team.name) )
    in add_teams graph rest

let game_id team1 team2 = int_of_string ((string_of_int team1.id) ^ "0" ^ (string_of_int team2.id)) 

(*add remaining games to the graph*)
let rec add_games graph selected_team = function
  |[] -> graph
  |{team1 = team1;team2 : team2;remaining : rm}::rest -> if team1 = selected_team or team2 = selected_team then graph else
    let m_id = game_id team1 team2 in
    let graph = new_node graph m_id in
    (*arc between source and games*)
    let graph = add_arc graph (-1) m_id rm in
  in add_games graph rest


let add_game_arc_aux graph game team_list = 
  let graph = new_arc graph (game_id gamee.team1 game.team2) team1.id Int32.max_int in
  new_arc graph (game_id gamee.team1 game.team2) team2.id Int32.max_int 

let rec add_game_team_arcs graph selected_team team_list = function
  |[] -> graph
  |({team1=team1;team2=team2;rm=_} as game )::rest -> 
    let graph = if team1=selected_team || team2=selected_team then graph else
      add_game_arc_aux graph game game_list in
      add_game_team_arcs graph selected_team rest


