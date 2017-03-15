module Abebookr
  module OrderUpdate
    module Constants
      def self.order_statuses
        %w(Shipped Rejected PreviouslySold)
      end
    end
  end
end
