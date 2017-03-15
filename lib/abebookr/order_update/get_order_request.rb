require 'abebookr/order_update/request'
module Abebookr
  module OrderUpdate
    class GetOrderRequest < Abebookr::OrderUpdate::Request
      attr_accessor :purchase_order_id # always required except in getAllNewOrders

      def action
        'getOrder'
      end

      def to_xml(options = {})
        super do |b|
          b.purchaseOrder(id: purchase_order_id)
        end
      end

      def valid?
        !purchase_order_id.nil?
      end
    end
  end
end
