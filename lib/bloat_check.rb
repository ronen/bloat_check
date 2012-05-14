require "logger"

require 'bloat_check/version'
require 'bloat_check/stats'
require 'bloat_check/wrap_requests'

module BloatCheck

  def self.disabled?
    return true if @disabled
  end

  def self.disable=(val)
    @disabled = val
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    return @logger if @logger
    return Rails.logger if defined? Rails
    @logger ||= Logger.new(STDERR).tap { |logger|
      logger.formatter = proc do |severity, datetime, progname, msg|
        "#{msg}\n"
      end
    }
  end

  def self.log(message)
    return block_given? && yield if disabled?

    start = Stats.get
    if block_given?
      begin
        ret = yield
      ensure
        (Stats.get - start).log(message)
      end
      ret
    else
      start.log(message)
    end
  end
end
