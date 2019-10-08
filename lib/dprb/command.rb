module DPRB
  module Command
    # Problem
    # We want to perform some specific task without knowing how the whole process works or having any information about the receiver of the request.
    #
    # Solution
    # The Command pattern decouples the object that needs to perform a specific task from the one that knows how to do it. It encapsulates all the needed information to do the job into its own object including: who the receiver(s) is(are), the methods to invoke, and the parameters. That way, any object that wants to perform the task only needs to know about the command object interface.

    class SaveCommand
      def execute
        # Save action
      end
    end

    class SlickButton
      attr_accessor :command

      def initialize(command)
        @command = command
      end

      def on_button_push
        @command.execute if @command
      end
    end


    class Command
      def initialize(arg)
      end
    end

    class CreateFile < Command
      def initialize(path, contents)
        super "Create file: #{path}"
        @path = path
        @contents = contents
      end

      def execute
        f = File.open(@path, 'w')
        f.write(@contents)
        f.close
      end

      def unexecute
        File.delete(@path)
      end
    end

    class CopyFile < Command
      def initialize(path, dist_path)
        super "Copy file: #{path}"
        @path = path
        @dist_path = dist_path
      end

      def execute; end
      def unexecute; end
    end

    class DeleteFile < Command
      def initialize(path)
        super "Delete file: #{path}"
        @path = path
      end

      def execute; end
      def unexecute; end
    end

    class CompositeCommand < Command
      def initialize
        @commands = []
      end

      def add_command(cmd)
        @commands << cmd
      end

      def execute
        @commands.each{|cmd| cmd.execute}
      end
    end
  end
end
