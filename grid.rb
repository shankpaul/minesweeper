# frozen_string_literal: true

require_relative 'cell'
require_relative 'cell_error'

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

  def place_mines(mine_count)
    indexes = [*0..cells.count-1].shuffle
    indexes.sample(mine_count).each do |index|
      cell = cells[index]
      cell.value = '*'
    end
  end

  def place_mine_count_to_cells
    cells.each do |cell|
      next if cell.mine?

      update_near_mine_count(cell)
    end
  end

  def open_cell(position_x, position_y)
    cell = find_cell(position_x, position_y)
    raise CellError, 'Invalid Cell' if cell.nil?

    return unless cell.open

    open_other_mines(cell) if cell.mine?
    open_other_empty_neighbours(cell) if cell.empty?
  end

  def flag_cell(position_x, position_y)
    cell = find_cell(position_x, position_y)
    raise CellError, 'Invalid Cell' if cell.nil?

    cell.flag
  end

  def non_mine_cells
    cells.select {|cell| !cell.mine? }
  end

  private

  def open_other_empty_neighbours(cell)
    neighbour_cells(cell).each do |neighbour|
      neighbour.open if neighbour.empty?
    end
  end

  def open_other_mines(cell)
    cells.select(&:mine?).map(&:open)
  end

  def find_cell(cell_x, cell_y)
    cells.select { |cell| cell.position_x == cell_x && cell.position_y == cell_y }.first
  end

  def update_near_mine_count(cell)
    neighbour_cells(cell).each do |neighbour|
      cell.value = cell.value + 1 if neighbour.mine?
    end
  end

  def neighbour_cells(cell)
    neighbours = []
    cell.find_neighbour_positions.each do |position|
      neighbour = find_cell(position[:cell_x], position[:cell_y])
      next if neighbour.nil?

      neighbours << neighbour
    end
    neighbours
  end
end
