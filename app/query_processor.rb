require 'cgi'
require "addressable/uri"

class QueryProcessor

  def self.extract_query(path, key)
    p path
    uri = Addressable::URI.parse(path)
    uri.query_values[key]
  end
end
