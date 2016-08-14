module Dustcart
  module Resource
    # resource: directory
    class Directory
      def initialize(to_dir, from_dir, &block)
        @to_dir = to_dir
        @from_dir = from_dir
        @block = block
      end

      def run
        # puts "#{@from_dir} -> #{@to_dir}"
      end
    end
  end
end
