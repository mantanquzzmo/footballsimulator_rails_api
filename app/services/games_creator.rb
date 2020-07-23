require 'round_robin_tournament'

module GamesCreator

  def generate_games(season)
    schedule = RoundRobinTournament.schedule(season.teams.map(&:id))
    @round_no = 0
    schedule.each do |round| 

      (0..5).each do |i|
        if schedule[i] === round
          @round_no = i + 1
        end
      end
      round.each do |game|
        hometeam = Team.find(game[0])
        awayteam = Team.find(game[1])
        game = Game.create(season_id: season.id, round: @round_no)
        game.teams << hometeam
        game.teams << awayteam
      end
    end
    RoundRobinTournament.schedule(season.teams.map(&:name))
  end
end

