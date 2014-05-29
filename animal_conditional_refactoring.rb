class Stomache
  def initialize
    @contents = []
  end

  def <<(val)
    @contents.push(val)
  end
end

class LargeStomache < Stomache
  def full?
    @contents.count > 3
  end
end

class MediumStomache < Stomache
  def full?
    @contents.count > 2
  end
end

class SmallStomache < Stomache
  def full?
    @contents.count > 1
  end
end

class Animal
  def initialize(size)
    @stomache = Object.const_get("#{size.capitalize}Stomache").new
  end

  def size
    @stomache.class.to_s
  end

  def eat(food)
    vomit
  end

  def full?
    @stomache.full?
  end

private

  def digest(food)
    @stomache << food
    "yum yum"
  end

  def vomit
    "baaarffff"
  end
end

class Carnivore < Animal
  def initialize(size)
    super
  end

  def eat(food)
    return vomit if full?
    send("eat_#{food.type}", food)
  end

private

  def eat_meat(food)
    digest(food)
  end

  def eat_veggies(food)
    vomit
  end
end

class Herbivore < Animal
  def initialize(size)
    super
  end

  def eat(food)
    return vomit if full?
    send("eat_#{food.type}", food)
  end

private

  def eat_meat(food)
    vomit
  end

  def eat_veggies(food)
    digest(food)
  end
end

class Omnivore < Animal
  def initialize(size)
    super
  end

  def eat(food)
    return vomit if full?
    digest(food)
  end
end

class Food
  attr_reader :type
  def initialize(type)
    @type = type
  end
end

meat = Food.new(:meat)
vegg = Food.new(:veggies)

cow = Herbivore.new(:large)
dog = Omnivore.new(:medium)
cat = Carnivore.new(:small)

foods   = [meat, vegg, meat, vegg, meat, vegg, meat, vegg]
animals = [cow, dog, cat]

animals.each do |animal|
  foods.each do |food|
    full = animal.full? ? "a full" : "a"
    print "feeding #{food.type} to #{full} #{animal.size} #{animal.class}: "
    puts animal.eat(food)
  end
end

