module Abebookr
  module OrderUpdate
    class Book < Abebookr::ValueObject

      attr_accessor :id, :author, :description, :price, :price_currency, :title, :vendor_key

      def self.from_xml(book)
        new(
          id: book.attribute('id').value,
          author: book.xpath('author').text,
          description: book.xpath('description').text,
          price: book.xpath('price').text.to_f,
          price_currency: book.xpath('price').attribute('currency').value,
          title: book.xpath('title').text,
          vendor_key: book.xpath('vendorKey').text
        )
      end
    end
  end
end
