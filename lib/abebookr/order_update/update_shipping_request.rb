module Abebookr
  module OrderUpdate
    class UpdateShippingRequest < Abebookr::OrderUpdate::Request
      attr_accessor :purchase_order_id # always required!
      attr_accessor :shipping # required

      def action
        'updateShipping'
      end

      def to_xml(options = {})
        super do |b|
          b.purchaseOrder(id: purchase_order_id) do
            shipping.to_xml(builder: b)
          end
        end
      end

      def valid?
        return false if purchase_order_id.nil?
        return false if shipping.nil?
        true
      end
    end
  end
end
