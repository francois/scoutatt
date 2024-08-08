# frozen_string_literal: true

module Scoutatt
  module Repos
    class AttendanceRepo < Scoutatt::DB::Repo
      include Deps["relations.attendances"]

      def find_all_by(event_id:)
        attendances
          .where(event_id:)
          .order(Sequel.function(:lower, Sequel.function(:coalesce, Sequel[:name], Sequel.lit("''"))), :id)
          .to_a
      end

      def find_by(slug:) = attendances.where(slug:).one

      def present!(slug) = attendances.where(slug:).changeset(:update, presented_at: Time.now).commit

      def absent!(slug) = attendances.where(slug:).changeset(:update, presented_at: nil).commit

      def create(attributes)
        attributes[:event_id] = attributes.delete(:event).id if attributes.include?(:event)
        attributes = {
          slug: SecureRandom.alphanumeric(4).downcase,
          created_at: Time.now,
          updated_at: Time.now
        }.merge(attributes)

        attendances.changeset(:create, attributes).commit
      end

      def update(slug, attributes)
        attributes[:event_id] = attributes.delete(:event).id if attributes.include?(:event)
        attributes = {updated_at: Time.now}.merge(attributes)

        attendances.where(slug:).changeset(:update, attributes).commit
      end
    end
  end
end
