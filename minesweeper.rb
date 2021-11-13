# frozen_string_literal: true

require_relative 'grid'

# Manage Game
class Minesweeper
  attr_accessor :grid, :won, :lose, :points

  def initialize(height, width, mines)
    @grid = Grid.new(height, width)
    grid.build_cells
    grid.place_mines(mines)
    grid.place_mine_count_to_cells
    @points = 0
  end

  def start
    input = ''
    while input.downcase != 'q'
      display
      input = read_input
      begin
        click_cell_at(input)
      rescue CellError => e
        puts e.message
      end
    end
  end

  def display
    print_header
    row = 0
    grid.cells.each_with_index do |cell, index|
      if (index % grid.width).zero?
        print "\n#{row}  "
        row += 1
      end
      print cell.display
    end
    puts "\n\nScore: #{score}"
  end

  def display_data
    grid.cells.each_with_index do |cell, index|
      puts "\n" if (index % grid.width).zero?
      print cell.display
    end
  end

  def click_cell_at(position)
    if position.to_s.downcase.include?('f')
      grid.flag_cell(*separate_x_y_positions(position))
    else
      grid.open_cell(*separate_x_y_positions(position))
    end
  end

  def print_help
    puts "\nGame Help"
    puts '----------'
    puts 'Use row column combination for select a cell'
    puts 'Open a cell: <rowcolumn>  Eg: 00'
    puts 'Flag a cell: <rowcolumn>f  Eg: 00f'
    puts 'Exit game: q'
  end

  def read_input
    if game_over?
      print game_over_message
      'q'
    else
      print_help
      print "\nEnter input: "
      $stdin.gets.chomp
    end
  end

  private

  def score
    opened_cells = grid.cells.count { |cell| !cell.mine? && cell.opened? }
    correct_flagged_cells = grid.cells.count { |cell| cell.mine? && cell.flagged? }
    opened_cells * 10 + correct_flagged_cells * 5
  end

  def game_over_message
    return "\nCongratulations You Won !!\n" if won?
    return "\nYou lose!, try again\n" if lose?
  end

  def game_over?
    won? || lose?
  end

  def won?
    grid.cells.all? { |cell| !cell.empty? && cell.opened? }
  end

  def lose?
    grid.cells.any?(&:exploded?)
  end

  def separate_x_y_positions(position)
    [position[0].to_i, position[1].to_i]
  end

  def print_header
    system('clear')
    header = '   '
    grid.width.times { |c| header += " #{c} " }
    print "#{header}\n"
  end

  def update_points
    @points += 10
  end
end
