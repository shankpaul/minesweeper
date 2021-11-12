# frozen_string_literal: true

# Holds cell infomrations and actions
class Cell
  attr_accessor :position_x, :position_y, :value

  def initialize(position_x, position_y)
    @position_x = position_x
    @position_y = position_y
    @value = 0
  end

  def mine?
    value == '*'
  end

  def find_neighbor_positions
    positions = []
    neighbor_x_positions.each do |neighbor_x|
      neighbor_y_positions.each do |neighbor_y|
        positions << { cell_x: neighbor_x, cell_y: neighbor_y }
      end
    end
    positions
  end

  private

  def neighbor_x_positions
    (position_x - 1)..(position_x + 1)
  end

  def neighbor_y_positions
    (position_y - 1)..(position_y + 1)
  end
end
