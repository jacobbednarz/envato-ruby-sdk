require 'spec_helper'

describe Envato::Client::Catalog do
  let(:client) { Envato::Client.new(:access_token => test_api_token) }
  let(:invalid_marketplace) { 'notarealsite' }
  let(:valid_marketplace)   { 'themeforest' }
  let(:valid_item_id)       { 13582227 }
  let(:valid_collection_id) { 5507368 }

  describe '#get_public_collection' do
    it 'returns a hash' do
      VCR.use_cassette('client/catalog/get_public_collection') do
        expect(client.get_public_collection(valid_collection_id)).to be_a(Hash)
      end
    end

    it 'includes required keys' do
      VCR.use_cassette('client/catalog/get_public_collection') do
        required_response_keys = %w(id name description private item_count image)
        public_collection = client.get_public_collection(valid_collection_id)

        required_response_keys.each do |key|
          expect(public_collection).to have_key(key)
        end
      end
    end
  end

  describe '#get_item' do
    it 'returns a hash' do
      VCR.use_cassette('client/catalog/get_item') do
        expect(client.get_item(valid_item_id)).to be_a(Hash)
      end
    end

    it 'includes all required keys' do
      VCR.use_cassette('client/catalog/get_item') do
        required_response_keys = %w(id name description site classification
          classification_url price_cents number_of_sales author_username
          author_url author_image url summary rating rating_count updated_at
          published_at trending attributes previews)
        public_collection = client.get_item(valid_item_id)

        required_response_keys.each do |key|
          expect(public_collection).to have_key(key)
        end
      end
    end

    describe 'item attributes' do
      it 'is an array' do
        VCR.use_cassette('client/catalog/get_item') do
          public_collection = client.get_item(valid_item_id)
          expect(public_collection['attributes']).to be_a(Array)
        end
      end
    end
  end

  describe '#popular_items_by_site' do
    context 'with an invalid site name' do
      it 'raises an error' do
        expect do
          client.popular_items_by_site(invalid_marketplace).to raise_error(Envato::InvalidSiteName)
        end
      end
    end

    context 'with a valid site name' do
      it 'contains expected sub hashes' do
        VCR.use_cassette('client/catalog/popular_items_by_site') do
          popular_items = client.popular_items_by_site(valid_marketplace)
          required_response_keys = %w(items_last_week authors_last_month)

          required_response_keys.each do |key|
            expect(popular_items).to have_key(key)
          end
        end
      end
    end
  end

  describe '#categories_by_site' do
    context 'with an invalid site name' do
      it 'raises an error' do
        expect do
          client.categories_by_site(invalid_marketplace).to raise_error(Envato::InvalidSiteName)
        end
      end
    end

    context 'with a valid site name' do
      it 'is an array' do
        VCR.use_cassette('client/catalog/categories_by_site') do
          categories = client.categories_by_site(valid_marketplace)
          expect(categories).to be_a(Array)
        end
      end
    end
  end

  describe '#prices_for_item' do
    it 'is an array' do
      VCR.use_cassette('client/catalog/prices_for_item') do
        expect(client.prices_for_item(valid_item_id)).to be_a(Array)
      end
    end
  end

  describe '#featured_by_site' do
    context 'with valid marketplace' do
      it 'contains required keys' do
        VCR.use_cassette('client/catalog/featured_by_site') do
          required_keys = %w(featured_file featured_author free_file)
          featured = client.featured_by_site(valid_marketplace)

          required_keys.each do |key|
            expect(featured).to have_key(key)
          end
        end
      end
    end

    context 'with invalid marketplace' do
      it 'raises an error' do
        expect do
          client.featured_by_site(invalid_marketplace).to raise_error(Envato::InvalidSiteName)
        end
      end
    end
  end

  describe '#random_new_items_by_site' do
    context 'with valid marketplace' do
      it 'contains required keys' do
        VCR.use_cassette('client/catalog/random_new_items_by_site') do
          expect(client.random_new_items_by_site(valid_marketplace)).to be_a(Array)
        end
      end
    end

    context 'with invalid marketplace' do
      it 'raises an error' do
        expect do
          client.random_new_items_by_site(invalid_marketplace).to raise_error(Envato::InvalidSiteName)
        end
      end
    end
  end
end
