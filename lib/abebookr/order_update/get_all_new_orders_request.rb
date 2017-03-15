require 'abebookr/order_update/request'
module Abebookr
  module OrderUpdate
    class GetAllNewOrdersRequest < Abebookr::OrderUpdate::Request

      def action
        'getAllNewOrders'
      end

      def valid?
        true
      end

      def to_xml(options = {})
        super
      end
    end
  end
end
