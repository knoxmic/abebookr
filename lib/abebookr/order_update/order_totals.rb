require 'abebookr/value_object'
module Abebookr
  module OrderUpdate
    class OrderTotals < Abebookr::ValueObject

      attr_accessor :gst, :gst_currency, :handling, :handling_currency, :shipping, :shipping_currency, :subtotal,
                    :subtotal_currency, :tax, :tax_currency, :total, :total_currency

      def self.from_xml(order_totals)
        u = Abebookr::Utils
        attrs = {}
        %w(handling gst shipping subtotal tax total).each do |attr|
          attrs[attr.to_sym] = u.get_float(order_totals, attr)
          attrs["#{attr}_currency"] = u.get_attribute(order_totals, 'currency', attr)
        end
        new(attrs)
      end
    end
  end
end
