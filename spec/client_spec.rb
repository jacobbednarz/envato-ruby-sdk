require 'spec_helper'

describe Envato::Client do
  let(:api_host) { 'https://api.envato.com' }
  let(:client)   { described_class.new(:access_token => test_api_token) }

  describe '.new' do
    it 'raises an error when the API access token is missing' do
      expect { described_class.new }.to raise_error(Envato::MissingAPITokenError)
    end
  end

  describe '#inspect' do
    it 'masks the access token' do
      inspected_client = client.inspect
      expect(inspected_client).not_to include(test_api_token)
    end
  end

  describe '#conceal' do
    context 'when the string is less than 8 characters' do
      it 'hides the whole string' do
        expect(client.conceal('test')).to eq('****')
      end
    end

    context 'when string is over 8 characters' do
      it 'hides everything except the first and last 4 characters' do
        expect(client.conceal('somelongsecretstring')).to eq('some****ring')
      end
    end
  end
end
