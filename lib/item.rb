class Item
  attr_reader :name, :weight
  def initialize(name,weight)
    @name = name
    @weight = weight
  end
end  

class Weapon < Item
  attr_reader :damage
  def initialize(name,weight,damage)
    super(name,weight)
    @damage = damage
  end

  def hit(robo)
    robot.wound(@damage)
  end

end

class Grenade < Weapon
  def initialize
    
    
  end  
end

class Laser < Weapon

  def initialize
     super("Laser",125,25)  
  end
end

class PlasmaCannon < Weapon
  def initialize
     super("Plasma Cannon",200,55)  
  end
end

class BoxOfBolts < Item
  def initialize
    super("Box of bolts",25)
  end  
  
  def feed(robot)
    robot.heal(20)
  end  
end
