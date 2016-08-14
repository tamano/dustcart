# coding: utf-8

require 'thor'
require 'unindent'

module Dustcart
  # command facade
  class CLI < Thor
    desc 'exec', 'execute backup.'
    option :instruction_file, type: :string, required: false, aliases: '-f'
    def exec
      instruction_file = (options[:instruction_file] || "#{Dir.home}/.dustcart/default.rb")

      begin
        check_file(instruction_file)
      rescue => error
        puts "ERROR: #{error.message}"
        exit 1
      end

      dsl = DSL.new
      dsl.load(instruction_file)
    end

    desc 'version', 'show version information.'
    def version
      puts Dustcart::VERSION
    end

    private

    def check_file(file)
      raise <<-EOS.unindent unless File.exist?(file)
        The instruction file (#{file}) doesn't exists.
      EOS

      mode = format('%o', File.stat(file).mode)[-3, 3]

      raise <<-EOS.unindent unless mode == '600'
        The instruction file (#{file}) has too open permission.
        Make sure its permission is 600.
      EOS
    end
  end
end
