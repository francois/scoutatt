# frozen_string_literal: true

module Scoutatt
  module Repos
    class SlotRepo < Scoutatt::DB::Repo
      include Deps["relations.slots"]

      def find_all_by(event_id:) = slots.where(event_id:).to_a

      def create(attributes)
        event_id = if attributes.include?(:event)
          attributes.fetch(:event).id
        else
          attributes.fetch(:event_id)
        end
        attrs = attributes.merge(
          event_id:, event: nil,
          slug: SecureRandom.alphanumeric(4).downcase,
          created_at: Time.now,
          updated_at: Time.now
        )

        slots.changeset(:create, attrs.compact).commit
      end
    end
  end
end
