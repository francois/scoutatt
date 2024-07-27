# frozen_string_literal: true

module Scoutatt
  module Actions
    module Seasons
      class Destroy < Scoutatt::Action
        include Deps["repos.season_repo"]

        params do
          required(:slug).filled(:string)
        end

        def handle(request, response)
          season_repo.delete_by_slug!(request.params[:slug])

          response.flash[:notice] = "Saison détruite"
          response.redirect_to routes.path(:seasons)
        end
      end
    end
  end
end
