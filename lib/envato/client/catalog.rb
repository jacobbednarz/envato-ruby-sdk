module Envato
  class Client
    module Catalog
      def get_public_collection(collection_id)
        response = get "v3/market/catalog/collection?id=#{collection_id}"
        response['collection']
      end

      def get_item(item_id)
        get "v3/market/catalog/item?id=#{item_id}"
      end

      def popular_items_by_site(sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/popular:#{sitename}.json"
        response['popular']
      end

      def categories_by_site(sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        response = get "v1/market/categories:#{sitename}.json"
        response['categories']
      end

    end
  end
end
