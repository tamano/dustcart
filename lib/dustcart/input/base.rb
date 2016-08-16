module Dustcart
  module Resource
    module Input
      # base class for input
      class Base < Resource::Base
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
