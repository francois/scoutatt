# frozen_string_literal: true

module Scoutatt
  module Actions
    module Seasons
      class Show < Scoutatt::Action
        def handle(request, response)
          response.render(view, slug: request.params[:slug])
        end
      end
    end
  end
end
