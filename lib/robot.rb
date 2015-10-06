require_relative 'robot_exceptions'

class Robot

  attr_reader :position, :items, :items_weight, :capacity, :health
  attr_accessor :equipped_weapon

  STARTING_ITEMS = []
  EMPTY_WEIGHT = 0
  MAXIMUM_WEIGHT = 250
  STARTING_HEALTH = 100
  DEFAULT_ATTACK_STRENGTH = 5
  DEFAULT_WEAPON = nil

  def initialize
    @position = [0, 0]
    @items = STARTING_ITEMS
    @items_weight = EMPTY_WEIGHT
    @capacity = MAXIMUM_WEIGHT
    @health = STARTING_HEALTH
    @equipped_weapon = DEFAULT_WEAPON
  end

  def move_left
    @position[0] -= 1
    @position
  end

  def move_right
    @position[0] += 1
    @position
  end

  def move_up
    @position[1] += 1
    @position
  end

  def move_down
    @position[1] -= 1
    @position
  end

  def pick_up(item)
    unless @items_weight + item.weight > @capacity
      @items << item
      @items_weight += item.weight
      if item.is_a?(Weapon)
        @equipped_weapon = item
      end
    end
  end

  def wound(damage)
    if @health - damage >= 0
      @health -= damage
    else
      @health = 0
    end
  end

  def heal(repair)
    if @health + repair <= 100
      @health += repair
   else
      @health = STARTING_HEALTH
    end
  end

  def within_attack_range?(enemy)
    x, y = self.position
    range_array = [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]]
    range_array.include?(enemy.position)
  end

  def attack(enemy)
    if within_attack_range?(enemy)
      if equipped_weapon == nil
        enemy.wound(DEFAULT_ATTACK_STRENGTH)
      else
        equipped_weapon.hit(enemy)
      end
    end
  end

  def heal!(repair)
    raise HealError, "Robot can not be healed - it is dead." unless @health > 0
      if @health + repair <= 100
        @health += repair
     else
        @health = STARTING_HEALTH
      end
  end

  def attack!(enemy)
    if enemy.is_a?(Robot)
      if equipped_weapon == nil
      enemy.wound(DEFAULT_ATTACK_STRENGTH)
    else
      equipped_weapon.hit(enemy)
    end
    else
      raise AttackError, "Your enemy is not a robot - you can only attack a robot."
    end
  end

end