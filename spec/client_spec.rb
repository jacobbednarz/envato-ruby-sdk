require 'spec_helper'

describe Envato::Client do
  let(:token)       { 'ThisIsNotARealToken' }
  let(:api_host)    { 'https://api.envato.com' }
  let(:api_version) { 'v1' }
  let(:client)      { described_class.new({:token => token }) }

  describe '.new' do
    it 'raises an error when the API token is missing' do
      expect { described_class.new }.to raise_error(MissingAPITokenError)
    end
  end

  describe '#inspect' do
    it 'masks the token' do
      inspected_client = client.inspect
      expect(inspected_client).not_to include(token)
    end
  end

  describe '#proxy?' do
    context 'when environment variable is defined' do
      it 'uses the defined proxy details' do
        allow(ENV).to receive(:[]).with('HTTPS_PROXY').and_return('https://somecorporateproxy.net:3128')
        expect(client.proxy?).to eq(true)
      end
    end

    context 'when environment variable is not defined' do
      it 'ignores proxy data' do
        allow(ENV).to receive(:[]).with('HTTPS_PROXY').and_return('')
        expect(client.proxy?).to eq(false)
      end
    end
  end

  describe '#conceal' do
    context 'when the string is less than 8 characters' do
      it 'hides the while string' do
        expect(client.conceal('test')).to eq('****')
      end
    end

    context 'when string is over 8 characters' do
      it 'hides everything except the first and last 4 characters' do
        expect(client.conceal('somelongsecretstring')).to eq('some****ring')
      end
    end
  end

  describe '#proxy_opts' do
    context 'when environment variable is present' do
      it 'contains the URI key' do
        allow(ENV).to receive(:[]).with('HTTPS_PROXY').and_return('https://somecorporateproxy.net:3128')
        expect(client.proxy_opts).to have_key(:uri)
      end
    end

    context 'when a environment variable is not present' do
      it { expect(client.proxy_opts).to be_nil }
    end
  end

  describe '#ssl_opts' do
    it 'performs SSL verification' do
      expect(client.ssl_opts).to have_key(:verify)
      expect(client.ssl_opts[:verify]).to eq(true)
    end
  end

  describe '#api_host' do
    it { expect(client.api_host).to be_a(String) }
  end

  describe '#api_version' do
    it { expect(client.api_version).to be_a(String) }
  end

  describe '#request' do
    context 'using GET' do
      context 'with valid JSON response' do
        it 'is a hash' do
          VCR.use_cassette('client/valid_response') do
            response = client.get 'market/total-items.json'
            expect(response).to be_a(Hash)
          end
        end
      end

      context 'with invalid JSON response' do
        it 'is a string' do
          VCR.use_cassette('client/not_found') do
            response = client.get 'non_existent_path'
            expect(response).to be_a(String)
          end
        end
      end
    end
  end
end
