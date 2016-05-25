require 'bogo-ui'
require 'command_line_reporter'

module Bogo

  class Ui
    # Table output helper
    class Table

      include CommandLineReporter

      # @return [Bogo::Ui]
      attr_reader :ui
      # @return [Array<Proc>]
      attr_reader :table
      # @return [Object]
      attr_reader :proxy_to

      # Create a new instance
      #
      # @param ui [Bogo::Ui]
      # @yield table content
      # @return [self]
      def initialize(ui, inst=nil, &block)
        @proxy_to = inst
        @ui = ui
        @base = block
        @content = []
        @printed_lines = []
      end

      # If proxy instance is provided, forward if possible
      def method_missing(m_name, *args, &block)
        if(proxy_to && proxy_to.respond_to?(m_name, true))
          proxy_to.send(m_name, *args, &block)
        else
          super
        end
      end

      # Update the table content
      #
      # @yield table content
      # @return [self]
      def update(&block)
        @content << block
        self
      end

      # Override to provide buffered support
      #
      # @param options [Hash]
      # @return [self]
      def table(options={})
        @table = BufferedTable.new(options)
        yield
        self
      end

      # Override to provide buffered support
      #
      # @param options [Hash]
      # @return [self]
      def row(options={})
        options[:encoding] ||= @table.encoding
        @row = BufferedRow.new(options.merge(:buffer => @table.buffer))
        yield
        @table.add(@row)
        self
      end

      # Output table to defined UI
      #
      # @return [self]
      # @note can be called multiple times to print table updates
      def display
        # init the table
        instance_exec(&@base)
        # load the table
        @content.each do |tblock|
          instance_exec(&tblock)
        end
        @table.output
        @table.buffer.rewind
        output = @table.buffer.read.split("\n")
        output = output.find_all do |line|
          !@printed_lines.include?(
            Digest::SHA256.hexdigest(line.gsub(/\s/, ''))
          )
        end
        @printed_lines.concat(
          output.map{|l| Digest::SHA256.hexdigest(l.gsub(/\s/, '')) }
        )
        ui.puts output.join("\n") unless output.empty?
        self
      end

      # Wrapper class to get desired buffering
      class BufferedTable < CommandLineReporter::Table

        # @return [StringIO]
        attr_reader :buffer

        # Create new instance and init buffer
        #
        # @return [self]
        def initialize(*args)
          @buffer = StringIO.new
          super
        end

        # buffered puts
        def puts(string)
          buffer.puts(string)
        end

        # buffered print
        def print(string)
          buffer.print(string)
        end

      end

      # Wrapper class to get desired buffering
      class BufferedRow < CommandLineReporter::Row

        # @return [StringIO]
        attr_reader :buffer

        # Create new instance and init buffer
        #
        # @return [self]
        def initialize(options={})
          @buffer = options.delete(:buffer)
          super
        end

        # buffered puts
        def puts(string)
          buffer.puts(string)
        end

        # buffered print
        def print(string)
          buffer.print(string)
        end

      end

    end
  end

end
