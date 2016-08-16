module Dustcart
  module Resource
    module Input
      # input: directory
      class Directory < Base
        define_attribute :label

        def precheck
          super

          raise <<-EOS.unindent unless Object::File.directory?(from)
            target(#{from}) is not a directory
          EOS

          raise <<-EOS.unindent if attributes.key?(:label) && attributes[:label] !~ /^\w+$/
            label should be word characters ([a-zA-Z0-9_]+)
          EOS
        end

        def run
          super

          target = "#{to_dir}/#{attributes[:label]}"
          FileUtils.cp_r(from, target)
        end
      end
    end
  end
end
