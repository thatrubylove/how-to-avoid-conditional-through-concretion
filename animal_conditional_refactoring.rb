class Stomache
  def initialize
    @contents = []
  end

  def vomit
    "baaarffff"
  end

  def digest(food)
    send("digest_when_#{full?}", food)
  end

private

  def digest_when_true(food)
    vomit
  end

  def digest_when_false(food)
    @contents << food
    "yum yum"
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
  def initialize(stomache)
    @stomache = stomache
  end

  def size
    @stomache.class.to_s
  end

  def full?
    @stomache.full?
  end

end

class Carnivore < Animal
  def eat(food)
    send("eat_#{food.type}", food)
  end

private

  def eat_meat(food)
    @stomache.digest(food)
  end

  def eat_veggies(food)
    @stomache.vomit
  end
end

class Herbivore < Animal
  def eat(food)
    send("eat_#{food.type}", food)
  end

private

  def eat_meat(food)
    @stomache.vomit
  end

  def eat_veggies(food)
    @stomache.digest(food)
  end
end

class Omnivore < Animal
  def eat(food)
    @stomache.digest(food)
  end
end

class Dog < Omnivore
  def initialize
    super MediumStomache.new
  end
end

class Cow < Herbivore
  def initialize
    super LargeStomache.new
  end
end

class Cat < Carnivore
  def initialize
    super SmallStomache.new
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

cow = Cow.new
dog = Dog.new
cat = Cat.new

foods   = [meat, vegg, meat, vegg, meat, vegg, meat, vegg]
animals = [cow, dog, cat]

animals.each do |animal|
  foods.each do |food|
    full = animal.full? ? "a full" : "a"
    print "feeding #{food.type} to #{full} #{animal.size} #{animal.class}: "
    puts animal.eat(food)
  end
end

