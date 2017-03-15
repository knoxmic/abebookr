module Abebookr
  module OrderUpdate
    class UpdateRequest < Abebookr::OrderUpdate::Request
      attr_accessor :purchase_order_id # always required!
      attr_accessor :status, :purchase_order_item_list, :shipping # status or a list of purchaseOrderItems must be present

      def initialize(params = {})
        super(params).tap do |req|
          req.purchase_order_item_list ||= []
        end
      end

      def action
        'update'
      end

      def to_xml(options = {})
        super do |b|
          b.purchaseOrder(id: purchase_order_id) do
            b.status status unless status.nil?
            unless purchase_order_item_list.empty?
              b.purchaseOrderItemList do
                purchase_order_item_list.each do |item|
                  item.to_xml(builder: b)
                end
              end
            end
            shipping.to_xml(builder: b) if !shipping.nil? && shipping.valid?
          end
        end
      end

      def valid?
        return false if purchase_order_id.nil?
        if status.nil? # all items must have an individual status field
          return false if purchase_order_item_list.empty?
          return false if purchase_order_item_list.map(&:status).any? { |status| !Constants.order_statuses.include?(status) }
        else
          return false if !Constants.order_statuses.include?(status)
          return false if !purchase_order_item_list.empty?
        end
        true
      end
    end
  end
end
