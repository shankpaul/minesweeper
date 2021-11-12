# frozen_string_literal: true
require 'json'

require_relative 'minesweeper'
require 'byebug'
m = Minesweeper.new(5, 5, 5)
m.display
puts ''
# puts m.convert_to_json
# puts "inspect"

# m.grid.cells.each do |cell|
# 	puts "#{cell.x}, #{cell.y} - #{cell.value}"
# end
