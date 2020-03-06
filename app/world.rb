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
    @squares[x_axis][y_axis] if @squares[x_axis]
  end
end
