module Abebookr
  module OrderUpdate
    class Shipping < Abebookr::ValueObject
      attr_accessor :company, :tracking_code # required for request
      attr_accessor :extra_item_shipping_cost, :extra_item_shipping_cost_currency, :first_item_shipping_cost, # present in response
                    :first_item_shipping_cost_currency, :maxDeliveryDays, :minDeliveryDays

      def self.from_xml(shipping)
        new(
          company: shipping.xpath('company').text,
          trackingCode: shipping.xpath('trackingCode').text,
          extra_item_shipping_cost: shipping.xpath('extraItemShippingCost').text.to_f,
          extra_item_shipping_cost_currency: shipping.xpath('extraItemShippingCost').attribute('currency').value,
          first_item_shipping_cost: shipping.xpath('firstItemShippingCost').text.to_f,
          first_item_shipping_cost_currency: shipping.xpath('firstItemShippingCost').attribute('currency').value,
          max_delivery_days: shipping.xpath('maxDeliveryDays').text.to_i,
          min_delivery_days: shipping.xpath('minDeliveryDays').text.to_i
        )
      end

      # includes only the required fields for the request
      def to_xml(options = {})
        builder = options[:builder] || Builder::XmlMarkup.new
        builder.instruct! if options.delete(:instruct)

        builder.shipping do |b|
          b.company company
          b.trackingCode tracking_code
        end
      end

      def valid?
        !company.nil? && !tracking_code.nil?
      end
    end
  end
end
