module Envato
  class Client
    module User
      # Get current logged in user account information.
      #
      # @see https://build.envato.com/api/#market_Account
      #
      # @example Fetching account details.
      #   @client.account_details
      #
      # @return [Hash] User details.
      def account_details
        response = get 'v1/market/private/user/account.json'
        response[:account]
      end

      # Return the current logged in username.
      #
      # @see https://build.envato.com/api/#market_Username
      #
      # @example Get logged in user username.
      #   @client.username
      #
      # @return [String] Current logged in username.
      def username
        response = get 'v1/market/private/user/username.json'
        response[:username]
      end

      # Return the current logged in email address.
      #
      # @see https://build.envato.com/api/#market_Email
      #
      # @example Get logged in user email address.
      #   @client.email_address
      #
      # @return [String] Current logged in email address.
      def email_address
        response = get 'v1/market/private/user/email.json'
        response[:email]
      end

      # Retrieve information about a user.
      #
      # @see https://build.envato.com/api/#market_User
      #
      # @example Getting information about a username 'jacob'.
      #   @client.user_information('jacob')
      # @param username [String] Username of the user.
      # @return [Hash] Information about the requested username.
      def user_information(username)
        response = get "v1/market/user:#{username}.json"
        response[:user]
      end

      # Find badges for a user.
      #
      # @see https://build.envato.com/api/#market_UserBadges
      #
      # @example Retrieving badges for user 'jacob'.
      #   @client.badges_for_user('jacob')
      #
      # @param username [String] Username of the user.
      # @return [Array] Hashes of badge data for the user.
      def badges_for_user(username)
        response = get "v1/market/user-badges:#{username}.json"
        response[:'user-badges']
      end

      # Find items by a single user based on marketplace.
      #
      # @see https://build.envato.com/api/#market_UserItemsBySite
      #
      # @example Finding items by username 'jacob'.
      #   @client.user_items_by_site('jacob')
      #
      # @param username [String] Username of the user.
      # @return [Array] Hashes of marketplace => item count for all
      #   marketplaces.
      def user_items_by_site(username)
        response = get "v1/market/user-items-by-site:#{username}.json"
        response[:'user-items-by-site']
      end

      # Find all new items for user based on a marketplace.
      #
      # @see https://build.envato.com/api/#market_NewFilesFromUser
      #
      # @example Finding new items for username 'jacob' on themeforest.net.
      #   @client.new_items_for_user('jacob', 'themeforest')
      #
      # @param username [String] Username of the user.
      # @param sitename [String] Marketplace name.
      # @raise [Envato::InvalidSiteName] If marketplace name is not valid.
      # @return [Array] Inner hashes of the item information.
      def new_items_for_user(username, sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/new-files-from-user:#{username},#{sitename}.json"
        response[:'new-files-from-user']
      end

      # Breakdown a users sales based on month.
      #
      # @see https://build.envato.com/api/#market_EarningsAndSalesByMonth
      #
      # @example Getting sales per month.
      #   @client.sales_per_month
      #
      # @return [Hash] Month => value of sales.
      def sales_per_month
        response = get 'v1/market/private/user/earnings-and-sales-by-month.json'
        response[:'earnings-and-sales-by-month']
      end

      # Get the current user statement.
      #
      # @see https://build.envato.com/api/#market_Statement
      #
      # @example Fetching user statement.
      #   @client.user_statement
      #
      # @return [Array] Individual hashes of line entries for each type of
      #   activity.
      def user_statement
        response = get 'v1/market/private/user/statement.json'
        response[:statement]
      end

      # Retrieve logged in author sales.
      #
      # @see https://build.envato.com/api/#market_0_Author_Sales
      #
      # @example Finding sales data on page 2.
      #   @client.sales(2)
      #
      # @param page [Integer] Page number to view sales data for.
      # @raise [TypeError] If the reqested page number is not an integer.
      # @return [Array] With inner hashes of sales data based on months.
      def sales(page = 1)
        raise TypeError unless page.is_a? Integer
        get "v3/market/author/sales?page=#{page}"
      end

      # Get sale based on purchase code.
      #
      # @see https://build.envato.com/api/#market_0_Author_Sale
      #
      # @example Retrieving sale by purchase code '1234-5678-90ab-cdef'
      #   @client.sale_by_purchase_code('1234-5678-90ab-cdef')
      #
      # @param purchase_code [String] Purchase code of the sale.
      # @raise [ArgumentError] If the purchase code isn't provided.
      # @return [Hash] Purchase information.
      def sale_by_purchase_code(purchase_code)
        raise ArgumentError if purchase_code.nil?
        get "v3/market/author/sale?code=#{purchase_code}"
      end
    end
  end
end
