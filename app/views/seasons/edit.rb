# frozen_string_literal: true

module Scoutatt
  module Views
    module Seasons
      class Edit < Scoutatt::View
        include Deps["repos.season_repo"]

        expose :season do |slug:|
          season_repo.find_by_slug(slug)
        end
      end
    end
  end
end
