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

    def method_missing(method, *args, &block)
      super unless args.size == 1
      name = args[0]

      begin
        klass = Input.get_input_class(method)
      rescue NameError
        super
      end

      resource = klass.new(temp_dir, name, &block)
      resource.precheck
      resource.run
    end

    # ignore :reek:UtilityFunction
    def respond_to_missing?(method, *)
      Input.get_input_class(method)
      true
    rescue NameError
      false
    end
  end
end
