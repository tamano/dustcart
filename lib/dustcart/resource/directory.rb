module Dustcart
  module Resource
    # resource: directory
    class Directory < Base
      define_attribute :label

      def run
        # puts "#{@from} -> #{@to_dir}"
        # p @attributes
      end
    end
  end
end
