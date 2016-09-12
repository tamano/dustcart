require 'helper/system_command'
require 'shellwords'

module Dustcart
  module Resource
    module Input
      # input: postgresql
      class Postgres < Base
        define_attribute :host
        define_attribute :port
        define_attribute :user
        define_attribute :pass
        attr_reader :database_name

        COMMAND = 'pg_dump'.freeze

        def initialize(to_dir, database_name, &block)
          super(to_dir, &block)
          @database_name = database_name

          host  '127.0.0.1'     unless host
          port  '5432'          unless port
          label 'database.dump' unless label
        end

        def precheck
          super

          requirements

          raise <<-EOS.unindent unless SystemCommand.exists?(COMMAND)
            #{COMMAND} command is not installed
          EOS

          raise <<-EOS.unindent unless database_name
            'database_name' is required
          EOS
        end

        def run
          super

          create_dump
        end

        private

        def requirements
          %i(host port user pass label).each do |var|
            raise <<-EOS.unindent unless attributes.key?(var)
              '#{var}' is required
            EOS
          end
        end

        def create_dump
          pipeline = CommandPipeline.new
          pipeline.add(
            "#{password_env} #{COMMAND} #{options} #{Shellwords.escape(database_name)}"
          )
          pipeline.run
        end

        def password_env
          "PGPASSWORD=#{Shellwords.escape(pass)}"
        end

        # ignore :reek:FeatureEnvy:
        def options
          options = []
          options << general_options
          options << user_options
          options << target_options
          options.join(' ')
        end

        # ignore :reek:FeatureEnvy:
        def general_options
          options = []
          options << '--format=custom'
          options << '--blobs'
          options << "--file=#{Shellwords.escape(to_dir)}/#{Shellwords.escape(label)}"
          options.join(' ')
        end

        # ignore :reek:FeatureEnvy:
        def user_options
          options = []
          options << "--host=#{Shellwords.escape(host)}"
          options << "--port=#{Shellwords.escape(port)}"
          options << "--username=#{Shellwords.escape(user)}"
          options.join(' ')
        end

        # ignore :reek:FeatureEnvy:
        def target_options
          options = []
          options << "--file=#{Shellwords.escape(to_dir)}/#{Shellwords.escape(label)}"
          options.join(' ')
        end
      end
    end
  end
end
