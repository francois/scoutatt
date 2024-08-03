# frozen_string_literal: true

module Scoutatt
  module Repos
    class RegistrationRepo < Scoutatt::DB::Repo
      include Deps["relations.registrations"]

      def find_all_by(event_id:)
        registrations
          .where(event_id:)
          .order("lower(coalesce(name, ''))", :id)
          .to_a
      end

      def create_many(attributes)
        attrs = attributes.map do
          _1[:event_id] = attributes.delete(:event).id if _1.include?(:event)
          _1.merge(
            slug: SecureRandom.alphanumeric(4).downcase,
            created_at: Time.now,
            updated_at: Time.now
          )
        end

        registrations.changeset(:create, attrs).commit
      end

      def create(attributes)
        attributes = attributes.merge(event_id: attributes.delete(:event).id) if attributes.include?(:event)

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
