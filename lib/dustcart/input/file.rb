module Dustcart
  module Resource
    module Input
      # input: file
      class File < FileBase
        define_attribute :label

        def precheck
          super

          raise <<-EOS.unindent unless Object::File.file?(from)
            target(#{from}) is not a regular file
          EOS
        end

        def run
          super

          target = "#{to_dir}/#{label}"
          FileUtils.cp(from, target)
        end
      end
    end
  end
end
