# frozen_string_literal: true

require_relative 'cell'

# Manage entire grid and cells
class Grid
  attr_accessor :cells, :height, :width

  def initialize(height, width)
    @height = height
    @width = width
    @cells = []
  end

  def build_cells
    (0..height - 1).each do |cell_x_position|
      (0..width - 1).each do |cell_y_position|
        cells << Cell.new(cell_x_position, cell_y_position)
      end
    end
  end

  def place_mines(mines)
    mines.times do
      cell = cells[rand(cells.count)]
      cell.value = '*'
    end
  end

  def mask_grid
    cells.each do |cell|
      next if cell.mine?

      update_near_mine_count(cell)
    end
  end

  private

  def find_cell(cell_x, cell_y)
    cells.select { |cell| cell.position_x == cell_x && cell.position_y == cell_y }.first
  end

  def update_near_mine_count(cell)
    cell.find_neighbor_positions.each do |position|
      neighbor = find_cell(position[:cell_x], position[:cell_y])
      next if neighbor.nil?

      cell.value = cell.value + 1 if neighbor.mine?
    end
  end
end
