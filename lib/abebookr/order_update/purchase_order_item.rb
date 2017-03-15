require 'abebookr/value_object'
module Abebookr
  module OrderUpdate
    class PurchaseOrderItem < Abebookr::ValueObject
      attr_accessor :id, :status, :book, :order_date, :purchase_order_id, :seller_total, :seller_total_currency, :status, :status_code

      def self.from_xml(item)
        new(
          id: item.attribute('id').value,
          book: Book.from_xml(item.xpath('book')),
          order_date: Utils.order_date_to_datetime(item.xpath('orderDate')),
          purchase_order_id: item.xpath('purchaseOrder').attribute('id').value,
          seller_total: item.xpath('sellerTotal').text.to_f,
          seller_total_currency: item.xpath('sellerTotal').attribute('currency').value,
          status: item.xpath('status').text,
          status_code: item.xpath('status').attribute('code').value
        )
      end

      # includes only the fields required for the requests, not the ones for the response
      def to_xml(options = {})
        builder = options[:builder] || Builder::XmlMarkup.new
        builder.instruct! if options.delete(:instruct)

        builder.purchaseOrderItem(id: id) do |b|
          b.status status
        end
      end
    end
  end
end
