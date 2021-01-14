module LeagueCalculator
  def league_table_calculator(season) 

    league_table_info = []
      
      season.teams.each do |team|
      wins = Game.where(winner_team_id: team.id, season_id: season.id).length
      draws = Game.where(home_team_id: team.id, result: "X", season_id: season.id).or(Game.where(away_team_id: team.id, result: "X", season_id: season.id)).length
      losses = Game.where(home_team_id: team.id, season_id: season.id).where.not(winner_team_id: team.id).or(Game.where(away_team_id: team.id, season_id: season.id).where.not(winner_team_id: team.id)).length
      points = ( wins * 3 ) + ( draws )
      played = wins + draws + losses
      goals_for = 0
      goals_against = 0
      goal_difference = 0
      (Game.where(home_team_id: team.id, season_id: season.id).where.not(result: nil)).each do |game|
        goals_for += game.goals_ht
        goals_against += game.goals_at
      end
      (Game.where(away_team_id: team.id, season_id: season.id).where.not(result: nil)).each do |game|
        goals_for += game.goals_at
        goals_against += game.goals_ht
      end

      team_current_standing = [team.name, team.id, played, wins, draws, losses, goals_for, goals_against, (goals_for - goals_against), points]
      league_table_info << team_current_standing

    end
    league_table_info.sort_by{|x| [x[9], x[8]] }.reverse
  end
end