require 'dustcart/resource/directory'

module Dustcart
  # resource facade
  module Resource
    class << self
      def to_camel_case(str)
        str.split('_').map(&:capitalize).join
      end

      def get_resource_class(method)
        const_get(to_camel_case(method.to_s))
      end
    end
  end
end
