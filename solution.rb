# frozen_string_literal: true

require_relative 'minesweeper'
require 'byebug'
m = Minesweeper.new(5, 5, 5)
m.display
# puts "inspect"

# m.grid.cells.each do |cell|
# 	puts "#{cell.x}, #{cell.y} - #{cell.value}"
# end
