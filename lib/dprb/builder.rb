module DPRB
  module Builder
    # Problem
    # We need to create a complex object that is hard to configure.
    #
    # Solution
    # The Builder pattern encapsulates the construction logic of complex objects in its own class. It defines an interface to configure the object step by step, hiding the implementation details.

    class Computer
      attr_accessor :display
      attr_accessor :motherboard
      attr_reader :drives

      def initialize(display = :crt, motherboard = Motherboard.new, drives = [])
        @display = display
        @motherboard = motherboard
        @drives = drives
      end
    end

    class CPU
      # Common CPU stuff...
    end

    class BasicCPU < CPU
    end

    class TurboCPU < CPU
    end

    class Motherboard
      attr_accessor :cpu
      attr_accessor :memory_size

      def initialize(cpu = BasicCPU.new, memory_size = 1000)
        @cpu = cpu
        @memry_size = memory_size
      end
    end

    class Drive
      def initialize(type, size, flag)
        @type = type
        @size = size
        @flag = flag
      end
    end


    class ComputerBuilder
      attr_reader :computer

      def initialize
        @computer = Computer.new
      end

      def turbo(flag = true)
        @computer.motherboard.cpu = TurboCPU.new
      end

      def display=(display)
        @computer.display = display
      end

      def memory_size=(size_in_mb)
        @computer.motherboard.memory_size = size_in_mb
      end

      def add_cd(flag = false)
        @computer.drives << Drive.new(:cd, 760, flag)
      end

      def add_dvd(flag = false)
        @computer.drives << Drive.new(:dvd, 4000, flag)
      end

      def add_hard_disk(size_in_mb)
        @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
      end
    end
  end
end
