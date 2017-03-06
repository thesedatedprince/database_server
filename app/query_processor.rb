require 'cgi'
require "addressable/uri"

class QueryProcessor

  def extract_query(path, key)
    uri = Addressable::URI.parse(path)
    uri.query_values[key]
  end

end
