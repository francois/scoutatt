# frozen_string_literal: true

module Scoutatt
  module Views
    module Seasons
      class Show < Scoutatt::View
        include Deps["repos.season_repo"]
        include Deps["repos.event_repo"]
        include Deps["repos.registration_repo"]

        expose :season do |slug:|
          season_repo.find_by!(slug:)
        end

        expose :events do |season|
          event_repo.find_all_by(season_id: season.id)
            .sort_by(&:title)
        end

        expose :registrations do |events|
          registration_repo.find_all_by(event_id: events.map(&:id))
            .sort_by { [_1.name || "", _1.id] }
            .group_by(&:event_id)
        end
      end
    end
  end
end
