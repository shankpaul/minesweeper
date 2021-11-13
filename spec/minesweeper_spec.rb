# spec/minesweeper.rb
require_relative '../minesweeper'

RSpec.describe Minesweeper do
  describe "game grid" do
    it 'should create grid with proper number of cells' do
      game = Minesweeper.new(5, 5, 5)
      expect(game.grid.cells.count).to eq(25)
    end

    it 'should set height and width for the grid' do
      game = Minesweeper.new(3, 2, 4)
      expect(game.grid.height).to eq(3)
      expect(game.grid.width).to eq(2)
    end

    it 'number of mines should be less or equal to given mince count' do
      game = Minesweeper.new(3, 3, 4)
      mine_count = game.grid.cells.count(&:mine?)
      expect(mine_count).to eq 4
    end
  end

  describe "input" do
    it 'raise cell error when try to open invalid cell' do
      game = Minesweeper.new(2, 2, 3)
      expect{ game.click_cell_at('55') }.to raise_error(CellError)
    end

    it 'it read user input and open cell' do
      allow($stdin).to receive(:gets).and_return('00')
      input = $stdin.gets
      game = Minesweeper.new(2, 2, 3)
      game.click_cell_at(input)
      cell = game.grid.cells.select { |c| c.opened? }.first
      expect(cell.position_x).to eq(0)
      expect(cell.position_y).to eq(0)
    end

    it 'it read user input and flag cell' do
      allow($stdin).to receive(:gets).and_return('00f')
      input = $stdin.gets
      game = Minesweeper.new(2, 2, 3)
      game.click_cell_at(input)
      cell = game.grid.cells.select { |c| c.flagged? }.first
      expect(cell.position_x).to eq(0)
      expect(cell.position_y).to eq(0)
      expect(cell.flagged?).to be_truthy
    end
  end

  describe '#game_over' do
    it 'return true when all cells opened' do
      game = Minesweeper.new(3, 3, 4)
      game.grid.cells.map(&:open)
      expect(game.send(:game_over?)).to be_truthy
    end

    it 'return false when all cells opened' do
      game = Minesweeper.new(3, 3, 4)
      expect(game.send(:game_over?)).to be_falsey
    end
  end

   describe '#won' do
    it 'return true when all cells non mine cells opened' do
      game = Minesweeper.new(3, 3, 4)
      game.grid.cells.select{|c| c.value!='*' }.map(&:open)
      expect(game.send(:won?)).to be_truthy
    end

    it 'return false when mines exploded' do
      game = Minesweeper.new(3, 3, 4)
      game.grid.cells.select(&:mine?).map(&:open)
      expect(game.send(:won?)).to be_falsey
    end
  end

  describe '#lose' do
    it 'return rue when mines exploded' do
      game = Minesweeper.new(3, 3, 4)
      game.grid.cells.select(&:mine?).map(&:open)
      expect(game.send(:lose?)).to be_truthy
    end
  end

  describe '#score' do
    it 'calculate correct score' do
      game = Minesweeper.new(3, 3, 4)
      game.grid.cells.select{|c| c.value!='*' }.map(&:open)
      opened_cells_count = game.grid.cells.count(&:opened?)
      expect(game.send(:score)).to eq(opened_cells_count*10)
    end
  end


end