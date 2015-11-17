module Envato
  class Error < StandardError; end

  # User is missing the required API token.
  class MissingAPITokenError < ArgumentError; end

  # Handle the HTTP statuses correctly.
  class ForbiddenError < Error; end
  class NotFoundError < Error; end
  class ClientError < Error; end
  class ServerError < Error; end

  # Validation of Envato marketplaces.
  class InvalidSiteName < Error; end
  class InvalidSiteDomain < Error; end
end
