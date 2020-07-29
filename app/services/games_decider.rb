module GamesDecider
  def games_decider(games)

    games.each {|game|
    hometeam = game.teams[0]
    awayteam = game.teams[1]

    ## calculate each players value
    hometeam.players.where(starting_11: true).each{|player|
      match_performance = player_performance(player)
      new_form = form_calculator(player, match_performance)
      binding.pry



      player_match_clone = player.dup
      player_match_clone.update(performance: player_performance(player))

      }

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

  def player_performance(player)

    player_performance = player.skill

    case player.form
    when 1..5
      player_performance = player.skill * 0.75
    when 6..10
      player_performance = player.skill * 0.85
    when 11..15
      player_performance = player.skill * 1.15
    when 16..20
      player_performance = player.skill * 1.25 
    end
    
    case player.form_tendency
    when 1
      player_performance = player_performance * 0.9
    when 2
      player_performance = player_performance * 0.95
    when 3
      player_performance = player_performance
    when 4
      player_performance = player_performance * 1.05
    when 5
      player_performance = player_performance * 1.1
    end
  end

  def form_calculator(player, match_performance)


    new_form = nil
    random = rand() * player.form_tendency

    case random
    when 0.0..0.25
      new_form = player.form - ((player.skill - match_performance) * player.form_tendency)
    when 0.26..0.75
      new_form = player.form + ((player.skill - match_performance) * player.form_tendency)
    else
      new_form = player.form + ((player.skill - match_performance) * 5)
    end

    if new_form > 20
      new_form = 20
    end

  end
end