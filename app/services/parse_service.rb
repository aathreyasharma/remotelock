require_relative '../models/person'
class ParseService
  @@formats = {
    dollar_format: '$',
    percent_format: '%'
  }
  def initialize(string, type)
    @seperator = @@formats[type]
    @rows = string.split("\n")
    @columns = get_columns(@rows.shift)
  end

  def call
    @rows.map do |row|
      arr = row.split(@seperator).map(&:strip)
      attrs = Hash[@columns.zip(arr)]
      attrs[:city] = City.find(attrs[:city])
      attrs[:birthdate] = Date.parse(attrs[:birthdate])
      Person.new(attrs)
    end
  end

  def get_columns(string)
    string.split(@seperator).map(&:strip).map(&:to_sym)
  end

end
