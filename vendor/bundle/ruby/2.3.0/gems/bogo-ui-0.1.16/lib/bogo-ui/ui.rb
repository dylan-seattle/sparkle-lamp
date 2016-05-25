require 'bogo-ui'
require 'paint'

module Bogo
  # CLI UI helper
  class Ui

    autoload :Table, 'bogo-ui/table'

    # @return [Truthy, Falsey]
    attr_accessor :colorize
    # @return [String]
    attr_accessor :application_name
    # @return [IO]
    attr_reader :output_to
    # @return [Truthy, Falsey]
    attr_accessor :auto_confirm
    # @return [Truthy, Falsey]
    attr_accessor :auto_default
    # @return [Smash] options
    attr_reader :options

    # Build new UI instance
    #
    # @param args [Hash]
    # @option args [String] :app_name name of application
    # @option args [TrueClass, FalseClass] :colors enable/disable colors
    # @option args [IO] :output_to IO to write
    # @return [self]
    def initialize(args={})
      @application_name = args.fetch(:app_name, 'App')
      @colorize = args.fetch(:colors, true)
      @output_to = args.fetch(:output_to, $stdout)
      @auto_confirm = args.fetch(:auto_confirm, args.fetch(:yes, false))
      @auto_default = args.fetch(:auto_default, args.fetch(:defaults, false))
      @options = args.to_smash
    end

    # Output directly
    #
    # @param string [String]
    # @return [String]
    def puts(string='')
      output_to.puts string
      string
    end

    # Output directly
    #
    # @param string [String]
    # @return [String]
    def print(string='')
      output_to.print string
      string
    end

    # Output information string
    #
    # @param string [String]
    # @return [String]
    def info(string, *args)
      output_method = args.include?(:nonewline) ? :print : :puts
      o_color = args.include?(:verbose) ? :yellow : :green
      self.send(output_method, "#{color("[#{application_name}]:", o_color)} #{string}")
      string
    end

    # Format warning string
    #
    # @param string [String]
    # @return [String]
    def warn(string, *args)
      output_method = args.include?(:nonewline) ? :print : :puts
      self.send(output_method, "#{color('[WARN]:', :yellow, :bold)} #{string}")
      string
    end

    # Format error string
    #
    # @param string [String]
    # @return [String]
    def error(string, *args)
      output_method = args.include?(:nonewline) ? :print : :puts
      self.send(output_method, "#{color('[ERROR]:', :red, :bold)} #{string}")
      string
    end

    # Format fatal string
    #
    # @param string [String]
    # @return [String]
    def fatal(string, *args)
      output_method = args.include?(:nonewline) ? :print : :puts
      self.send(output_method, "#{color('[FATAL]:', :red, :bold)} #{string}")
      string
    end

    # Output info if verbose flag is set
    #
    # @param string [String]
    # @return [String, NilClass]
    def verbose(string, *args)
      if(options[:verbose])
        info(string, :verbose, *args)
        string
      end
    end

    # Format debug string and output only if debug is set
    #
    # @param string [String]
    # @return [String, NilClass]
    def debug(string, *args)
      if(options[:debug])
        output_method = args.include?(:nonewline) ? :print : :puts
        self.send(output_method, "#{color('[DEBUG]:', :white, :bold)} #{string}")
        string
      end
    end

    # Colorize string
    #
    # @param string [String]
    # @param args [Symbol]
    # @return [String]
    def color(string, *args)
      if(colorize)
        Paint[string, *args]
      else
        string
      end
    end

    # Prompt for question and receive answer
    #
    # @param question [String]
    # @param default [String]
    # @return [String]
    def ask(question, *args)
      opts = (args.detect{|x| x.is_a?(Hash)} || {}).to_smash
      default = args.detect{|x| x.is_a?(String)} || opts[:default]
      if(auto_default && default)
        default
      else
        valid = opts[:valid]
        string = question.dup
        if(default)
          string << " [#{default}]"
        end
        result = nil
        until(result)
          info "#{string}: ", :nonewline
          result = $stdin.gets.strip
          if(result.to_s.empty? && default)
            result = default
          end
          if(valid)
            case valid
            when Array
              result = nil unless valid.include?(result)
            when Regexp
              result = nil unless result =~ valid
            end
          end
          if(result.to_s.empty?)
            error 'Please provide a valid value'
            result = nil
          end
        end
        result
      end
    end
    alias_method :ask_question, :ask

    # Confirm question. Requires user to provide Y or N answer
    #
    # @param question [String]
    def confirm(question)
      unless(auto_confirm)
        result = ask("#{question} (Y/N)", :valid => /[YyNn]/).downcase
        raise 'Confirmation declined!' unless result == 'y'
      end
    end

    # Create a new table
    #
    # @param inst [Object] instance to attach table (for method call proxy)
    # @return [Table]
    def table(inst=nil, &block)
      Table.new(self, inst, &block)
    end

  end
end
