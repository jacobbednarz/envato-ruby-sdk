module Envato
  class Client
    module User
      def account_details
        response = get 'v1/market/private/user/account.json'
        response['account']
      end

      def username
        response = get 'v1/market/private/user/username.json'
        response['username']
      end

      def email_address
        response = get 'v1/market/private/user/email.json'
        response['email']
      end

      def user_information(username)
        response = get "v1/market/user:#{username}.json"
        response['user']
      end

      def badges_for_user(username)
        response = get "v1/market/user-badges:#{username}.json"
        response['user-badges']
      end

      def user_items_by_site(username)
        response = get "v1/market/user-items-by-site:#{username}.json"
        response['user-items-by-site']
      end

      def new_items_for_user(username, sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/new-files-from-user:#{username},#{sitename}.json"
        response['new-files-from-user']
      end
    end
  end
end
