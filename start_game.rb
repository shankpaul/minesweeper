# frozen_string_literal: true

require 'json'

require_relative 'minesweeper'
require 'byebug'
game = Minesweeper.new(5, 5, 5)
game.start
