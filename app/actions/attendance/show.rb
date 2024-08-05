# frozen_string_literal: true

module Scoutatt
  module Actions
    module Attendance
      class Show < Scoutatt::Action
        params do
          required(:event_slug).filled(:string)
        end

        def handle(request, response)
          return unless request.params.valid?

          response.render(view, slug: request.params[:event_slug])
        end
      end
    end
  end
end
