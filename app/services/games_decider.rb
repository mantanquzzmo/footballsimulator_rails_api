# frozen_string_literal: true

module GamesDecider
  def games_decider(games)
    games.each do |game|
      hometeam = Team.where(name: game.home_team)[0]
      awayteam = Team.where(name: game.away_team)[0]

      ## calculate each starting players values
      game.players.where(starting_11: true).each do |player|
        match_performance = player_performance(player)
        new_form = form_calculator(player, match_performance)
        new_form_tendency = tendency_calculator(player, new_form)
        performance = player_performance(player)
        player_match_copy = PlayerGameCopy.create(player_id: player.id, name: player.name, 
                                                      age: player.age, position: player.position, skill: player.skill, 
                                                      form: player.form, form_tendency: player.form_tendency, 
                                                      starting_11: player.starting_11, team_id: player.team_id, 
                                                      performance: performance, game_id: game.id)

        player.update(form: new_form, form_tendency: new_form_tendency)
      end

      ht_gk = at_gk = ht_def = at_def = ht_mid = at_mid = ht_att = at_att = 0

      PlayerGameCopy.where(starting_11: true, position: 'G', team_id: hometeam.id, game_id: game.id).each { |player| ht_gk += player.performance }
      PlayerGameCopy.where(starting_11: true, position: 'G', team_id: awayteam.id, game_id: game.id).each { |player| at_gk += player.performance }
      PlayerGameCopy.where(starting_11: true, position: 'D', team_id: hometeam.id, game_id: game.id).each { |player| ht_def += player.performance }
      PlayerGameCopy.where(starting_11: true, position: 'D', team_id: awayteam.id, game_id: game.id).each { |player| at_def += player.performance }
      PlayerGameCopy.where(starting_11: true, position: 'M', team_id: hometeam.id, game_id: game.id).each { |player| ht_mid += player.performance }
      PlayerGameCopy.where(starting_11: true, position: 'M', team_id: awayteam.id, game_id: game.id).each { |player| at_mid += player.performance }
      PlayerGameCopy.where(starting_11: true, position: 'A', team_id: hometeam.id, game_id: game.id).each { |player| ht_att += player.performance }
      PlayerGameCopy.where(starting_11: true, position: 'A', team_id: awayteam.id, game_id: game.id).each { |player| at_att += player.performance }

      game_outcome = match_outcome(ht_gk, ht_def, ht_mid, ht_att, at_gk, at_def, at_mid, at_att)
      result = ''
      winning_team_id = nil
      
      if game_outcome[0] > game_outcome[1]
        result = '1'
        winning_team_id = hometeam.id
      elsif game_outcome[0] < game_outcome[1]
        result = '2'
        winning_team_id = awayteam.id
      else 
        result = 'X'
      end

      game.update(goals_ht: game_outcome[0], goals_at: game_outcome[1], winner_team_id: winning_team_id, result: result)

    end
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
      player_performance *= 0.9
    when 2
      player_performance *= 0.95
    when 3
      player_performance = player_performance
    when 4
      player_performance *= 1.05
    when 5
      player_performance *= 1.1
    end
  end

  def form_calculator(player, match_performance)
    new_form = nil
    random = rand * player.form_tendency

    case random
    when 0.0..0.25
      new_form = player.form - ((player.skill - match_performance) * player.form_tendency)
    when 0.26..0.75
      new_form = player.form + ((player.skill - match_performance) * player.form_tendency)
    else
      new_form = player.form + ((player.skill - match_performance) * 5)
    end

    new_form = 20 if new_form > 20

    new_form
  end

  def tendency_calculator(player, new_form)
    new_form_tendency = nil

    new_form_tendency = if new_form > player.form
                          player.form_tendency + 1
                        else
                          player.form_tendency + -1
                        end

    new_form_tendency = 5 if new_form_tendency > 5
    new_form_tendency = 1 if new_form_tendency < 1

    new_form_tendency
  end

  def match_outcome(ht_gk, ht_def, ht_mid, ht_att, at_gk, at_def, at_mid, at_att)
    hometeam = [ht_gk, ht_def, ht_mid, ht_att]
    awayteam = [at_gk, at_def, at_mid, at_att]

    ## hometeam advantage = 0.15

    ## midfield distributes possibilities to chances

    ht_share_of_chances = (hometeam[2] + 0.15) / (hometeam[2] + awayteam[2])

    ht_chances = 0
    at_chances = 0

    13.times do
      if rand < ht_share_of_chances
        ht_chances += 1
      else
        at_chances += 1
      end
    end

    ## defenders can clear chances

    ht_chance_of_clearance = (hometeam[1] + 0.15) / (hometeam[1] + awayteam[1])
    at_chance_of_clearance = 1 - ht_chance_of_clearance

    ht_goalscoring_chances = 0
    at_goalscoring_chances = 0

    ht_chances.times do
      ht_goalscoring_chances += 1 if rand > ht_chance_of_clearance
    end

    at_chances.times do
      at_goalscoring_chances += 1 if rand > at_chance_of_clearance
    end

    ht_chance_of_scoring = (hometeam[3] + 0.15) / (hometeam[3] + awayteam[0])
    at_chance_of_scoring = awayteam[3] / (hometeam[0] + awayteam[3])

    hometeam_goals = 0
    awayteam_goals = 0

    ht_chances.times do
      hometeam_goals += 1 if rand < ht_chance_of_scoring
    end

    at_chances.times do
      awayteam_goals += 1 if rand < at_chance_of_scoring
    end

    [hometeam_goals, awayteam_goals]
  end
end
