require 'faraday'
require 'active_collab/error'

module ActiveCollab

  # Methods for handling responses from ActiveCollab.
  module Response

    # Middleware for detecting errors from response codes and bodies.
    class RaiseError < Faraday::Response::Middleware
      def on_complete(env)
        status_code = env[:status]
        body = env[:body]

        error = ActiveCollab::Error.from_status_code_and_body(status_code, body)
        fail error if error
      end
    end
  end
end