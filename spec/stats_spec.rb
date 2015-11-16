require 'spec_helper'

describe Envato::Client::Stats do
  let(:client) { Envato::Client.new(:access_token => test_api_token) }

  describe '#total_items' do
    it 'returns an integer' do
      VCR.use_cassette('client/stats/total_items') do
        expect(client.total_items).to be_a(Integer)
      end
    end
  end

  describe '#total_users' do
    it 'returns an integer' do
      VCR.use_cassette('client/stats/total_users') do
        expect(client.total_users).to be_a(Integer)
      end
    end
  end
end
