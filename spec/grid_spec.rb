# spec/minesweeper.rb
require_relative '../grid'

RSpec.describe Grid do
	describe 'grid' do
		it 'initialize a grid' do
			grid = Grid.new(2, 3)
			expect(grid.height).to eq(2)
			expect(grid.width).to eq(3)
		end
	end

	describe '#build_cells' do
		it 'build cells in grid' do
			grid = Grid.new(2, 3)
			expect(grid.cells.count).to eq(0)
			grid.build_cells
			expect(grid.cells.count).to eq(6)
		end
	end

	describe '#place_mines' do
		it 'place give number of mines to grid cells' do
			grid = Grid.new(2, 3)
			grid.build_cells
			expect(grid.cells.count(&:mine?)).to eq(0)
			grid.place_mines(5)
			expect(grid.cells.count(&:mine?)).to eq(5)
		end
	end

	describe '#place_mine_count_to_cells' do
		it 'place nearest mine count to cells' do
			grid = Grid.new(2, 3)
			grid.build_cells
			grid.place_mines(4)
			expect(grid.cells.count{|c| !c.mine? && c.value!=0 }).to eq(0)
			grid.place_mine_count_to_cells
			expect(grid.cells.count{|c| !c.mine? && c.value!=0 }).to be > 0
		end
	end
end