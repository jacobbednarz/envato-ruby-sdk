require 'spec_helper'

describe Envato::Client::User do
  let(:client) { Envato::Client.new(:access_token => test_api_token) }

  describe '#account_details' do
    it 'contains required hash keys' do
      VCR.use_cassette('client/user/account_details') do
        required_account_keys = %w(image firstname surname available_earnings total_deposits balance country)
        account_details = client.account_details

        required_account_keys.each do |key|
          expect(account_details).to have_key(key)
        end
      end
    end
  end

  describe '#username' do
    it 'is a string' do
      VCR.use_cassette('client/user/username') do
        expect(client.username).to be_a(String)
      end
    end
  end

  describe '#email_address' do
    it 'is a string' do
      VCR.use_cassette('client/user/email') do
        expect(client.email_address).to be_a(String)
      end
    end
  end

  describe '#user_information' do
    it 'contains required hash keys' do
      VCR.use_cassette('client/user/user_information') do
        required_user_keys = %w(username country sales location image followers)
        user_information = client.user_information 'collis'

        required_user_keys.each do |key|
          expect(user_information).to have_key(key)
        end
      end
    end

    it 'returns the image over HTTPS' do
      VCR.use_cassette('client/user/user_information') do
        user_information = client.user_information 'collis'
        expect(user_information['image']).to start_with 'https://'
      end
    end
  end

  describe '#badges_for_user' do
    let(:user_badges) do
      VCR.use_cassette('client/user/badges_for_user') do
        client.badges_for_user 'collis'
      end
    end

    it { expect(user_badges).to be_a(Array) }

    it 'contains the required hash keys' do
      required_badge_keys = %w(name label image)
      user_badge = user_badges.first

      required_badge_keys.each do |key|
        expect(user_badge).to have_key(key)
      end
    end
  end

  describe '#user_items_by_site' do
    let(:no_items_user) do
      VCR.use_cassette('client/user/user_items_by_site/user_does_not_have_items') do
        client.user_items_by_site 'johnsyweb'
      end
    end

    let(:user_with_items) do
      VCR.use_cassette('client/user/user_items_by_site/user_has_items') do
        client.user_items_by_site 'collis'
      end
    end

    context 'when a user has no items' do
      it { expect(no_items_user).to be_a(Array) }
      it { expect(no_items_user).to be_empty }
    end

    context 'when a user has items' do
      it { expect(user_with_items).to be_a(Array) }
      it { expect(user_with_items).not_to be_empty }

      it 'includes required hash keys' do
        required_item_keys = %w(site items)
        items_by_site = user_with_items.first

        required_item_keys.each do |key|
          expect(items_by_site).to have_key(key)
        end
      end
    end
  end

  describe '#new_items_for_user' do
    let(:valid_username_with_no_items) { 'johnsyweb' }
    let(:valid_username_with_items)    { 'collis' }
    let(:invalid_username)             { 'lolololololololoooloooll' }
    let(:valid_marketplace)            { 'themeforest' }
    let(:invalid_marketplace)          { 'notarealone' }
    let(:valid_request_with_no_items) do
       VCR.use_cassette('client/user/new_items_by_user/valid_username_with_no_items_and_valid_marketplace') do
        client.new_items_for_user(valid_username_with_no_items, valid_marketplace)
      end
    end
    let(:valid_request_with_items) do
      VCR.use_cassette('client/user/new_items_by_user/valid_username_with_items_and_valid_marketplace') do
        client.new_items_for_user(valid_username_with_items, valid_marketplace)
      end
    end
    let(:invalid_username_and_valid_marketplace_request) do
      VCR.use_cassette('client/user/new_items_by_user/invalid_username_and_valid_marketplace') do
        client.new_items_for_user(invalid_username, valid_marketplace)
      end
    end
    let(:invalid_username_and_invalid_marketplace_request) do
      VCR.use_cassette('client/user/new_items_by_user/invalid_username_and_invalid_marketplace') do
        client.new_items_for_user(invalid_username, invalid_marketplace)
      end
    end

    context 'with a valid marketplace' do
      context 'with a valid username with no items' do
        it { expect(valid_request_with_no_items).to be_a(Array) }
        it { expect(valid_request_with_no_items).to be_empty }
      end

      context 'with a valid username with many items' do
        it { expect(valid_request_with_items).to be_a(Array) }
        it { expect(valid_request_with_items).not_to be_empty }

        it 'includes required hash keys' do
          required_item_keys = %w(id item url user thumbnail sales rating rating_decimal cost uploaded_on last_update tags category live_preview_url)
          new_item_by_user   = valid_request_with_items.first

          required_item_keys.each do |key|
            expect(new_item_by_user).to have_key(key)
          end
        end
      end

      context 'with an invalid_username' do
        it 'raises a ForbiddenError exception' do
          expect { invalid_username_and_valid_marketplace_request.to raise_error(Envato::ForbiddenError) }
        end
      end
    end

    context 'with an invalid marketplace' do
      context 'with a valid username' do
        it 'raises a InvalidSiteName exception' do
          expect { client.new_items_for_user(valid_username, invalid_marketplace).to raise_error(Envato::InvalidSiteName) }
        end
      end

      context 'with an invalid username' do
        it 'raises a InvalidSiteName exception' do
          expect { client.new_items_for_user(invalid_username, invalid_marketplace).to raise_error(Envato::InvalidSiteName) }
        end
      end
    end
  end

  describe '#author_sales_per_month' do
    let(:author_with_sales_request) do
      VCR.use_cassette('client/user/author_sales_per_month/with_sales') do
       client.author_sales_per_month
      end
    end

    context 'with no sales' do
      it 'returns an empty array' do
        VCR.use_cassette('client/user/author_sales_per_month/no_sales') do
          response = client.author_sales_per_month
          expect(response).to be_a(Array)
        end
      end
    end

    context 'with sales' do
      it 'response is an array' do
        expect(author_with_sales_request).to be_a(Array)
      end

      it 'is not empty' do
        expect(author_with_sales_request).to_not be_empty
      end

      it 'has required keys' do
        required_keys = %w(month earnings sales)
        required_keys.each do |key|
          expect(author_with_sales_request.first).to have_key(key)
        end
      end
    end
  end

  describe '#user_statement' do
    let(:user_statement_with_activity) do
      VCR.use_cassette('client/user/user_statement/user_statement_with_activity') do
       client.user_statement
      end
    end

    context 'with no activity' do
      it 'returns an array' do
        VCR.use_cassette('client/user/user_statement/user_statement_with_no_events') do
          expect(client.user_statement).to be_a(Array)
        end
      end
    end

    context 'with activity' do
      it 'is an array' do
        expect(user_statement_with_activity).to be_a(Array)
      end

      it 'is not empty' do
        expect(user_statement_with_activity).to_not be_empty
      end

      it 'has required keys' do
        required_keys = %w(kind amount description occured_at)
        required_keys.each do |key|
          expect(user_statement_with_activity.first).to have_key(key)
        end
      end
    end
  end

  describe '#sales' do
    let(:valid_sales_request) do
      VCR.use_cassette('client/user/sales/valid_sales') do
        client.sales(1)
      end
    end

    context 'with invalid page number' do
      it 'raises a TypeError exception' do
        expect { client.sales('notarealone') }.to raise_error(TypeError)
      end
    end

    context 'using valid page number' do
      it 'returns an array' do
        expect(valid_sales_request).to be_a(Array)
      end

      it 'has required keys' do
        required_keys = %w(amount sold_at item license support_amount supported_until)
        required_keys.each do |key|
          expect(valid_sales_request.first).to have_key(key)
        end
      end

      it 'item key is a hash of details' do
        expect(valid_sales_request.first['item']).to be_a(Hash)
      end
    end
  end
end
