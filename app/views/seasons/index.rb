# frozen_string_literal: true

module Scoutatt
  module Views
    module Seasons
      class Index < Scoutatt::View
        include Deps["repos.season_repo"]
        include Deps["repos.event_repo"]
        include Deps["repos.registration_repo"]

        expose :seasons do
          season_repo.all_by_title
        end

        private_expose :events do |seasons|
          event_repo.find_all_by_season_id(seasons.map(&:id))
        end

        private_expose :registrations do |events|
          registration_repo.find_all_by(event_id: events.map(&:id))
        end

        expose :num_events do |events|
          events.group_by(&:season_id)
            .transform_values(&:count)
        end

        expose :num_registered_registrations do |events, registrations|
          season_ids = events.map { [_1.id, _1.season_id] }.to_h
          registrations.each_with_object(Hash.new(0)) do |registration, memo|
            memo[season_ids.fetch(registration.event_id)] += 1
          end
        end

        expose :total_registrations do |events|
          events.group_by(&:season_id)
            .transform_values { _1.map(&:max_registrations) }
            .transform_values(&:sum)
        end
      end
    end
  end
end
