module Envato
  class Client
    module User
      def account_details
        response = get 'v1/market/private/user/account.json'
        response[:account]
      end

      def username
        response = get 'v1/market/private/user/username.json'
        response[:username]
      end

      def email_address
        response = get 'v1/market/private/user/email.json'
        response[:email]
      end

      def user_information(username)
        response = get "v1/market/user:#{username}.json"
        response[:user]
      end

      def badges_for_user(username)
        response = get "v1/market/user-badges:#{username}.json"
        response[:'user-badges']
      end

      def user_items_by_site(username)
        response = get "v1/market/user-items-by-site:#{username}.json"
        response[:'user-items-by-site']
      end

      def new_items_for_user(username, sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/new-files-from-user:#{username},#{sitename}.json"
        response[:'new-files-from-user']
      end

      def sales_per_month
        response = get 'v1/market/private/user/earnings-and-sales-by-month.json'
        response[:'earnings-and-sales-by-month']
      end

      def user_statement
        response = get 'v1/market/private/user/statement.json'
        response[:statement]
      end

      def sales(page = 1)
        raise TypeError unless page.is_a? Integer
        get "v3/market/author/sales?page=#{page}"
      end

      def sale_by_purchase_code(purchase_code)
        raise ArgumentError if purchase_code.nil?
        get "v3/market/author/sale?code=#{purchase_code}"
      end
    end
  end
end
