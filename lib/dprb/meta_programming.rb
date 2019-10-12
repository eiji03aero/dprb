module DPRB
  module MetaProgramming
    # Problem
    # We want to gain more flexibility when defining new classes and create custom tailored objects on the fly.
    #
    # Solution
    # Ruby is a very dynamic language, but that doesn't apply only to typing— we can even define new methods in our classes at runtime thanks to singleton methods. If instead of adding one method we want to add a group of them, we can also use the extend method, which would have the same effect as including a module. Last but not least, with the class_eval method we can evaluate a string in the context of a class, which combined with string interpolations is a really great asset to create new methods at runtime.

    class CompositeBase
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def self.member_of(composite_name)
        code = %Q{
          attr_accessor :parent_#{composite_name}
        }
        class_eval(code)
      end

      def self.composite_of(composite_name)
        member_of composite_name
        code = %Q{
          def sub_#{composite_name}s
            @sub_#{composite_name}s = [] unless @sub_#{composite_name}s
            @sub_#{composite_name}s
          end
          def add_sub_#{composite_name}(child)
            return if sub_#{composite_name}s.include?(child)
            sub_#{composite_name}s << child
            child.parent_#{composite_name} = self
          end
          def delete_sub_#{composite_name}(child)
            return unless sub_#{composite_name}s.include?(child)
            sub_#{composite_name}s.delete(child)
            child.parent_#{composite_name} = nil
          end
        }
        class_eval(code)
      end
    end

    class Tiger < CompositeBase
      member_of(:population)
      member_of(:classification)
    end

    class Tree < CompositeBase
      member_of(:population)
      member_of(:classification)
    end

    class Jungle < CompositeBase
      composite_of(:population)
    end

    class Species < CompositeBase
      composite_of(:classification)
    end
  end
end
