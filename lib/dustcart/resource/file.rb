module Dustcart
  module Resource
    # resource: file
    class File < Base
      define_attribute :label

      def precheck
        super

        raise <<-EOS.unindent unless Object::File.file?(from)
          target(#{from}) does not exists or is not a regular file
        EOS

        raise <<-EOS.unindent if attributes.key?(:label) && attributes[:label] !~ /^\w+$/
          label should be word characters ([a-zA-Z0-9_]+)
        EOS
      end

      def run
        super

        target = "#{to_dir}/#{attributes[:label]}"
        FileUtils.cp(from, target)
      end
    end
  end
end
