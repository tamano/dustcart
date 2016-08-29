module Dustcart
  module Resource
    module Input
      # base class for input
      class Base < Resource::Base
        define_attribute :label
        alias_method :to_dir, :dump_dir

        def initialize(to_dir, &block)
          super(to_dir, &block)
        end

        def precheck
          super

          raise <<-EOS.unindent if attributes.key?(:label) && label !~ /^\w+$/
            label should be word characters ([a-zA-Z0-9_]+)
          EOS
        end
      end
    end
  end
end
