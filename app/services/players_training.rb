
module PlayersTraining
  def player_training(player)

    age = player.age
    form = player.form
    form_tendency = player.form_tendency
    
    case player.age
    when 0..19
      form += rand(3...7)
    when 20..25
      form += rand(2...6)
    when 26..30
      form += rand(1...5)
    when 31..40
      form += rand(-2...3)
    end
    
    if form < 0
      form = 0
    elsif form > 20
      form = 20
    end

    case player.age
    when 0..19
      form_tendency += rand(2...5)
    when 20..25
      form_tendency += rand(1...5)
    when 26..30
      form_tendency += rand(1...4)
    when 31..40
      form_tendency += rand(1...3)
    end

    if form_tendency < 0
      form_tendency = 0
    elsif form_tendency > 5
      form_tendency = 5
    end

    new_form = [form, form_tendency]
  end
end