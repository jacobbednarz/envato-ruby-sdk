module Envato
  class Client
    module Stats
      def total_users
        response = get 'market/total-users.json'
        response['total-users']['total_users'].to_i
      end

      def total_items
        response = get 'market/total-items.json'
        response['total-items']['total_items'].to_i
      end
    end
  end
end
