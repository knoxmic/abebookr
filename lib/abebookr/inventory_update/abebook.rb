module Abebookr
  module InventoryUpdate
    class Abebook < Abebookr::ValueObject
      # All attributes are cased as in the API.
      attr_accessor :transaction_type, :vendor_book_id, :author, :title, :publisher, :subject, :price, :currency,
                    :dust_jacket, :binding_material, :binding_type, :first_edition, :signed, :bookseller_catalogue,
                    :description, :book_condition, :size, :jacket_condition, :book_type, :isbn, :publish_place,
                    :publish_year, :edition, :inscription_type, :quantity

      # These are used in the API Response, together with transaction_type and vendor_book_id
      attr_accessor :code, :message

      def to_xml(options = {})
        b = options[:builder]
        b.Abebook do
          b.transactionType transaction_type
          b.vendorBookID vendor_book_id
          unless transaction_type.downcase.to_sym == :delete
            b.author author
            b.title title
            b.publisher publisher
            b.subject subject
            b.price(price, currency: currency)
            b.dustJacket dust_jacket
            b.binding(binding_material, type: binding_type)
            b.firstEdition first_edition
            b.signed signed
            b.booksellerCatalogue bookseller_catalogue
            b.description description
            b.bookCondition book_condition
            b.size size
            b.jacketCondition jacket_condition
            b.bookType book_type
            b.isbn isbn
            b.publishPlace publish_place
            b.publishYear publish_year
            b.edition edition
            b.inscriptionType inscription_type
            b.quantity(limit: 1) if quantity == -1
            b.quantity(amount: quantity) if quantity >= 0
          end
        end
      end
    end
  end
end
