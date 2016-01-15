class Robot
  attr_reader :items, :health
  attr_accessor  :position, :equipped_weapon
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
  
  def items_weight
    @items.inject(0) {|total_weight,item| total_weight += item.weight}
  end

  def pick_up(item)
    capacity =  (items_weight + item.weight <= 250)
    if capacity
      @items << item
      @equipped_weapon = item if item.is_a? Weapon
      
      if item.is_a?(BoxOfBolts) && health <=80
        item.feed(self)
        remove_item(BoxOfBolts.new)  
      end 
    end
    capacity
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

  def remove_item(item)
    found = nil
    @items.each_with_index {|index,obj| found = index if obj.class==item.class}
    @items.delete_at(found) if found != nil

  end  

  def attack(robot)
    if attack_range?(robot) 
      @equipped_weapon == nil ? robot.wound(5) : @equipped_weapon.hit(robot)
      if @equipped_weapon.class == Grenade
        remove_item(Grenade.new)
        @equipped_weapon = nil
      end
    end
  end

  def attack!(entity)
    raise UnattackableEnemy, "Can't attack object besides Robot" if !(entity.is_a? Robot)

    attack(entity)
  end

  def attack_range?(robot)
    equipped_weapon != nil ? within_range = equipped_weapon.range : within_range = 1
    
    x_diff = (robot.position[0] - @position[0]).abs
    y_diff = (robot.position[1] - @position[1]).abs
    (x_diff + y_diff) <= within_range
  end

end

class RobotAlreadyDeadError < StandardError

end

class UnattackableEnemy < StandardError

end
