class Risk
  require 'byebug'
  Army = Struct.new(:size, :hand) do
    def size
      hand.size
    end

    def value(num)
      hand.dice[num].value
    end

    def setDice(diceValues)
      hand.preset(diceValues)
    end
  end

  attr_accessor :offense, :defense
  def initialize(oArmy = 4, dArmy = 3)
    @offense = Army.new(oArmy, Hand.new([oArmy - 1, 3].min))
    @defense = Army.new(dArmy, Hand.new([dArmy, 2].min))
  end

  def battle
    conflicts = [@offense.size, @defense.size].min
    score = [0, 0]
    conflicts.times do |i|
      result = fight(offense.value(i), defense.value(i))
      if result > 0
        score[0] += 1
      else
        score[1] += 1
      end
    end
    score
  end

  def fight(o, d)
    o > d ? 1 : -1
  end

  def fullRumble
    count = 0
    offenseWinsBoth = 0
    defenseWinsBoth = 0
    bothLoseOne = 0
    6.times do |o1|
      6.times do |o2|
        6.times do |o3|
          6.times do |d1|
            6.times do |d2|
              @offense.setDice([o1, o2, o3])
              @defense.setDice([d1, d2])
              result =  battle
              count += 1
              case result
              when [2, 0]
                offenseWinsBoth += 1
              when [1, 1]
                bothLoseOne += 1
              when [0, 2]
                defenseWinsBoth += 1
              end
            end
          end
        end
      end
    end
    puts "Results!!!"
    puts "Total - #{count}"
    puts "offenseWinsBoth - #{offenseWinsBoth} - #{percent(offenseWinsBoth, count)}%"
    puts "defenseWinsBoth - #{defenseWinsBoth} - #{percent(defenseWinsBoth, count)}%"
    puts "bothLoseOne - #{bothLoseOne} - #{percent(bothLoseOne, count)}%"
  end


    def pansyRumble
      count = 0
      offenseWinsOne = 0
      defenseWinsOne = 0
      @defense.hand = Hand.new(1)
      6.times do |o1|
        6.times do |o2|
          6.times do |o3|
            6.times do |d1|
              @offense.setDice([o1, o2, o3])
              @defense.setDice([d1])
              result =  battle
              count += 1
              case result
              when [1, 0]
                offenseWinsOne += 1
              when [0, 1]
                defenseWinsOne += 1
              end
            end
          end
        end
      end
      puts "Results!!!"
      puts "Total - #{count}"
      puts "offenseWinsOne - #{offenseWinsOne} - #{percent(offenseWinsOne, count)}%"
      puts "defenseWinsOne - #{defenseWinsOne} - #{percent(defenseWinsOne, count)}%"
    end

  def percent(numerator, denominator)
    (numerator.to_f/denominator.to_f*100).round(2)
  end

end
