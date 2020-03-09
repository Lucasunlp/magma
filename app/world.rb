class World
  attr_accessor :rows, :cols, :square_board, :squares
  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @squares = []

    @square_board = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Square.new(col, row) # Note: col is 1st
      end
    end

    square_board.each do |row|
      row.each do |element|
        if element.is_a?(Square)
          squares << element
        end
      end
    end

  end

  def squares
    # Returns a new array that is a one-dimensional flattening
    @squares.flatten
  end

  def live_squares
    squares.select(&:live?)
  end

  def dead_squares
    squares.select(&:dead?)
  end

  def randomly_populate
    squares.each do |_square|
      square = [true, false].sample
    end
  end

  def live_around_square(square)
    live_neighbours = []
    # Neighbour to the North-East
    if (square.y_axis > 0) && (square.x_axis < (cols - 1))
      candidate = @squares[square.y_axis - 1][square.x_axis + 1]
      live_neighbours << candidate if candidate.live?
    end
    # Neighbour to the South-East
    if (square.y_axis < (rows - 1)) && (square.x_axis < (cols - 1))
      candidate = @squares[square.y_axis + 1][square.x + 1]
      live_neighbours << candidate if candidate.live?
    end
    # Neighbours to the South-West
    if (square.y_axis < (rows - 1)) && (square.x_axis > 0)
      candidate = @squares[square.y_axis + 1][square.x_axis - 1]
      live_neighbours << candidate if candidate.live?
    end
    # Neighbours to the North-West
    if (square.y_axis > 0) && (square.x_axis > 0)
      candidate = @squares[square.y_axis - 1][square.x_axis - 1]
      live_neighbours << candidate if candidate.live?
    end
    # Neighbour to the North
    if square.y_axis > 0
      candidate = @squares[square.y_axis - 1][square.x_axis]
      live_neighbours << candidate if candidate.live?
    end
    # Neighbour to the East
    if square.x_axis < (cols - 1)
      candidate = @squares[square.y_axis][square.x_axis + 1]
      live_neighbours << candidate if candidate.live
    end
    # Neighbour to the South
    if square.y_axis < (rows - 1)
      candidate = @squares[cell.y_axis + 1][cell.x_axis]
      live_neighbours << candidate if candidate.live
    end
    # Neighbours to the West
    if cell.x_axis > 0
      candidate = @squares[cell.y_axis][cell.x_axis - 1]
      live_neighbours << candidate if candidate.live
    end
    live_neighbours
 end
end
