# frozen_string_literal: true

module Scoutatt
  module Actions
    module Attendance
      class Create < Scoutatt::Action
        include Deps["repos.attendance_repo"]
        include Deps["repos.event_repo"]

        params do
          required(:event_slug).filled(:string)
          required(:attendance).filled(:hash) do
            required(:name).filled(:string)
            required(:role).filled(:string)
          end
        end

        def handle(request, response)
          return unless request.params.valid?

          event = event_repo.find_by!(slug: request.params[:event_slug])
          attendance_repo.create(
            event_id: event.id,
            name: request.params[:attendance][:name],
            role: request.params[:attendance][:role],
            presented_at: Time.now
          )

          response.redirect_to routes.path(:attendances, event_slug: event.slug)
        end
      end
    end
  end
end
