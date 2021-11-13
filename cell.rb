# frozen_string_literal: true

# Manage cell infomrations and actions
class Cell
  attr_accessor :position_x, :position_y, :value, :flagged, :opened, :exploded

  def initialize(position_x, position_y)
    @position_x = position_x
    @position_y = position_y
    @value = 0
    @flagged = false
    @opened = false
    @exploded = false
  end

  def mine?
    value == '*'
  end

  def empty?
    !mine? && value.zero?
  end

  def flagged?
    @flagged
  end

  def opened?
    @opened
  end

  def exploded?
    @exploded
  end

  def display
    return '[ ]' if !opened? && !flagged?
    return '[F]' if flagged?
    return empty? ? '   ' : "[#{value}]" if opened?
  end

  def find_neighbour_positions
    positions = []
    neighbour_x_positions.each do |neighbour_x|
      neighbour_y_positions.each do |neighbour_y|
        positions << { cell_x: neighbour_x, cell_y: neighbour_y }
      end
    end
    positions
  end

  def open
    return false if flagged? || opened?

    @exploded = true if mine?
    @opened = true
  end

  def flag
    @flagged = true
  end

  private

  def neighbour_x_positions
    (position_x - 1)..(position_x + 1)
  end

  def neighbour_y_positions
    (position_y - 1)..(position_y + 1)
  end
end
