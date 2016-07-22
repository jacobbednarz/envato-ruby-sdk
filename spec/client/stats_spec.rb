require 'spec_helper'

describe Envato::Client::Stats do
  let(:client) { Envato::Client.new(:access_token => test_api_token) }

  describe '#total_users' do
    it 'returns an integer' do
      VCR.use_cassette('client/stats/total_users') do
        expect(client.total_users).to be_a(Integer)
      end
    end
  end

  describe '#total_items' do
    it 'returns an integer' do
      VCR.use_cassette('client/stats/total_items') do
        expect(client.total_items).to be_a(Integer)
      end
    end
  end

  describe '#category_information_by_site' do
    context 'using a valid marketplace' do
      it 'returns an array of hashes' do
        VCR.use_cassette('client/stats/category_information_by_site') do
          expect(client.category_information_by_site('themeforest')).to be_a(Array)
        end
      end

      it 'contains required hash keys' do
        VCR.use_cassette('client/stats/category_information_by_site') do
          required_response_keys = %w(category number_of_files url)
          sample_category = client.category_information_by_site('themeforest').first

          required_response_keys.each do |key|
            expect(sample_category).to have_key(key.to_sym)
          end
        end
      end
    end

    context 'using an invalid marketplace' do
      it 'raises a InvalidSiteName error' do
        expect { client.category_information_by_site('notreal').to raise_error(Envato::InvalidSiteName) }
      end
    end
  end
end
