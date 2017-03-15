Dir[File.expand_path(File.join(File.dirname(__FILE__), 'abebookr', '*.rb'))].each {|f| require f}
Dir[File.expand_path(File.join(File.dirname(__FILE__), 'abebookr', 'inventory_update', '*.rb'))].each {|f| require f}
Dir[File.expand_path(File.join(File.dirname(__FILE__), 'abebookr', 'order_update', '*.rb'))].each {|f| require f}
require 'builder'
require 'httparty'
require 'nokogiri'

module Abebookr

  def self.configure
    yield(config)
  end

  def self.config
    @@config ||= Abebookr::Configuration.new
  end

  class Configuration
    attr_accessor :username, :password
  end
end
