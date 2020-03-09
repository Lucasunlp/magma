class Square
  attr_accessor :x, :y, :live

   def initialize(x=0, y=0)
     @x_axis = x
     @y_axis = y
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
    around_square.push(@world.square_board(@x_axis - 1, @y_axis - 1))
    around_square.push(@world.square_board(@x_axis - 1, @y_axis))
    around_square.push(@world.square_board(@x_axis - 1, @y_axis + 1))
    around_square.push(@world.square_board(@x_axis + 1, @y_axis - 1))
    around_square.push(@world.square_board(@x_axis + 1, @y_axis))
    around_square.push(@world.square_board(@x_axis + 1, @y_axis + 1))
    around_square
  end

  def live_around_square
    around_square.select do |square|
      square && square&.live?
    end
  end
end
