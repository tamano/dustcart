module Dustcart
  module Resource
    module Output
      # output: S3
      class AmazonS3 < Base
        define_attribute :access_key_id
        define_attribute :secret_access_key
        define_attribute :region
        define_attribute :bucket

        def precheck
          super

          raise <<-EOS.unindent unless mode == :all
            mode (#{mode}) unknown.
            :all is the only available mode now.
          EOS

          [:access_key_id, :secret_access_key, :region, :bucket].each do |key|
            raise <<-EOS.unindent unless attributes.key?(key)
              #{key} is required.
            EOS
          end
        end

        def run
          super
        end
      end
    end
  end
end
