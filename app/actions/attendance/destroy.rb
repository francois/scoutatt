# frozen_string_literal: true

module Scoutatt
  module Actions
    module Attendance
      class Destroy < Scoutatt::Action
        include Deps['repos.attendance_repo']
        include Deps['repos.event_repo']
        include Deps['repos.registration_repo']

        params do
          required(:registration_slug).filled(:string)
        end

        def handle(request, response)
          return unless request.params.valid?

          attendance = attendance_repo.find_by(slug: request.params[:registration_slug])
          if attendance
            attendance.mark_absent
            attendance_repo.update(attendance.slug, attendance.attributes)
          else
            registration = registration_repo.find_by!(slug: request.params[:registration_slug])
            attendance = attendance_repo.create(**registration.to_h.slice(:event_id, :slug, :name, :role))
          end

          response.redirect_to routes.path(:attendances, event_slug: event_repo.find_by_id!(attendance.event_id).slug)
        end
      end
    end
  end
end
