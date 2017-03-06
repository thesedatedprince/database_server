require 'cgi'
require "addressable/uri"

class QueryProcessor

  def self.extract_query(path, key="test")
    uri = Addressable::URI.parse(path)
    uri.query_values[key]
  end
end
