require 'dustcart/output/amazon_s3'

module Dustcart
  # input facade
  module Output
    class << self
      def to_camel_case(str)
        str.split('_').map(&:capitalize).join
      end

      def get_class(method)
        const_get(to_camel_case(method.to_s))
      end
    end
  end
end
