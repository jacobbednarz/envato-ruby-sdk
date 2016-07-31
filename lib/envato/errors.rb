module Envato
  class Error < StandardError; end

  # User is missing the required API token.
  class MissingAPITokenError < ArgumentError; end

  # Request received a HTTP 403 response.
  class ForbiddenError < Error; end

  # Request received a HTTP 404 response.
  class NotFoundError < Error; end

  # Request received a HTTP 4xx response.
  class ClientError < Error; end

  # Request received a HTTP 5xx response.
  class ServerError < Error; end

  # Validation against whitelisted marketplace names.
  class InvalidSiteName < Error; end

  # Validation against whitelisted marketplace domains.
  class InvalidSiteDomain < Error; end
end
