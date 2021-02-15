# frozen_string_literal: true

# A single dice object
class Dice
  attr_reader :sides
  attr_accessor :value

  def initialize(sides = 6)
    @sides = sides
    roll
  end

  def roll
    @value = rand(1..@sides)
  end
end
