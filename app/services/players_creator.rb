# frozen_string_literal: true

module PlayersCreator
  def generate_players(team_id)
    players = []
    position = ''

    (0..19).each do |i|
      position = if i < 3
                    'G'
                  elsif i < 9
                    'D'
                  elsif i < 15
                    'M'
                  else
                    'A'
                  end

      player = Player.create(name: 'marcus', age: rand(16..34),
                              position: position, skill: rand(1.0..8.0),
                              form: rand(1..20), form_tendency: rand(1..5),
                              team_id: team_id)

      players << player if player.persisted?
    end
    players
  end
end