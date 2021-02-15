# frozen_string_literal: true

# A set of Dice used by one person
class Hand
  attr_accessor :dice

  def initialize(number)
    @dice = []
    number.times do
      @dice << Dice.new
    end
    sort_desc
  end

  def reroll
    @dice.size.times do |i|
      @dice[i].roll
    end
    sort_desc
  end

  def preset(values)
    raise 'The values sent must match the number of dice' unless values.size == @dice.size

    @dice.size.times { |i| @dice[i].roll(values[i]) }
    sort_desc
  end

  def sort_desc
    @dice.sort! { |d1, d2| d2.value <=> d1.value }
  end

  def size
    @dice.size
  end
end
