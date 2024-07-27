# frozen_string_literal: true

module Scoutatt
  module Actions
    module Seasons
      class Create < Scoutatt::Action
        include Deps["repos.season_repo"]

        params do
          required(:season).hash do
            required(:title).filled(:string)
          end
        end

        def handle(request, response)
          unless request.params.valid?
            response.flash.now[:alert] = "Une ou plusieurs erreurs ont empêché cette saison d'être enregistrée"
            # Implicitly re-renders the "new" view
            return
          end

          title = request.params[:season][:title]
          season_repo.create(title:, timezone: "America/New_York")

          response.flash[:notice] = "Saison #{title} enregistrée"
          response.redirect_to routes.path(:seasons)
        end
      end
    end
  end
end
