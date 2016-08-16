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
        end

        def run
          super
        end
      end
    end
  end
end
