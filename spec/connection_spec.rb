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

  describe '.get' do
    context 'with valid JSON response' do
      it 'is a hash' do
        VCR.use_cassette('client/valid_response') do
          expect(client.get('market/total-items.json')).to be_a(Hash)
        end
      end
    end

    context 'server errors' do
      it 'raise a ServerError' do
        VCR.use_cassette('client/server_error') do
          expect { client.get('market/active-threads:themeforest.net') }.to raise_error(Envato::ServerError)
        end
      end
    end

    context 'forbidden requests' do
      it 'raise a ForbiddenError' do
        VCR.use_cassette('client/forbidden') do
          # Kill off the access token we've defined to force the authentication
          # to fail.
          client.access_token = ''
          expect { client.get('market/non-existent-url') }.to raise_error(Envato::ForbiddenError)
        end
      end
    end

    context 'not found requests' do
      it 'raise a NotFoundError' do
        VCR.use_cassette('client/not_found') do
          expect { client.get('market/non-existent-url') }.to raise_error(Envato::NotFoundError)
        end
      end
    end
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
  end
end
