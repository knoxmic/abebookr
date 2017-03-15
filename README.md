# Abebookr

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'abebookr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install abebookr

## Usage

Currently, only the OrderUpdate API is supported. InventoryUpdate API is still Work In Progress.

### Examples

Before using the gem you need to configure your Abebooks credentials:
```ruby
Abebookr.configure do |c|
  c.username = ENV['ABEBOOKS_USER']
  c.password = ENV['ABEBOOKS_PASSWORD']
end
```

In Rails you can put this into an initializer.

#### Get all new orders
```ruby
request = Abebookr::OrderUpdate::GetAllNewOrdersRequest.new
response = request.perform

orders = request.orders # returns an Array of Abebookr::OrderUpdate::PurchaseOrder objects
```

#### Get a specific order
```ruby
request = Abebookr::OrderUpdate::GetOrderRequest.new(
  purchase_order_id: 'ABEBOOKS_ORDER_ID'
)
response = request.perform

# the response always returns an array of Abebookr::OrderUpdate::PurchaseOrder objects,
# even if there is only one order.
order = response.orders.first
```

#### Update an order, setting all it's item's status to shipped
```ruby
request = Abebookr::OrderUpdate::UpdateRequest.new(
  purchase_order_id: 'ABEBOOKS_ORDER_ID',
  status: 'Shipped'
)
response = request.perform

order = response.orders.first # response.orders will contain the updated order
```

You can add shipping information to this request:

```ruby
shipping = Abebookr::OrderUpdate::Shipping.new(
  company: 'ShippingCompany',
  tracking_code: 'TrackingCode0815'
)

request = Abebookr::OrderUpdate::UpdateRequest.new(
  purchase_order_id: 'ABEBOOKS_ORDER_ID',
  status: 'Shipped',
  shipping: shipping
)
response = request.perform

order = response.orders.first
```

Please refer to the [Abebooks API Documentation](http://www.abebooks.com/docs/seller-help/order-update-api-user-guide.pdf) for information about the possible values for the `status` parameter.

#### Update an order, assigning different status values to each book

If you want to assign different status values to the individual items of the order, you can do so!
In the following example, the offer has two items. Shipping is ignored in this example, but can be added as well.

```ruby
# this book is being processed and shipped
item1 = Abebookr::OrderUpdate::PurchaseOrderItem.new(
  id: 'ABEBOOKS_ITEM_ID_1',
  status: 'Shipped'
)

# this book has been sold to another customer (via Amazon Marketplace for example) and can no longer be sold
item2 = Abebookr::OrderUpdate::PurchaseOrderItem.new(
  id: 'ABEBOOKS_ITEM_ID_2',
  status: 'PreviouslySold'
)

request = Abebookr::OrderUpdate::UpdateRequest.new(
  purchase_order_id: 'ABEBOOKS_ORDER_ID',
  purchase_order_item_list: [item1, item2]
)
response = request.perform

order = response.orders.first
```

**NOTE 1:** Update Requests must either contain a single status for all books, as seen above, or for every book individually. Otherwise, the request will fail.

**NOTE 2:** Once updated, an offer can no longer be given another status value! Only shipping information can be added later (see below).

#### Add shipping information to an already updated offer
Sometimes, you can not get a tracking code in time, so offers can be marked as `shipped` without tracking information present.
Tracking Information can be added later on with the following request:

```ruby
shipping = Abebookr::OrderUpdate::Shipping.new(
  company: 'Some Company',
  tracking_code: 'TrackingCode0815'
)

request = Abebookr::OrderUpdate::UpdateShippingRequest.new(
  purchase_order_id: 'ABEBOOKS_ORDER_ID',
  shipping: shipping
)
request.perform
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/abebookr.

