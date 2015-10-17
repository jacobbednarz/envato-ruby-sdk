require 'spec_helper'

describe Envato::Connection do
  let(:client) { Envato::Client.new(:access_token => test_api_token) }

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
    let(:client_with_proxy) do
      Envato::Client.new(
        :access_token => test_api_token,
        :proxy => {
          :uri      => 'https://someproxy.net',
          :user     => 'foo',
          :password => 'bar'
        })
    end

    context 'when proxy is defined' do
      it 'has required proxy keys' do
        expect(client_with_proxy.proxy).to have_key(:uri)
        expect(client_with_proxy.proxy).to have_key(:user)
        expect(client_with_proxy.proxy).to have_key(:password)
      end
    end

    context 'HTTP GET' do
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
