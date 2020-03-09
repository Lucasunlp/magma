# source https://github.com/gosu/gosu/wiki/ruby-tutorial
require 'gosu'
require_relative 'world.rb'
require_relative 'square.rb'
require_relative 'game.rb'

class GameOfLifeWindow < Gosu::Window
  def initialize
    super 640, 480
    # Basics
    @height = 640
    @width = 480
    # super height, width, false
    self.caption = "My first Game of Life"

    # Colors
    @background = Gosu::Color.new(0xffdedede)
    @live = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)

    # Game world
    @rows = height/10
    @cols = width/10
    @world = World.new(@cols, @rows) # Note: col is 1st
    @game = Game.new(@world)
    @row_height = height / @rows
    @col_width = width / @cols
    @game.world.randomly_populate

    @generation = 0
  end

  def update
    @game.tick!
    @generation += 1
    puts "Generation No: #{@generation}"
  end

  def draw
    draw_background
    @game.world.squares.each do |cell|
      if cell.live?
        draw_quad(cell.x * @col_width, cell.y * @row_height, @live,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @live,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @live,
                  cell.x * @col_width, cell.y * @row_height + (@row_height - 1), @live)
      else
        draw_quad(cell.x * @col_width, cell.y * @row_height, @dead,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @dead,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @dead,
                  cell.x * @col_width, cell.y * @row_height + (@row_height - 1), @dead)
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::KbSpace
      @game.world.randomly_populate
    when Gosu::KbEscape
      close
    end
  end

  def needs_cursor?
    true
  end

  def draw_background
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
  end

end

GameOfLifeWindow.new.show
