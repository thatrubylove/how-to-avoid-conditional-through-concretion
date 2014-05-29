class Animal
  attr_reader :type, :size
  def initialize(type, size)
    @type = type
    @size = size
    @stomache = []
  end

  def eat(food)
    if food.type == :meat && [:omnivore, :carnivore].include?(@type) &&
                             !full?
      digest(food)
    elsif food.type == :veggies && [:omnivore, :herbivore].include?(@type) &&
                                   !full?
      digest(food)
    else
      vomit
    end
  end

  def full?
    if @size == :small
      @stomache.count > 1
    elsif @size == :medium
      @stomache.count > 2
    elsif @size == :large
      @stomache.count > 3
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

cow = Animal.new(:herbivore, :large)
dog = Animal.new(:omnivore, :medium)
cat = Animal.new(:carnivore, :small)

foods   = [meat, vegg, meat, vegg, meat, vegg, meat, vegg]
animals = [cow, dog, cat]

animals.each do |animal|
  foods.each do |food|
    full = animal.full? ? "a full" : "a"
    print "feeding #{food.type} to #{full} #{animal.size} #{animal.type}: "
    puts animal.eat(food)
  end
end

