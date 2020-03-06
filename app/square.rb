class Square
  def initialize(world, x_axis, y_axis)
    @world = world
    @x_axis = x_axis
    @y_axis = y_axis
    @live = false
  end

  def dead?
    !@live
  end

  def dead!
    @live = false
  end

  def live?
    @live
  end

  def live!
    @live = true
  end

  def change_status
    @live = !@live
  end

  def around_square
    around_square = []
    around_square.push(@world.square_at(x - 1, y - 1))
    around_square.push(@world.square_at(x - 1, y))
    around_square.push(@world.square_at(x - 1, y + 1))
    around_square.push(@world.square_at(x + 1, y - 1))
    around_square.push(@world.square_at(x + 1, y))
    around_square.push(@world.square_at(x + 1, y + 1))
    around_square
  end

  def live_around_square
    around_square.select do |square|
      square && square&.live?
    end
  end
end
