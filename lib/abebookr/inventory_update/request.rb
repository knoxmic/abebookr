module Abebookr
  module InventoryUpdate
    class Request < Abebookr::Request
      attr_reader :abebooks

      MAX_ABEBOOKS = 100

      def initialize(abebooks = [])
        @abebooks = abebooks
        raise "ONLY #{MAX_ABEBOOKS} PER REQUEST" if abebooks.count > MAX_ABEBOOKS
      end

      def endpoint
        'https://inventoryupdate.abebooks.com:10027'
      end

      def to_xml(options = {})
        super do |b|
          b.AbebookList do
            abebooks.each do |book|
              book.to_xml(builder: b)
            end
          end
        end
      end

      def action
        'bookupdate'
      end

      def request_type
        'inventoryUpdateRequest'
      end
    end
  end
end
