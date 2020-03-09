require_relative 'square.rb'
require_relative 'world.rb'
require_relative 'game.rb'

describe 'Game of Life' do
  let!(:world) { World.new(5, 5) }
  let!(:square) { Square.new( 10, 10) }

  context 'Square' do
    subject { Square.new( 10, 10) }

    it 'Initializes new cell object properly' do
      expect(subject.live!).to eq(true)
    end

    it 'lives neighbours in my square has to be zero' do
      skip
      expect(subject.live_around_square.count).to eq 0
    end
  end

  context 'World' do
    subject { World.new(5, 5) }

    it 'My world has squares' do
      expect(world.squares.count).to be == 0
    end

    it "I've an array class" do
      expect(subject.squares.is_a?(Array)).to eq(true)
    end

    it 'Amount of live and dead squares' do
      subject.randomly_populate
      (subject.live_squares.count + subject.dead_squares.count).should == subject.squares.count
    end
  end

  context 'Rules' do
    let!(:game) { Game.new(world, [[1, 1]]) }

    context 'Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
      it 'Kills live cell with no neighbours' do
        expect(game.world.square_board[1][1]).to be_live
        game.play!
        skip
        expect(game.world.square_board[1][1]).to be_dead
      end
   end
 end
end
