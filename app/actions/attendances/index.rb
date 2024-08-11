# frozen_string_literal: true

module Scoutatt
  module Actions
    module Attendances
      class Index < Scoutatt::Action
        EIGHT_HOURS_IN_SECONDS = 8 * 60 * 60
        FORTY_EIGHT_HOURS_IN_SECONDS = 48 * 60 * 60

        def handle(request, response)
          response.render(view, season_slug: request.params[:season_slug],
            timespan: eight_hours_ago...forty_eight_hours_from_now)
        end

        private

        def eight_hours_ago = Time.now - EIGHT_HOURS_IN_SECONDS

        def forty_eight_hours_from_now = Time.now + FORTY_EIGHT_HOURS_IN_SECONDS
      end
    end
  end
end
