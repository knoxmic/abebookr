require 'abebookr/value_object'
module Abebookr
  module OrderUpdate
    class PurchaseOrder < Abebookr::ValueObject
      attr_accessor :purchase_order_id, :buyer, :domain, :domain_id, :order_date, :order_totals, :purchase_method, :purchase_order_item_list,
                    :reseller, :reseller_id, :shipment_manifest, :seller_id, :shipping, :special_instructions,
                    :status, :status_code

      def self.from_xml(order)
        u = Abebookr::Utils
        new(
          purchase_order_id:        u.get_attribute(order, 'id'),
          buyer:                    Buyer.from_xml(order.xpath('buyer')),
          domain:                   u.get_text(order, 'domain/name'),
          domain_id:                u.get_attribute(order, 'id', 'domain'),
          order_date:               u.order_date_to_datetime(order.xpath('orderDate')),
          order_totals:             OrderTotals.from_xml(order.xpath('orderTotals')),
          purchase_method:          u.get_text(order, 'purchaseMethod'),
          purchase_order_item_list: order.xpath('purchaseOrderItemList').children.map { |item| PurchaseOrderItem.from_xml(item) },
          reseller:                 u.get_text(order, 'reseller/name'),
          reseller_id:              u.get_attribute(order, 'id', 'reseller'),
          seller_id:                u.get_attribute(order, 'id', 'seller'),
          shipment_manifest:        u.get_text(order, 'shipmentManifest'),
          shipping:                 Shipping.from_xml(order.xpath('shipping')),
          special_instructions:     u.get_text(order, 'specialInstructions'),
          status:                   u.get_text(order, 'status'),
          status_code:              u.get_attribute(order, 'code', 'status')
        )
      end
    end
  end
end
