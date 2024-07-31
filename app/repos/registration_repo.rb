# frozen_string_literal: true

module Scoutatt
  module Repos
    class RegistrationRepo < Scoutatt::DB::Repo
      include Deps["relations.registrations"]

      def create(attributes)
        attributes = attributes.merge(slot_id: attributes.delete(:slot).id) if attributes.include?(:slot)

        attrs = attributes.merge(
          slug: SecureRandom.alphanumeric(4).downcase,
          created_at: Time.now,
          updated_at: Time.now
        )

        registrations.changeset(:create, attrs).commit
      end
    end
  end
end
