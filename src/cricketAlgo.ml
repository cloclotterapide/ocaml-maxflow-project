open cricketFile
open FFalgo 


let cricketGraph cricket_data cricketGraph =
  let graph = empty_graph in
  (*source and dest nodes*)
  let graph = new_node graph (-1) in
  let graph = new_node graph (-2) in
  let graph = add_teams graph cricket_data.selected_team cricket_data.team_list in
  let graph = add_matches graph cricket_data.selected_team cricket_data.matches_list in



let rec add_teams graph selected_team = function
  |[] -> graph
  |team::rest -> if team.name = selected_team then graph else
    let graph = new_node graph team.id in 
    in add_teams graph rest


let match_id team1 team2 = team1.id * 100 + team2.id

(*add remaining matches to the graph*)
let rec add_matches graph selected_team = function
  |[] -> graph
  |{team1 = team1;team2 : team2;remaining : rm}::rest -> if team1 = selected_team or team2 = selected_team then graph else
    let m_id = match_id team1 team2 in
    let graph = new_node graph m_id in
    let graph = add_arc graph (-1) m_id rm in
  in add_matches graph rest


