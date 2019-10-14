module DPRB
  module Strategy
    # Problem
    # We need to vary part of an algorithm— something we previously solved using the Template Method pattern— although we want to avoid its drawbacks, introduced by the fact that it's built around inheritance.
    #
    # Solution
    # To avoid problems introduced by inheritance we should use delegation. Instead of creating subclasses (like in the Template Method pattern), we tear out the varying part of the code and isolate it in its own class and create one of them for each variation. The key idea of the Strategy pattern is to define a family of objects (strategies), which all do (almost) the same thing and support the same interface. Then, the user of the strategy (context) can treat the strategies as interchangeable parts.

    class Report
      attr_reader :title, :text
      attr_accessor :formatter

      def initialize(formatter)
        @title = 'Monthly Report'
        @text = ['Things are going', 'really, really well.']
        @formatter = formatter
      end

      def output_report
        @formatter.output_report(self)
      end
    end

    class HTMLFormatter
      def output_report(context)
        puts('<html>')
        puts(' <head>')
        puts("<title>#{context.title}</title>")
        puts(' </head>')
        puts(' <body>')
        context.text.each do |line|
          puts("<p>#{line}</p>")
        end
        puts(' </body>')
        puts('</html>')
      end
    end

    class PlainTextFormatter
      def output_report(context)
        puts("***** #{context.title} *****")
        context.text.each do |line|
          puts(line)
        end
      end
    end
  end
end
