# frozen_string_literal: true

module PlayersCreator
  def generate_players(team_id)
    players = []
    position = ''
    skill_total = 340

    ## 20 spelare totalt

    (0..19).each do |i|
      skill_total += 35 if i === 16
      position = if i < 3
                   'G'
                 elsif i < 9
                   'D'
                 elsif i < 16
                   'M'
                 else
                   'A'
                  end

      player = Player.create(name: name_generator, age: rand(16..34),
                             position: position, skill: rand(2.0..[3.1, [Math.sqrt(skill_pot(skill_total)), 6.0].min].max),
                             form: rand(1..20), form_tendency: rand(1..5),
                             team_id: team_id)

      value_to_deduct = Math.sqrt(((35.0 - player.age)**2.0) * player.skill)
      skill_total -= value_to_deduct

      players << player if player.persisted?
    end
    players
  end

  def name_generator
    first_names = %w[Eusebio Reinier Exequiel Leonel Sergio James Donovan Stephen ]
    surnames = %w[Marquinhos Palacios Silva Johnson Thompson Smith McGrady]

    full_name = "#{first_names[rand(0..7)]} #{surnames[rand(0..6)]}"
  end

  def skill_pot(skill_total)
    [skill_total, 0].max
  end
end
