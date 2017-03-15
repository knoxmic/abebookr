module Abebookr
  class ValueObject
    def initialize(params = {})
      params.each do |k,v|
        self.send("#{k}=", v) if self.respond_to?(k)
      end
    end
  end
end
