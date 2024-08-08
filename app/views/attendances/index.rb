# frozen_string_literal: true

module Scoutatt
  module Views
    module Attendances
      class Index < Scoutatt::View
        include Deps[
          'repos.season_repo',
          'repos.event_repo',
          'repos.registration_repo'
        ]

        expose :season do |season_slug:|
          season_repo.find_by!(slug: season_slug)
        end

        expose :events do |season, timespan:|
          all_events = event_repo.find_all_by_season_id(season.id)
          filtered_events = all_events.select { timespan.cover?(_1.start_at) }
          filtered_events = all_events if filtered_events.empty?
          filtered_events.sort_by { [_1.start_at, _1.title[/responsable/i] ? 0 : 1, _1.title] }
        end

        expose :registrations do |events|
          registration_repo.find_all_by(event_id: events.map(&:id))
                           .group_by(&:event_id)
                           .transform_values(&:count)
        end
      end
    end
  end
end
