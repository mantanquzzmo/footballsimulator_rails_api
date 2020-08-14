# frozen_string_literal: true

module SeasonReviewServices
  def league_table_compiler(season)
    league_table_info = []

    season.teams.each do |team|
      wins = Game.where(winner_team_id: team.id, season_id: params[:id]).length
      draws = Game.where(result: 'X', season_id: params[:id], home_team_id: team.id).length + Game.where(result: 'X', season_id: params[:id], away_team_id: team.id).length
      losses = season.round - (wins + draws)
      points = (wins * 3) + (draws * 1)
      played = wins + draws + losses
      goals_for = 0
      goals_against = 0
      goal_difference = 0
      Game.where(home_team_id: team.id).where.not(result: nil).each do |game|
        goals_for += game.goals_ht
      end
      Game.where(away_team_id: team.id).where.not(result: nil).each do |game|
        goals_for += game.goals_at
      end
      Game.where(home_team_id: team.id).where.not(result: nil).each do |game|
        goals_against += game.goals_at
      end
      Game.where(away_team_id: team.id).where.not(result: nil).each do |game|
        goals_against += game.goals_ht
      end

      team_current_standing = [team.name, team.id, played, wins, draws, losses, goals_for, goals_against, (goals_for - goals_against), points]
      league_table_info << team_current_standing
    end

    league_table_sorted = league_table_info.sort_by { |x| x[9] }.reverse
  end

  def player_performance_update(team)
    performances = []
 
    team.players.each do |player|

      PlayerGameCopy.where(original_player_id: player.id).each do |game|
        performances << game.performance
      end
      average_perf = performances.inject{ |sum, el| sum + el }.to_f / performances.size
      season_performance = player.skill - average_perf
      
      player.update(skill: player.skill + season_performance)
      ## add retirement
    end
 
    ## get gameplayercopys. get average. update player.}
  end
end
