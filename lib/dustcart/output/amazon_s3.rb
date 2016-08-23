require 'aws-sdk'
require 'helper/zip_file_generator'

module Dustcart
  module Resource
    module Output
      # output: S3
      # ignore :reek:UncommunicativeModuleName
      class AmazonS3 < Base
        define_attribute :access_key_id
        define_attribute :secret_access_key
        define_attribute :region
        define_attribute :bucket

        attr_reader :zip_file_name

        def initialize(from_dir, mode, &block)
          super(from_dir, mode, &block)

          @zip_file_name = "#{from_dir}.zip"
        end

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

        private

        def generate_zip_file
          zf = ZipFileGenerator.new(from_dir, zip_file_name)
          zf.write
        end

        def upload_zip_file
          resource = Aws::S3::Resource.new(
            access_key_id: access_key_id,
            secret_access_key: secret_access_key,
            region: region
          )

          obj_name = File.basename(zip_file_name)
          obj = resource.bucket(bucket).object(obj_name)
          obj.upload_file(zip_file_name)
        end
      end
    end
  end
end
