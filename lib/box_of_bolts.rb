class BoxOfBolts < Item

  NAME = "Box of bolts"
  WEIGHT = 25
  HEALING_POWER = 20

  def initialize
    super(NAME, WEIGHT)
  end

  def feed(robot)
    robot.heal(HEALING_POWER)
  end

end