# frozen_string_literal: true

module Scoutatt
  module Actions
    module Events
      class Index < Scoutatt::Action
        params do
          required(:slug).filled(:string)
        end

        def handle(request, response)
          response.render(view, slug: request.params[:slug])
        end
      end
    end
  end
end
