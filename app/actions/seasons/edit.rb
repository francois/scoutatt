# frozen_string_literal: true

module Scoutatt
  module Actions
    module Seasons
      class Edit < Scoutatt::Action
        handle_exception ROM::TupleCountMismatchError => :handle_not_found

        def handle(request, response)
          response.render(view, slug: request.params[:slug])
        end

        def handle_not_found(request, response, exception)
          response.status = 404
          response.format = :html
          response.body = "Not Found"
        end
      end
    end
  end
end
