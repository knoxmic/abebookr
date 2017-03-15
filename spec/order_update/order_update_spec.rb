require 'spec_helper'

describe 'OrderUpdate' do
  before :each do
    Abebookr.configure do |c|
      c.username = 'user'
      c.password = 'password'
    end
  end

  describe 'GetAllNewOrdersRequest' do
    it 'builds correct xml' do
      request = Abebookr::OrderUpdate::GetAllNewOrdersRequest.new
      expect(request.to_xml).to eq %Q|<?xml version="1.0" encoding="UTF-8"?><orderUpdateRequest version="1.0"><action name="getAllNewOrders"><username>user</username><password>password</password></action></orderUpdateRequest>|
    end
  end

  describe 'GetOrderRequest' do
    it 'builds correct xml' do
      request = Abebookr::OrderUpdate::GetOrderRequest.new(purchase_order_id: 666)
      expect(request.to_xml).to eq %Q|<?xml version="1.0" encoding="UTF-8"?><orderUpdateRequest version="1.0"><action name="getOrder"><username>user</username><password>password</password></action><purchaseOrder id="666"/></orderUpdateRequest>|
    end
  end

  describe 'PurchaseOrderItem' do
    it 'builds correct xml' do
      item = Abebookr::OrderUpdate::PurchaseOrderItem.new(id: 666, status: 'Shipped')
      expect(item.to_xml).to eq %Q|<purchaseOrderItem id="666"><status>Shipped</status></purchaseOrderItem>|
    end
  end

  describe 'Shipping' do
    it 'builds correct xml' do
      shipping = Abebookr::OrderUpdate::Shipping.new(company: 'Shipping Deluxe', tracking_code: '08/15-666')
      expect(shipping.to_xml).to eq %Q|<shipping><company>Shipping Deluxe</company><trackingCode>08/15-666</trackingCode></shipping>|
    end
  end

  describe 'UpdateRequest' do
    it 'builds correct xml for status only + shipping' do
      shipping = Abebookr::OrderUpdate::Shipping.new(company: 'Shipping Deluxe', tracking_code: '08/15-666')
      request = Abebookr::OrderUpdate::UpdateRequest.new(purchase_order_id: 666, status: 'Shipped', shipping: shipping)
      expect(request.to_xml).to eq %Q|<?xml version="1.0" encoding="UTF-8"?><orderUpdateRequest version="1.0"><action name="update"><username>user</username><password>password</password></action><purchaseOrder id="666"><status>Shipped</status>#{shipping.to_xml}</purchaseOrder></orderUpdateRequest>|
    end
    it 'builds correct xml for item list' do
      item_list = [Abebookr::OrderUpdate::PurchaseOrderItem.new(id: '0815', status: 'Shipped')]
      request = Abebookr::OrderUpdate::UpdateRequest.new(purchase_order_id: 666, purchase_order_item_list: item_list)
      expect(request.to_xml).to eq %Q|<?xml version="1.0" encoding="UTF-8"?><orderUpdateRequest version="1.0"><action name="update"><username>user</username><password>password</password></action><purchaseOrder id="666"><purchaseOrderItemList><purchaseOrderItem id="0815"><status>Shipped</status></purchaseOrderItem></purchaseOrderItemList></purchaseOrder></orderUpdateRequest>|
    end
  end

  describe 'UpdateShippingRequest' do
    it 'builds correct xml' do
      shipping = Abebookr::OrderUpdate::Shipping.new(company: 'Shipping Deluxe', tracking_code: '08/15-666')
      request = Abebookr::OrderUpdate::UpdateShippingRequest.new(purchase_order_id: 666, shipping: shipping)
      expect(request.to_xml).to eq %Q|<?xml version="1.0" encoding="UTF-8"?><orderUpdateRequest version="1.0"><action name="updateShipping"><username>user</username><password>password</password></action><purchaseOrder id="666">#{shipping.to_xml}</purchaseOrder></orderUpdateRequest>|
    end
  end

  describe 'the Response class' do
    it 'parses the example response correctly' do
      xml = File.read('spec/order_update/response.xml')
      response = Abebookr::OrderUpdate::Response.parse(xml)
      expect(response.orders.count).to eq 1
      expect(response.orders.first.purchase_order_id).to eq "1121066"
    end
  end
end
