module DPRB
  module Adapter
    # Problem
    # We want an object talk to some other object but their interfaces don't match.
    #
    # Solution
    # We simply wrap the adaptee with our new adapter class. This class implements an interface that the invoker understands, although all the work is performed by the adapted object.

    class Encrypter
      def initialize(key)
        @key = key
      end

      def encrypt(reader, writer)
        key_index = 0
        while not reader.eof?
          clear_char = reader.getc
          encrypted_char = clear_char + @key[key_index]
          writer.putc(encrypted_char)
          key_index = (key_index + 1) % @key.size
        end
      end
    end

    class StringIOAdapter
      def initialize(string)
        @string = string
        @position = 0
      end

      def getc
        if @position >= @string.length
          raise ::EOFError
        end
        ch = @string[@position]
        @position += 1
        return ch
      end

      def eof?
        return @position >= @string.length
      end
    end

  end
end
