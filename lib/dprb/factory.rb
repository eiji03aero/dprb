module DPRB
  module Factory
    # Problem
    # We need to create objects without having to specify the exact class of the object that will be created.
    #
    # Solution
    # The Factory pattern is a specialization of the Template pattern. We start by creating a generic base class where we don't make the "which class" decision. Instead, whenever it needs to create a new object, it calls a method that is defined in a subclass. So, depending on the subclass we use (factory), we create objects of one class or another (products).

    class Pond
      def initialize(number_animals)
        @animals = number_animals.times.inject([]) do |animals, i|
          animals << new_animal("Animal#{i}")
          animals
        end
      end

      def simulate_one_day
        @animals.each {|animal| animal.speak}
        @animals.each {|animal| animal.eat}
        @animals.each {|animal| animal.sleep}
      end
    end

    class FrogPond < Pond
      def new_animal(name)
        Frog.new(name)
      end
    end

    class Frog
      def initialize(name)
        @name = name
      end

      def speak
        @name
      end

      def eat
        1 + 1
      end

      def sleep
        0
      end
    end
  end
end
