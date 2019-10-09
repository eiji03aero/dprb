module DPRB
  module Iterator
    # Problem
    # We have an aggregate object and we want to provide a way to access its collection of sub-objects without exposing its underlaying representation.
    #
    # Solution
    # There are two proposed solutions: external iterators and internal iterators.

    class ArrayIterator
      def initialize(array)
        @array = array
        @index = 0
      end

      def has_next?
        @index < @array.length
      end

      def item
        @array[@index]
      end

      def next_item
        value = @array[@index]
        @index += 1
        value
      end
    end

    class Account
      attr_accessor :name, :balance

      def initialize(name, balance)
        @name = name
        @balance = balance
      end

      def <=>(other)
        balance <=> other.balance
      end
    end

    class Portfolio
      include Enumerable

      def initialize
        @accounts = []
      end

      def each(&block)
        @accounts.each(&block)
      end

      def add_account(account)
        @accounts << account
      end
    end
  end
end
