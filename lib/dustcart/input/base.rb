module Dustcart
  module Resource
    module Input
      # base class for input
      class Base < Resource::Base
        attr_reader :from
        alias_method :to_dir, :dump_dir

        def initialize(to_dir, from, &block)
          super(to_dir, &block)
          @from = from
        end

        def precheck
          super

          raise <<-EOS.unindent unless Object::File.exists?(from)
            target(#{from}) does not exists
          EOS
        end
      end
    end
  end
end
