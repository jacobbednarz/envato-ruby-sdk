module Envato
  class Client
    module Catalog
      def get_public_collection(collection_id)
        response = get "v3/market/catalog/collection?id=#{collection_id}"
        response['collection']
      end
    end
  end
end
