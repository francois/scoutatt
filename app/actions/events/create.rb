# frozen_string_literal: true

require "csv"

module Scoutatt
  module Actions
    module Events
      class Create < Scoutatt::Action
        include Deps[
          "repos.season_repo",
          "repos.event_repo",
          view: "views.events.index"
        ]

        params do
          required(:slug).filled(:string)
          required(:event).hash do
            required(:title).filled(:string)
            required(:dates).filled(:string)
            required(:min_hour).filled(:integer, gteq?: 0, lt?: 24)
            required(:max_hour).filled(:integer, gteq?: 0, lteq?: 24)
            required(:hours_per_shift).filled(:integer, gteq?: 1, lt?: 24)
            required(:registrations_per_shift).filled(:integer, gteq?: 1, lt?: 100)
            required(:adult_registrations_per_shift).filled(:integer, gteq?: 1, lt?: 100)
          end
        end

        def handle(request, response)
          halt 422, response.render(view, slug: request.params[:slug]) unless request.params.valid?

          season = season_repo.find_by!(slug: request.params[:slug])

          title = request.params[:event][:title]
          dates = CSV.parse_line(request.params[:event][:dates])
          hours = (request.params[:event][:min_hour]...request.params[:event][:max_hour])
            .step(request.params[:event][:hours_per_shift])
            .to_a

          new_events = Array(title).product(dates, hours).flat_map do |title, date, hour|
            start_at = Time.parse("#{date} #{hour}:00")
            [
              {
                season:, start_at:, title:,
                max_registrations: request.params[:event][:registrations_per_shift]
              },
              {
                season:, start_at:, title: "#{title} (Responsables)",
                max_registrations: request.params[:event][:adult_registrations_per_shift]
              }
            ]
          end
          event_repo.create_many(new_events)

          response.redirect_to routes.path(:events, slug: season.slug)
        end
      end
    end
  end
end
