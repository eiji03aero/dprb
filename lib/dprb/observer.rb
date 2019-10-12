require 'observer'

module DPRB
  module Observer
    # Problem
    # We want to build a system that is highly integrated, that is, a system where every part is aware of the state of the whole. We also want it to be maintainable, so we should avoid coupling between classes.
    #
    # Solution
    # If we want some component (observer) to know about the activities of another one (subject), we could simply hard-wire both classes and inform the former upon some actions performed on the latter. This means that we should pass a reference to the observer when we create the subject, and call some of its methods when the latter changes. However, in this approach we are doing something we want to avoid— increasing coupling. What's more, if we wanted to inform some other observer, we'd have to modify the implementation of the subject so that it notifies the new observer even though nothing has changed. A much better approach is to keep a list of objects interested in the subject changes and define a clean interface between the source of the news (the subject) and the consumers (the observers). That way, whenever there's a change on the subject, we just need to iterate over the list of observers and notify them using the interface we defined.

    class Employee
      include Observable

      attr_reader :name, :title
      attr_reader :salary

      def initialize(name, title, salary)
        @name = name
        @title = title
        @salary = salary
      end

      def salary=(new_salary)
        @salary = new_salary
        changed
        notify_observers(self)
      end
    end

    class Payroll
      def update(obj)
        puts obj
      end
    end

    class TaxMan
      def update(obj)
        puts obj
      end
    end
  end
end
