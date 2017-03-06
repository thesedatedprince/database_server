require 'spec_helper'

feature 'local web server' do
  context 'server is running' do
    scenario 'visit server' do
      visit '/'
      expect(page.status_code).to eq 200
    end
  end
end
