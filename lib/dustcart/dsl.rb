module Dustcart
  # DSL for instruction file
  class DSL
    attr_reader :dump_base

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

      @dump_base = path.chomp('/')
      time_str = Time.now.strftime('%Y%m%d%H%M%S')
      @_temp_dir = "#{@dump_base}/#{time_str}"
    end

    def temp_dir
      return @_temp_dir if @_temp_dir

      @dump_base = '/tmp/dustcart'
      time_str = Time.now.strftime('%Y%m%d%H%M%S')
      @_temp_dir = "#{@dump_base}/#{time_str}"
    end

    def group(*args, &block)
      size = args.size
      raise ArgumentError, "wrong number of arguments (#{size} for 1)" unless size == 1

      method = args.first

      group = Group.new(method, temp_dir)
      group.instance_eval(&block)
    end

    def cleanup(target)
      raise "target(#{target}) is not available." unless [:all, :except_latest].include?(target)

      Dir.glob("#{dump_base}/*").each do |file|
        next if target == :except_latest && file.start_with?(temp_dir)
        FileUtils.rm_rf(file)
      end
    end
  end
end
