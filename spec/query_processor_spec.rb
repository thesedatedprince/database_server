require 'spec_helper'
require_relative '../app/query_processor'

describe QueryProcessor do
  let(:queryprocessor) {QueryProcessor.new}
  context 'when receiving a path' do
    it 'extracts the query string into a key-hash pair' do
      expect(queryprocessor.extract_query('http:localhost:4000/set?key=something', 'key')).to eq 'something'
    end
  end
end
