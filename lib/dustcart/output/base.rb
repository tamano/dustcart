module Dustcart
  module Resource
    module Output
      # base class for input
      class Base < Resource::Base
        attr_reader :mode
        alias_method :from_dir, :dump_dir

        def initialize(from_dir, mode, &block)
          super(from_dir, &block)
          @mode = mode
        end
      end
    end
  end
end
