class Weapon < Item

  attr_reader :damage, :range, :one_use

  def initialize(name, weight, damage, range=1, one_use=false)
    super(name,weight)
    @damage = damage
    @range = range
    @one_use = one_use
  end

  def hit (target)
    target.wound(damage)
  end
end
