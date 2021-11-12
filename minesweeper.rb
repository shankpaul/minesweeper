# frozen_string_literal: true

require_relative 'grid'

# Manage Game
class Minesweeper
  attr_accessor :grid

  def initialize(height, width, mines)
    @grid = Grid.new(height, width)
    grid.build_cells
    grid.place_mines(mines)
    grid.mask_grid
  end

  def display
    grid.cells.each_with_index do |cell, index|
      puts "\n" if (index % grid.width).zero?
      print "#{cell.value}   "
    end
  end
end
