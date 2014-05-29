class Animal
  attr_reader :type
  def initialize(type)
    @type = type
    @stomache = []
  end

  def eat(food)
    if food.type == :meat && [:omnivore, :carnivore].include?(@type)
      digest(food)
    elsif food.type == :veggies && [:omnivore, :herbivore].include?(@type)
      digest(food)
    else
      vomit
    end
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

class Food
  attr_reader :type
  def initialize(type)
    @type = type
  end
end

meat = Food.new(:meat)
vegg = Food.new(:veggies)

cow = Animal.new(:herbivore)
dog = Animal.new(:omnivore)
cat = Animal.new(:carnivore)

foods   = [meat, vegg]
animals = [cow, dog, cat]

foods.each do |food|
  animals.each do |animal|
    print "feeding #{food.type} to a #{animal.type}: "
    print animal.eat(food) + "\n"
  end
end

