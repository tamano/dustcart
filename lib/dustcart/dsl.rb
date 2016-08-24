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

      path.chomp!('/')
      time_str = Time.now.strftime('%Y%m%d%H%M%S')
      @_temp_dir = "#{path}/#{time_str}"
      @dump_base = path
    end

    def temp_dir
      return @_temp_dir if @_temp_dir

      time_str = Time.now.strftime('%Y%m%d%H%M%S')
      @_temp_dir = "/tmp/#{time_str}"
      @dump_base = '/tmp'
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

      Dir.glob("#{dump_base}/*").each do |f|
        next if target == :except_latest && f.start_with?(temp_dir)
        FileUtils.rm_rf(f)
      end
    end
  end
end
