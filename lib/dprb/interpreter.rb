require 'find'

module DPRB
  module Interpreter
    # Problem
    # We need a specialized language to solve a well defined problem of know domain.
    #
    # We need a specialized language to solve a well defined problem of no (as in nil) domain.
    #
    # We need a specialized language to solve a well defined problem of a known domain.
    #
    # Solution
    # Interpreters normally work in two phases: parsing and evaluating. The parser reads the data and creates a data structure called abstract syntax tree (AST), which includes the same information but represented in a tree of objects. Then, the AST is evaluated against external conditions. In the AST, the leaf nodes (terminals) are the most basic building blocks of the language. The nonleaf nodes (nonterminals) represent the higher order concepts in the language. After providing the external conditions (context), the AST is evaluated recursively.

    # ast
    class Expression
    end

    # terminal
    class All < Expression
      def evaluate(dir)
        results = []
        Find.find(dir) do |p|
          next unless File.file?(p)
          results << p
        end
        results
      end
    end

    class FileName < Expression
      def initialize(pattern)
        @pattern = pattern
      end

      def evaluate(dir)
        results = []
        Find.find(dir) do |p|
          next unless File.file?(p)
          name = File.basename(p)
          results << p if File.fnmatch(@pattern, name)
        end
        results
      end
    end

    class Bigger < Expression
      def initialize(size)
        @size = size
      end

      def evaluate(dir)
        results = []
        Find.find(dir) do |p|
          next unless File.file?(p)
          results << p if( File.size(p) > @size)
        end
        results
      end
    end

    class Writable < Expression
      def evaluate(dir)
        results = []
        Find.find(dir) do |p|
          next unless File.file?(p)
          results << p if( File.writable?(p) )
        end
        results
      end
    end

    # nonterminals
    class Not < Expression
      def initialize(expression)
        @expression = expression
      end

      def evaluate(dir)
        All.new.evaluate(dir) - @expression.evaluate(dir)
      end
    end

    class Or < Expression
      def initialize(expression1, expression2)
        @expression1 = expression1
        @expression2 = expression2
      end

      def evaluate(dir)
        result1 = @expression1.evaluate(dir)
        result2 = @expression2.evaluate(dir)
        (result1 + result2).sort.uniq
      end
    end

    class And < Expression
      def initialize(expression1, expression2)
        @expression1 = expression1
        @expression2 = expression2
      end

      def evaluate(dir)
        result1 = @expression1.evaluate(dir)
        result2 = @expression2.evaluate(dir)
        (result1 & result2)
      end
    end
  end
end
