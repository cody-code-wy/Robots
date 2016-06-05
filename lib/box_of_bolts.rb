class BoxOfBolts < Item

  def initialize
    super("Box of bolts",25)
  end

  def feed(robot)
    robot.heal(20) if robot.is_a? Robot
  end
end
