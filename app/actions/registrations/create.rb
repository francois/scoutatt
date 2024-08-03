# frozen_string_literal: true

module Scoutatt
  module Actions
    module Registrations
      class Create < Scoutatt::Action
        include Deps["views.seasons.show"]
        include Deps["repos.season_repo"]
        include Deps["repos.event_repo"]
        include Deps["repos.registration_repo"]

        params do
          required(:slug).filled(:string)
          required(:registration).hash do
            required(:email).filled(:string)
            required(:events).array(:hash) do
              required(:event_id).filled(:string)
              required(:name).maybe(:string)
              required(:role).maybe(:string)
            end
          end
        end

        def handle(request, response)
          return unless request.params.valid?

          # Side-effect: validates the existence of the season slug
          season_repo.find_by!(slug: request.params[:slug])

          notification_email = request.params[:registration][:email]
          event_ids_by_slug = event_repo.event_ids_by_slug
          events = request.params[:registration][:events]
            .select { _1[:name] }
            .map { _1.merge(event_id: event_ids_by_slug.fetch(_1[:event_id]), notification_email:) }
          registration_repo.create_many(events)

          response.flash[:notice] = "#{events.size} présences enregistrées"
          response.redirect_to(routes.path(:seasons))
        end
      end
    end
  end
end
