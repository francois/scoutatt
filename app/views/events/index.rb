# frozen_string_literal: true

module Scoutatt
  module Views
    module Events
      class Index < Scoutatt::View
        include Deps["repos.season_repo"]
        include Deps["repos.event_repo"]

        expose :season do |slug:|
          season_repo.find_by!(slug:)
        end

        expose :events do |season|
          event_repo.find_all_by_season_id(season.id).sort_by(&:title)
        end

        expose :total_registrations do |events|
          events.sum(0, &:max_registrations)
        end
      end
    end
  end
end
