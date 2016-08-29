module Dustcart
  module Resource
    module Input
      # base class for file system input
      class FileBase < Base
        attr_reader :from

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
