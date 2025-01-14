# OCaml Maxflow Project

## Minimum project 
- Fonctionne pour tous les fichier graphes avec lesquels nous avons testé


## Medium project : Cricket use-case !
- Testé avec différents fichiers en entrée, ils fonctionne dans tous les cas que nous avons testé
  
- Format du fichier texte d'entrée :
   - Format d'une team : t nom_team nb_win
   - Format d'un match : r nom_team_1 nom_team_2 nb_rencontres_restantes
   - Format équipe choisi : s nom_team

- Makefile modifié avec un champ "state" :
   - state = 0 pour afficher le graphe initial (avant qu'on lui applique Ford-Fulkerson)
   - state = 1 pour afficher le graphe finanl (après qu'on lui applique Ford-Fulkerson)

- Résultat final : le graphe indiquant comment l'équipe sélectionnée peut gagner
