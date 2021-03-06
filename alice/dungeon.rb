class Dungeon

  def self.reset!
    Actor.reset_all
    Item.reset_cursed
    Beverage.sweep
    Item.sweep
    Item.reset_hidden!
    Wand.sweep
    Machine.sweep
    Place.delete_all
    Place.generate!(is_current: true)
    Item.create_defaults
    Item.deliver_fruitcake
    Actor::ensure_grue
    response = ""
    response << "Everything goes black and you feel like you are suddenly somewhere else!\n\r"
    response << "Please wait while we regenerate the matrix...\n\r"
    response << "#{Item.fruitcake.user.current_nick} has been given a special gift.\n\r"
    response << Place.current.describe
    response
  end

  def self.direction_from(string)
    case string
      when "east", "e"; return "east"
      when "west", "w"; return "west"
      when "south", "s"; return "south"
      when "north", "n"; return "north"
    end
  end

  def self.win!
    User.award_points_to_active(5)
    Actor.grue.penalize(5)
    Dungeon.reset!
  end

  def self.lose!
    User.award_points_to_active(-5)
    Actor.grue.score_points(5)
    Dungeon.reset!
  end

end