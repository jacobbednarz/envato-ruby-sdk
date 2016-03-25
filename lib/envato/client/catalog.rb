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

    end
  end
end
