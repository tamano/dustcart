# coding: utf-8

require 'thor'

module Dustcart
  # command facade
  class CLI < Thor
    desc 'version', 'show version information.'
    def version
      puts Dustcart::VERSION
    end
  end
end
