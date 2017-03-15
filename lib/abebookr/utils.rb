module Abebookr
  class Utils
    def self.order_date_to_datetime(orderDate)
      day = get_int(orderDate, 'date/day')
      month = get_int(orderDate, 'date/month')
      year = get_int(orderDate, 'date/year')
      hour = get_int(orderDate, 'time/hour')
      minute = get_int(orderDate, 'time/minute')
      second = get_int(orderDate, 'time/second')

      Time.new(year, month, day, hour, minute, second)
    end

    def self.get_int(xml, xpath)
      xml.xpath(xpath).text.to_i
    end

    def self.get_float(xml, xpath)
      xml.xpath(xpath).text.to_f
    end

    def self.get_text(xml, xpath)
      xml.xpath(xpath).text
    end

    def self.get_attribute(xml, attribute, xpath = nil)
      if xpath.nil?
        xml.attribute(attribute).value
      else
        xml.xpath(xpath).attribute(attribute).value
      end
    end
  end
end
