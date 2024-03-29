module DPRB
  module Singleton
    # Problem
    # We need to have a single instance of a certain class across the whole application.
    #
    # Solution
    # In the Singleton pattern, the access to the constructor is restricted so that it cannot be instantiated. So, the creation of the single instance is done inside the class and is held as a class variable. It can be accessed through a getter across the application.

    class SimpleLogger
      @@instance = self.new

      def self.instance
        return @@instance
      end

      private_class_method :new

      attr_accessor :level

      ERROR = 1
      WARNING = 2
      INFO = 3

      def initialize
        @log = File.open('out.txt', 'w')
        @level = WARNING
      end

      def error(msg)
        @log.puts(msg)
        @log.flush
      end

      def warning(msg)
        @log.puts(msg) if @level >= WARNING
        @log.flush
      end

      def info(msg)
        @log.puts(msg) if @level >= INFO
        @log.flush
      end
    end
  end
end
