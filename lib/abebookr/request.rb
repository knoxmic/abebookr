require 'httparty'

module Abebookr
  class Request
    include HTTParty

    def to_xml(options = {})
      builder = options[:builder] || Builder::XmlMarkup.new
      builder.instruct! unless options.delete(:skip_instruct)

      builder.__send__(request_type, version: request_version) do |b|
        b.action(name: action) do
          b.username username
          b.password password
        end
        yield b if block_given?
      end
    end

    def perform
      HTTParty.post(endpoint, body: to_xml, headers: { 'Content-Type' => 'application/xml; charset=UTF-8' })
    end

    def request_type
      raise 'implement in subclass'
    end

    def action
      raise 'Implement in subclass'
    end

    def request_version
      '1.0'
    end

    def endpoint
      raise 'implement in subclass'
    end

    private

    def username
      Abebookr.config.username
    rescue
      raise 'Please configure your credentials'
    end

    def password
      Abebookr.config.password
    rescue
      raise 'Please configure your credentials'
    end
  end
end
