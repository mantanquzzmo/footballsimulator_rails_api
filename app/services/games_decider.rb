# frozen_string_literal: true

module GamesDecider
  def games_decider(games)
    games.each do |game|
      hometeam = game.teams[0]
      awayteam = game.teams[1]

      ## calculate each players value
      game.players.where(starting_11: true).each do |player|
        match_performance = player_performance(player)
        new_form = form_calculator(player, match_performance)
        new_form_tendency = tendency_calculator(player, new_form)
        player_match_clone = player.dup
        player_match_clone.update(performance: player_performance(player), original_player_id: player.id)
        player.update(form: new_form, form_tendency: new_form_tendency)
        game.players.delete(player.id)
        game.players << player_match_clone
      end

      ht_gk = at_gk = ht_def = at_def = ht_mid = at_mid = ht_att = at_att = 0
      game.players.where(starting_11: true, position: 'G', team_id: hometeam.id).each { |player| ht_gk += player.performance }
      game.players.where(starting_11: true, position: 'G', team_id: awayteam.id).each { |player| at_gk += player.performance }
      game.players.where(starting_11: true, position: 'D', team_id: hometeam.id).each { |player| ht_def += player.performance }
      game.players.where(starting_11: true, position: 'D', team_id: awayteam.id).each { |player| at_def += player.performance }
      game.players.where(starting_11: true, position: 'M', team_id: hometeam.id).each { |player| ht_mid += player.performance }
      game.players.where(starting_11: true, position: 'M', team_id: awayteam.id).each { |player| at_mid += player.performance }
      game.players.where(starting_11: true, position: 'A', team_id: hometeam.id).each { |player| ht_att += player.performance }
      game.players.where(starting_11: true, position: 'A', team_id: awayteam.id).each { |player| at_att += player.performance }

      match_outcome(ht_gk, ht_def, ht_mid, ht_att, at_gk, at_def, at_mid, at_att)
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

    # attackers can score, goalkeepers can save

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
  end
end
