require 'abebookr/request'
require 'abebookr/order_update/response'
module Abebookr
  module OrderUpdate
    class Request < Abebookr::Request

      def initialize(params = {})
        params.each do |k,v|
          self.send("#{k}=", v) if self.respond_to?(k)
        end
        self
      end

      def perform
        raise "invalid parameters for action '#{action}'" unless valid?

        response = nil
        begin
          response = HTTParty.post(endpoint, body: to_xml)
          response = Response.parse(response)
        rescue Exception => e
          # do something
        end
      end

      def endpoint
        'https://orderupdate.abebooks.com:10003'
      end

      def request_type
        'orderUpdateRequest'
      end

      def to_xml(options = {})
        super
      end

      def valid?
        true
      end
    end
  end
end
