class Robot
  attr_reader :items, :position, :health
  attr_accessor :equipped_weapon
  def initialize
    @equipped_weapon = nil
    @health = 100
    @position = [0,0]
    @items = []

  end  

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def self.feed
  end  
  
  def items_weight
    @items.inject(0) {|total_weight,item| total_weight += item.weight}
  end

  def pick_up(item)
    @items << item if items_weight + item.weight <= 250
    @equipped_weapon = item if item.is_a? Weapon
  end

  def wound(amount)
    @health > amount ? @health -= amount : @health = 0
  end

  def heal(amount)
    @health + amount  <= 100 ? @health += amount : @health = 100
  end   

  def heal!(amount)
    raise RobotAlreadyDeadError, "Can't heal dead Robot!" unless health > 0
    heal(amount)
  end

  def attack(robot)
    @equipped_weapon == nil ? robot.wound(5) : @equipped_weapon.hit(robot)
  end

  def attack!(entity)
    raise UnattackableEnemy, "Can't attack object besides Robot" if !(entity.is_a? Robot)

    attack(entity)
  end

end

class RobotAlreadyDeadError < StandardError

end

class UnattackableEnemy < StandardError

end
