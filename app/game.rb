class Game
  attr_accessor :world

  def initialize(world=World.new, seeds=[])
   @world = world
   seeds.each do |seed|
     world.square_board[seed[0]][seed[1]].live = true
   end
 end

  def play!
    next_round_live_squares = []
    next_round_dead_squares = []

    @world.squares.each do |square|
      neighbour_count = world.live_around_square(square).count
      # Rule 1:
      # Any live square with fewer than two live neighbours dies
      if square.live? && neighbour_count < 2
        next_round_dead_squares << square
      end
      # Rule 2:
      # Any live square with two or three live neighbours lives on to the next generation
      if square.live? && ([2, 3].include? neighbour_count)
        next_round_live_squares << square
      end
      # Rule 3:
      # Any live square with more than three live neighbours dies
      if square.live? && neighbour_count > 3
        next_round_dead_squares << square
      end
      # Rule 4:
      # Any dead square with exactly three live neighbours becomes a live square
      if square.dead? && neighbour_count == 3
        next_round_live_squares << square
      end
    end

    next_round_live_squares.each do |square|
      square.live!
    end
    next_round_dead_squares.each do |square|
      square.dead!
    end
  end


end
