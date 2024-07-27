# frozen_string_literal: true

module Scoutatt
  module Views
    module Seasons
      class Index < Scoutatt::View
        include Deps["repos.season_repo"]

        expose :seasons do
          season_repo.all_by_title
        end
      end
    end
  end
end
