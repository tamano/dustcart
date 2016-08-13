# coding: utf-8

require 'thor'

module Dustcart
  class CLI < Thor
    desc "version", "show version information."
    def version
      puts Dustcart::VERSION
    end
  end
end