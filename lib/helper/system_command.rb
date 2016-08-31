require 'open3'
require 'shellwords'

# class to call system command
class SystemCommand
  class << self
    def exists?(command_name)
      exec_command("which #{Shellwords.escape(command_name)}")
      true
    rescue
      false
    end

    def exec_command(command)
      output, error, status = Open3.capture3(command)

      raise <<-EOS.unindent unless status.exitstatus.zero?
        can not execute command: '#{command}'
        Output: #{output}
        Error: #{error}
      EOS
    end
  end
end

# pipeline for command list
class CommandPipeline
  attr_reader :pipeline

  def initialize
    @pipeline = []
  end

  def add(command)
    @pipeline << command
  end

  def run
    @pipeline.each do |command|
      SystemCommand.exec_command(command)
    end
  end
end
