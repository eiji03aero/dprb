module DPRB
  module Composite
    # Problem
    # We need to build a hierarchy of tree objects and want to interact with all them the same way, regardless of whether it's a leaf object or not.
    #
    # Solution
    # There are three main classes in the Composite pattern: the component, the leaf and the composite classes. The component is the base class and defines a common interface for all the components. The leaf is an indivisible building block of the process. The composite is a higher-level component built from subcomponents, so it fulfills a dual role: it is a component and a collection of components. As both composite and leaf classes implement the same interface, they can be used the same way.

    # component
    class Task
      attr_accessor :name, :parent

      def initialize(name)
        @name = name
        @parent = nil
      end

      def get_time_required
        0.0
      end
    end

    # leaf
    class CompositeTask < Task
      def initialize(name)
        super(name)
        @sub_tasks = []
      end

      def add_sub_task(task)
        @sub_tasks << task
        task.parent = self
      end

      def remove_sub_task(task)
        @sub_tasks.delete(task)
        task.parent = nil
      end

      def get_time_required
        @sub_tasks.inject(0.0) {|time, task| time += task.get_time_required}
      end
    end


    class AddDryIngredientsTask < Task
      def initialize
        super('Add dry ingredients')
      end

      def get_time_required
        1.0
      end
    end


    class AddLiquidsTask < Task
      def initialize
        super('Add liquids')
      end

      def get_time_required
        1.5
      end
    end

    class MixTask < Task
      def initialize
        super('Mix')
      end

      def get_time_required
        0.5
      end
    end

    # composite
    class MakeBatterTask < CompositeTask
      def initialize
        super('Make batter')
      end
    end

    class MakeCakeTask < CompositeTask
      def initialize
        super('Make cake')
        add_sub_task(MakeBatterTask.new)
      end
    end
  end
end
