module Dustcart
  # DSL for instruction file
  class DSL
    def initialize
    end

    def load(path)
      load_from(path)
    end

    private

    def load_from(path)
      instance_eval(File.read(path), path) if path
    end

    def dump_site(path)
      raise 'dump_site has already set.' if @_temp_dir

      path.chomp!('/')
      time_str = Time.now.strftime('%Y%m%d%H%M%S')
      @_temp_dir = "#{path}/#{time_str}"
    end

    def temp_dir
      return @_temp_dir if @_temp_dir

      time_str = Time.now.strftime('%Y%m%d%H%M%S')
      @_temp_dir = "/tmp/#{time_str}"
    end

    def group(*args, &block)
      raise ArgumentError, "wrong number of arguments (#{args.size} for 1)" unless args.size == 1

      method = args.first

      case method
      when :input
        input = Group.new(Input, temp_dir)
        input.instance_eval(&block)
      else
        raise "invalid group type (#{method})"
      end
    end
  end
end
