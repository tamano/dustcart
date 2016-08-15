module Dustcart
  # resource group
  class Group
    def initialize(group_class, dir)
      @temp_dir = dir
      @group = group_class
    end

    def method_missing(method, *args, &block)
      super unless args.size == 1
      name = args[0]

      begin
        klass = @group.get_class(method)
      rescue NameError
        super
      end

      resource = klass.new(@temp_dir, name, &block)
      resource.precheck
      resource.run
    end

    # ignore :reek:UtilityFunction
    def respond_to_missing?(method, *)
      @group.get_class(method)
      true
    rescue NameError
      false
    end
  end
end
