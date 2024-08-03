# frozen_string_literal: true

module Scoutatt
  module Actions
    module Events
      class Update < Scoutatt::Action
        include Deps["repos.season_repo"]
        include Deps["repos.event_repo"]

        params do
          required(:slug).filled(:string)
          required(:event).hash do
            required(:title).filled(:string)
            required(:max_registrations).filled(:integer, gteq?: 1, lt?: 100)
          end
        end

        def handle(request, response)
          return unless request.params.valid?

          event = event_repo.update(request.params[:slug], request.params[:event])
          season = season_repo.find_by_id!(event.season_id)
          response.redirect_to(routes.path(:events, slug: season.slug))
        end
      end
    end
  end
end
