# frozen_string_literal: true

module Scoutatt
  module Actions
    module Registrations
      class Create < Scoutatt::Action
        include Deps["views.seasons.show"]

        params do
          required(:slug).filled(:string)
          required(:registration).hash do
            required(:email).filled(:string)
            hash do
              hash do
                required(:name).filled(:string)
                required(:role).filled(:string)
              end
            end
          end
        end

        def handle(request, _response)
          return unless request.params.valid?

          raise request.params.to_h.inspect
        end
      end
    end
  end
end
