# frozen_string_literal: true

module Scoutatt
  module Views
    module Attendance
      class Show < Scoutatt::View
        include Deps["repos.season_repo"]
        include Deps["repos.event_repo"]
        include Deps["repos.registration_repo"]
        include Deps["repos.attendance_repo"]

        expose :event do |slug:|
          event_repo.find_by!(slug:)
        end

        expose :season do |event|
          season_repo.find_by_id!(event.season_id)
        end

        expose :registrations do |event|
          registration_repo.find_all_by(event_id: event.id)
            .sort_by { [_1.role.downcase, _1.name.downcase] }
            .group_by { _1.role.downcase }
        end

        expose :attendances do |event|
          attendance_repo.find_all_by(event_id: event.id)
            .sort_by { [_1.role.downcase, _1.name.downcase] }
            .group_by { _1.role.downcase }
        end

        expose :roles do |registrations, attendances|
          (registrations.keys + attendances.keys).uniq.sort
        end

        expose :combined do |roles, attendances, registrations|
          {}.tap do |regs|
            # roles is an Array of parts, while the keys of registrations are plain String objects. When using the
            # Hash#[] method, the Part#eql? doesn't answer true, thus we can't find anything. That's why we map
            # roles to strings before entering the body of the loop.
            roles.map(&:to_s).sort.each do |key|
              regs[key] = Array(attendances[key]).dup
              Array(registrations[key]).each do |reg|
                regs[key] << reg if regs[key].none? { _1.name.downcase == reg.name.downcase }
              end
              regs[key] = regs[key].sort_by { _1.name.downcase }
            end
          end
        end
      end
    end
  end
end
