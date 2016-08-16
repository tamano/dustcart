module Dustcart
  # resource group
  class Group
    INPUT_RESOURCES = [
      'dustcart/input/base',
      'dustcart/input/directory',
      'dustcart/input/file'
    ].freeze

    OUTPUT_RESOURCES = [
      'dustcart/output/amazon_s3'
    ].freeze

    def initialize(group_class, dir)
      @temp_dir = dir
      initialize_classes(group_class)
    end

    def method_missing(method, *args, &block)
      super unless args.size == 1
      name = args[0]

      begin
        klass = get_class(method)
      rescue NameError
        super
      end

      resource = klass.new(@temp_dir, name, &block)
      resource.precheck
      resource.run
    end

    # ignore :reek:UtilityFunction
    def respond_to_missing?(method, *)
      get_class(method)
      true
    rescue NameError
      false
    end

    private

    # ignore :reek:UtilityFunction
    def to_camel_case(str)
      str.split('_').map(&:capitalize).join
    end

    def get_class(method)
      @group_type.const_get(to_camel_case(method.to_s))
    end

    def initialize_classes(group_class)
      case group_class
      when :input
        INPUT_RESOURCES.each { |file| require file }
        @group_type = Resource::Input
      when :output
        OUTPUT_RESOURCES.each { |file| require file }
        @group_type = Resource::Output
      else
        raise "invalid group type (#{group_class})"
      end
    end
  end
end
