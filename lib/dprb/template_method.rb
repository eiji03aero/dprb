module DPRB
  module TemplateMethod
    # Problem
    # We have a complex bit of code, but somewhere in the middle there is a bit that needs to vary.
    #
    # Solution
    # The general idea of the Template Method pattern is to build an abstract base class with a skeletal method, which drives the bit of processing that needs to vary by making calls to abstract methods, which are then supplied by the concrete subclasses. The abstract base class controls the higher-level processing and the sub-classes simply fill in the details.

    class Report
      def initialize
        @title = 'Monthly Report'
        @text = ['Things are going', 'really, really well.']
      end

      def output_report
        output_start
        output_head
        output_body_start
        output_body
        output_body_end
        output_end
      end

      def output_body
        @text.each do |line|
          output_line(line)
        end
      end

      def output_start
        raise 'Called abstract method: output_start'
      end

      def output_head
        raise 'Called abstract method: output_head'
      end

      def output_body_start
        raise 'Called abstract method: output_body_start'
      end

      def output_line(line)
        raise 'Called abstract method: output_line'
      end

      def output_body_end
        raise 'Called abstract method: output_body_end'
      end

      def output_end
        raise 'Called abstract method: output_end'
      end
    end

    class PlainTextReport < Report
      def output_start
      end

      def output_head
        puts("**** #{@title} ****")
      end

      def output_body_start
      end

      def output_line(line)
        puts(line)
      end

      def output_body_end
      end

      def output_end
      end
    end
  end
end
