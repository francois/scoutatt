# frozen_string_literal: true

module Scoutatt
  module Actions
    module Events
      class Destroy < Scoutatt::Action
        include Deps["repos.season_repo"]
        include Deps["repos.event_repo"]

        def handle(request, response)
          event = event_repo.delete_by_slug(request.params[:slug])
          season = season_repo.find_by_id!(event.season_id)
          response.redirect_to(routes.path(:events, slug: season.slug))
        end
      end
    end
  end
end
