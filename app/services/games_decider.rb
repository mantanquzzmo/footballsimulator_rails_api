module GamesDecider
  def games_decider(games)

    games.each {|game|
    hometeam = game.teams[0]
    awayteam = game.teams[1]

    ## calculate each players value

    ## calculate game result

    ## make copy and insert player performance

    ## update original player new form

    

    ht_gk = hometeam.players.where(starting_11: true, position: "G")
    at_gk = awayteam.players.where(starting_11: true, position: "G")
    ht_def = hometeam.players.where(starting_11: true, position: "D")
    at_def = awayteam.players.where(starting_11: true, position: "D")
    ht_mid = hometeam.players.where(starting_11: true, position: "M")
    at_mid = awayteam.players.where(starting_11: true, position: "M")
    ht_att = hometeam.players.where(starting_11: true, position: "A")
    at_att = awayteam.players.where(starting_11: true, position: "A")
    
  }

  end
end