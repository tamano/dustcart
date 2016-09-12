module Dustcart
  module Resource
    module Input
      # input: directory
      class Directory < FileBase
        def precheck
          super

          raise <<-EOS.unindent unless Object::File.directory?(from)
            target(#{from}) is not a directory
          EOS
        end

        def run
          super

          target = "#{to_dir}/#{label}"
          FileUtils.cp_r(from, target)
        end
      end
    end
  end
end
