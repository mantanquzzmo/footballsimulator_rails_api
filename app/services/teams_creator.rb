module TeamsCreator
  def team_name_generator(number)
    team_names = ["Arsenal", "Manchester Utd", "Aston Villa", "Newcastle Utd", "Burnley", "QPR", "Chelsea", "Southampton", "Crystal Palace", "Spurs"      "Everton", "Stoke", "Hull", "Sunderland", "Leicester", "Swansea", "Liverpool", "Manchester City", "West Ham", "Leeds United"]
    team = team_names[number]
  end

  def generate_teams
    teams = []

    (0..19).each do |i|
      team_name = team_name_generator(i)

      team = Team.create(name: name_generator, age: rand(16..34),
                             position: position, skill: rand(2.0..[3.1, [Math.sqrt(skill_pot(skill_total)), 6.0].min].max),
                             form: rand(1..20), form_tendency: rand(1..5),
                             team_id: team_id)

      value_to_deduct = Math.sqrt(((35.0 - player.age)**2.0) * player.skill)
      skill_total -= value_to_deduct

      players << player if player.persisted?
    end
    players
  end
end