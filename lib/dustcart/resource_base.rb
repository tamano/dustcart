module Dustcart
  module Resource
    # base class for resources
    class Base
      attr_reader :dump_dir
      attr_reader :attributes

      @defined_attributes ||= {}

      def initialize(dir, &block)
        print_initialize_comment

        @dump_dir = dir
        @attributes ||= {}
        instance_eval(&block) if block
      end

      def method_missing(method, *args, &block)
        method = method.to_sym

        if self.class.defined_attributes.key?(method)
          case args.size
          when 0
            return @attributes[method]
          when 1
            return @attributes[method] = args.first
          end
        end

        super
      end

      def respond_to_missing?(method, *)
        self.class.defined_attributes.key?(method) || super
      end

      def run
        FileUtils.mkdir_p(dump_dir)
      end

      def precheck
      end

      class << self
        attr_reader :defined_attributes

        def inherited(subclass)
          subclass.instance_variable_set(
            :@defined_attributes,
            defined_attributes.dup
          )
        end

        def define_attribute(name)
          name = name.to_sym
          @defined_attributes[name] = nil unless @defined_attributes.key?(name)
        end
      end

      private

      def print_initialize_comment
        puts "  Resource: #{self.class.name.split('::').last}"
      end
    end
  end
end
