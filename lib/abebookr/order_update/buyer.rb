module Abebookr
  module OrderUpdate
    class Buyer < ValueObject
      attr_accessor :id, :email, :city, :code, :country, :name, :phone, :region, :street, :street2

      def self.from_xml(buyer)
        u = Abebookr::Utils
        attrs = {}
        %w(email city code country name phone region street street2).each do |attr|
          attrs[attr.to_sym] = u.get_text(buyer, "mailingAddress/#{attr}")
        end
        attrs[:email] = u.get_text(buyer, 'email')
        attrs[:id] = u.get_attribute(buyer, 'id')

        new(attrs)
      end
    end
  end
end
