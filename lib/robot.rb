class Robot

  attr_reader :position, :items, :health
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
  end

  def wound(ammount)
    @health -= ammount
    @health = 0 if @health < 0
  end

  def heal!(ammount)
    raise DeadRobotError,"Cannot heal dead robot" if health <= 0
    heal(ammount)
  end

  def heal(ammount)
    @health += ammount
    @health = 100 if @health > 100
  end

  def range()
    unless equipped_weapon.nil?
      equipped_weapon.range
    else
      1
    end
  end

  def can_attack?(robot)
    (position[0] - robot.position[0]).abs <= range && (position[1] - robot.position[1]).abs <= range
  end

  def attack!(robot)
    raise NotARobot, "Target must be robot" unless robot.is_a? Robot
    attack(robot)
  end

  def attack(robot)
    return false unless can_attack?(robot)
    unless equipped_weapon.nil?
      equipped_weapon.hit(robot)
      if equipped_weapon.one_use
        @items.delete(equipped_weapon)
        @equipped_weapon = nil
      end
    else
      robot.wound(5)
    end
  end

  def pick_up(item)
    if can_pick_up? item
      @items << item
      @equipped_weapon = item if item.is_a? Weapon
      if item.is_a?(BoxOfBolts) && health <= 80
        item.feed(self)
      end
      true
    else
      false
    end
  end

  def can_pick_up?(item)
    items_weight + item.weight <= 250
  end

  def items_weight
    @items.reduce(0) do |weight,item|
      weight + item.weight
    end
  end

  def move_left
    @position = [position[0]-1,position[1]]
  end

  def move_right
    @position = [position[0]+1,position[1]]
  end

  def move_up
    @position = [position[0],position[1]+1]
  end

  def move_down
    @position = [position[0],position[1]-1]
  end
end
