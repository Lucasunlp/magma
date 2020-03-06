require './app/square'
class World
  def initialize(width, height)
    @squares = []
    # Creating matrix with my params
    height.times do |x_axis|
      @squares.push([])
      width.times do |y_axis|
        @squares[x_axis].push(Square.new(self, x_axis, y_axis))
      end
    end
  end

  def squares
    # Returns a new array that is a one-dimensional flattening
    @squares.flatten
  end

  def square_at(x_axis, y_axis)
    # If exist a square apply the params
    @squares[x_axis][y_axis] if @squares[x_axis]
  end

  def play
    next_round_live_squares = []
    next_round_dead_squares = []

    @world.squares.each do |square|
      neighbour_count = world.live_around_square(square).count
      # Rule 1:
      # Any living cell with fewer than two live neighbours dies, as if caused by underpopulation.
      next_round_dead_squares << square if square.live? && neighbour_count < 2
      # Rule 2:
      # Any living cell with two or three live neighbours lives on to the next generation.
      next_round_dead_squares << square if square.live? && neighbour_count > 3
      # Rule 3:
      # Any living cell with more than three live neighbours dies, as if by overcrowding
      if square.live? && ([2, 3].include? neighbour_count)
        next_round_live_squares << square
      end
      # Rule 4:
      # Any dead cell with exactly three live neighbours becomes a live cell.
      next_round_live_squares << square if square.dead? && neighbour_count == 3
    end
  end
end
