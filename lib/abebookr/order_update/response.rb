module Abebookr
  module OrderUpdate
    class Response
      attr_accessor :orders

      def self.parse(xml)
        doc = Nokogiri::XML(xml) { |config| config.strict.noblanks }
        case doc.children.first.name
        when 'orderUpdateResponse'
          new(orders: build_orders(doc.children.first))
        when 'requestError'
          raise RequestError.new(
            code: doc.xpath('requestError/code').value.to_i,
            message: doc.xpath('requestError/message').value
          )
        end
      end

      def self.build_orders(xml)
        case xml.children.first.name
        when 'purchaseOrder'
          [PurchaseOrder.from_xml(xml.children.first)]
        when 'purchaseOrderList'
          xml.children.first.children.map { |order| PurchaseOrder.from_xml(order) }
        else
          raise xml.children.first.name
        end
      end

      def initialize(params = {})
        self.orders = params[:orders] || []
      end
    end
  end
end
