module Dustcart
  module Resource
    # resource: directory
    class Directory < Base
      define_attribute :label

      def run
        super

        target = "#{to_dir}/#{attributes[:label]}"
        FileUtils.cp_r(from, target)
      end
    end
  end
end
