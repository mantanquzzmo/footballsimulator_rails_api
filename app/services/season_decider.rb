module SeasonDecider
  include LeagueCalculator
  def season_decider(season)

  league_table_info = league_table_calculator(season)

  winner = season.teams.where(name: league_table_info[0][0])[0]

  season.update(winner: winner.name, winner_id: winner.id, completed: true)
  end
end