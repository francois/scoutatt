# frozen_string_literal: true

module Scoutatt
  module Actions
    module Seasons
      class Update < Scoutatt::Action
        include Deps["repos.season_repo"]

        params do
          required(:slug).filled(:string)
          required(:season).hash do
            required(:title).filled(:string)
          end
        end

        def handle(request, response)
          unless request.params.valid?
            response.flash.now[:alert] = "Une ou plusieurs erreurs ont empêché cette saison d'être enregistrée"
            return
          end

          title = request.params[:season][:title]
          season_repo.update(request.params[:slug], request.params[:season])

          response.flash[:notice] = "Season #{title} mise à jour"
          response.redirect_to routes.path(:seasons)
        end
      end
    end
  end
end
