class Risk
  require 'byebug'
  Army = Struct.new(:size, :hand) do
    def size
      hand.size
    end

    def value(num)
      hand.dice[num].value
    end
  end

  attr_accessor :offense, :defense
  def initialize(oArmy = 4, dArmy = 3)
    @offense = Army.new(oArmy, Hand.new([oArmy - 1, 3].min))
    @defense = Army.new(dArmy, Hand.new([dArmy, 2].min))
  end

  def battle
    conflicts = [@offense.size, @defense.size].min
    conflicts.times do |i|
      puts "O - #{offense.value(i)} / D - #{defense.value(i)}"
      result = fight(offense.value(i), defense.value(i))
      if result > 0
        puts "Offense wins"
      else
        puts "Defense wins"
      end
    end
  end

  def fight(o, d)
    o > d ? 1 : -1
  end
end
