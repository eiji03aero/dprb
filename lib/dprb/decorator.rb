module DPRB
  module Decorator
    # Problem
    # We need to vary the responsibilities of an object, adding some features.
    #
    # Solution
    # In the Decorator pattern we create an object that wraps the real one, and implements the same interface and forwarding method calls. However, before delegating to the real object, it performs the additional feature. Since all decorators implement the same core interface, we can build chains of decorators and assemble a combination of features at runtime.

    class SimpleWriter
      def initialize(path)
        @file = File.open(path, 'w')
      end

      def write_line(line)
        @file.print(line)
        @file.print("\n")
      end

      def pos
        @file.pos
      end

      def rewind
        @file.rewind
      end

      def close
        @file.close
      end
    end

    class WriterDecorator
      def initialize(real_writer)
        @real_writer = real_writer
      end

      def write_line(line)
        @real_writer.write_line(line)
      end

      def pos
        @real_writer.pos
      end

      def rewind
        @real_writer.rewind
      end

      def close
        @real_writer.close
      end
    end

    class NumberingWriter < WriterDecorator
      def initialize(real_writer)
        super(real_writer)
        @line_number = 1
      end

      def write_line(line)
        @real_writer.write_line("#{@line_number}: #{line}")
        @line_number += 1
      end
    end
  end
end
