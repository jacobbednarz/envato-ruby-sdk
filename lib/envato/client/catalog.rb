module Envato
  class Client
    module Catalog
      # Fetch a public collection based on a collection ID.
      #
      # @see https://build.envato.com/api/#market_0_Catalog_Collection
      #
      # @example Finding public collection 12345
      #   @client.get_public_collection(12345)
      #
      # @param collection_id [Integer] Collection ID.
      # @return [Hash] Collection information.
      def get_public_collection(collection_id)
        response = get "v3/market/catalog/collection?id=#{collection_id}"
        response[:collection]
      end

      # Find an item based on ID.
      #
      # @see https://build.envato.com/api/#market_0_Catalog_Item
      #
      # @example Getting item with ID 1234.
      #   @client.get_item(1234)
      #
      # @param item_id [Integer] Item ID.
      # @return [Hash] Item details.
      def get_item(item_id)
        get "v3/market/catalog/item?id=#{item_id}"
      end

      # Get all popular items based on a site.
      #
      # @see https://build.envato.com/api/#market_Popular
      #
      # @example Popular item from themeforest.net
      #   @client.popular_items_by_site('themeforest')
      #
      # @param sitename [String] Marketplace domain to look up.
      # @raise [Envato::InvalidSiteName] If marketplace name is not valid.
      # @return [Hash] All items which have been marked as popular for the
      #   requested marketplace.
      def popular_items_by_site(sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/popular:#{sitename}.json"
        response[:popular]
      end

      # Returns all categories for a marketplace.
      #
      # @see https://build.envato.com/api/#market_Categories
      #
      # @example Find all categories for themeforest.net
      #   @client.categories_by_site('themeforest')
      #
      # @param sitename [String] Marketplace name.
      # @raise [Envato::InvalidSiteName] If marketplace name is not valid.
      # @return [Hash] All categories for the requested marketplace.
      def categories_by_site(sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/categories:#{sitename}.json"
        response[:categories]
      end

      # Get all pricing types for a single item.
      #
      # @see https://build.envato.com/api/#market_ItemPrices
      #
      # @example Find all prices for item 1234.
      #   @client.prices_for_item(1234)
      #
      # @param item_id [Integer] Item ID.
      # @return [Hash] Keyed by license type and price for that license.
      def prices_for_item(item_id)
        response = get "v1/market/item-prices:#{item_id}.json"
        response[:'item-prices']
      end

      # Get featured item and author by site.
      #
      # @see https://build.envato.com/api/#market_Features
      #
      # @example See all featured items for themeforest.net
      #   @cilent.featured_by_site('themeforest')
      #
      # @param sitename [String] Name of marketplace.
      # @raise [Envato::InvalidSiteName] If marketplace name is not valid.
      # @return [Hash] Includes the 'featured_author' and 'featured_file' keys
      #   which have the associated inner details of the respective information.
      def featured_by_site(sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/features:#{sitename}.json"
        response[:features]
      end

      # Retrieve random new files based on marketplace.
      #
      # @see https://build.envato.com/api/#market_RandomNewFiles
      #
      # @example Random new files for themeforest.net
      #   @client.random_new_items_by_site('themeforest')
      #
      # @param sitename [String] Marketplace name.
      # @raise [Envato::InvalidSiteName] If marketplace name is not valid.
      # @return [Array] With inner hashes of the item information.
      def random_new_items_by_site(sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/random-new-files:#{sitename}.json"
        response[:'random-new-files']
      end
    end
  end
end
