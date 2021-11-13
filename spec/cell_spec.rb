# spec/minesweeper.rb
require_relative '../cell'

RSpec.describe Cell do
	describe 'cell' do
		it 'initialize a cell' do
			cell = Cell.new(1, 2)
			expect(cell.position_x).to eq(1)
			expect(cell.position_y).to eq(2)
			expect(cell.opened).to be_falsey
			expect(cell.exploded).to be_falsey
			expect(cell.value).to eq(0)
		end
	end

	describe '#mine?' do
		it 'return true if it is a mine' do
			cell = Cell.new(1, 2)
			cell.value = '*'
			expect(cell.mine?).to be_truthy
		end
	end

	describe '#flagged?' do
		it 'return true if it is a flaged cell' do
			cell = Cell.new(1, 2)
			cell.flagged = true
			expect(cell.flagged?).to be_truthy
		end
	end

	describe '#display' do
		it '[ ] if cell is not opened' do
			cell = Cell.new(1, 2)
			expect(cell.display).to eq('[ ]')
		end

		it '[F] if cell is flagged' do
			cell = Cell.new(1, 2)
			cell.flagged = true
			expect(cell.display).to eq('[F]')
		end

		it '[*] if cell is exploded and opened' do
			cell = Cell.new(1, 2)
			cell.value = "*"
			cell.exploded = true
			cell.opened = true
			expect(cell.display).to eq('[*]')
		end

		it 'shoud not show anything if cell is empty' do
			cell = Cell.new(1, 2)
			cell.value = 0
			cell.opened = true
			expect(cell.display).to eq('   ')
		end
	end

	describe '#open' do
		it 'should open cell' do
			cell = Cell.new(1, 2)
			cell.open
			expect(cell.opened?).to be_truthy
		end
	end

	describe '#flag' do
		it 'should add flag cell' do
			cell = Cell.new(1, 2)
			cell.flag
			expect(cell.flagged?).to be_truthy
		end
	end
end