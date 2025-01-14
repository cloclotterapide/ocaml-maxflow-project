open CricketFile 
open Graph
open Tools


let rec get_win team_name = function
  |[] -> failwith (Printf.sprintf "%s no team with this name (get win)" team_name)
  |{name=name;win=win;id=_}::rest -> if name = team_name then win else get_win team_name rest 


let rec get_remaining team_name = function
  |[] -> 0
  |{team1=team1;team2=team2;remaining=rm}::rest -> if team2.name=team_name || team1.name= team_name then rm + get_remaining team_name rest
  else get_remaining team_name rest


(*let test = get_remaining "coco" [{team1="coco";team2="n";remaining=3};{team1="c";team2="coco";remaining=1};{team1="t";team2="c";remaining=1};{team1="team_name";team2="coco";remaining=0}]*) 

let rec add_teams_aux graph selected_team_name game_list team_list_full = function
  | [] -> graph
  | {name=name;win=_;id=id}::rest -> if name = selected_team_name then add_teams_aux graph selected_team_name game_list team_list_full rest else
      let graph = new_node graph id in
      let graph = add_arc graph id (-2) ((get_win  selected_team_name team_list_full ) + (get_remaining selected_team_name game_list) - (get_win name team_list_full)) in
      add_teams_aux graph selected_team_name game_list team_list_full rest

let add_teams graph selected_team_name game_list team_list = add_teams_aux graph selected_team_name game_list team_list team_list

let game_id team1 team2 = int_of_string ((string_of_int team1.id) ^ "0" ^ (string_of_int team2.id)) 

(*add remaining games to the graph*)
let rec add_games graph selected_team = function
  |[] -> graph
  |{team1 = team1;team2= team2;remaining= rm}::rest -> if team1.name = selected_team.name ||  team2.name = selected_team.name then add_games graph selected_team rest else
    let m_id = game_id team1 team2 in
    let graph = new_node graph m_id in
    (*arc between source and games*)
    let graph = add_arc graph (-1) m_id rm in
   add_games graph selected_team rest


let add_game_arc_aux graph game  = 
  try 
    let graph = add_arc graph (game_id game.team1 game.team2) game.team1.id max_int in
    add_arc graph (game_id game.team1 game.team2) game.team2.id max_int 
  with e ->
    failwith (Printf.sprintf " add_game_aux : %s" (Printexc.to_string e))  

let rec add_game_team_arcs graph selected_team team_list = function
  |[] -> graph
  |({team1=team1;team2=team2;remaining=_} as game )::rest -> 
    let graph =  if team1=selected_team || team2=selected_team then graph else 
      add_game_arc_aux graph game in
      add_game_team_arcs graph selected_team team_list rest



let cricketGraph cricket_data = 
  let selected_team_name = cricket_data.selected_team in
  let team_list = cricket_data.team_list in
  let game_list = cricket_data.game_list in
  let graph = empty_graph in

  (*source and dest nodes*)
  let graph = new_node graph (-1) in
  let graph = new_node graph (-2) in
        
  let graph = add_teams graph selected_team_name game_list team_list in
  let selected_team = get_team_from_name selected_team_name team_list in 
  let graph = add_games graph selected_team game_list in
  add_game_team_arcs graph selected_team team_list game_list 
      

