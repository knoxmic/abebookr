module Abebookr
  module InventoryUpdate
    class Response
      attr_accessor :code, :message, :abebook_list
      attr_accessor :abebooks

      def initialize(params = {})
        @code = params["code"]
        @message = params["message"]
        @abebooks = abebookList.map do |abebook| Abebook.new(abebook) end
      end
    end
  end
end
