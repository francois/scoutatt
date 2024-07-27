# frozen_string_literal: true

module Scoutatt
  module Actions
    module Seasons
      class Index < Scoutatt::Action
        def handle(request, response)
          response.render(
            view,
            page: request.params[:page] || 1,
            per_page: request.params[:per_page] || 25
          )
        end
      end
    end
  end
end
