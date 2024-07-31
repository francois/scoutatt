# frozen_string_literal: true

module Scoutatt
  module Repos
    class EventRepo < Scoutatt::DB::Repo
      include Deps["relations.events"]

      def find_all_by(season_id:)=events.where(season_id:).to_a

      def find_by!(slug:)= events.where(slug:).one!

      def create(attributes)
        season_id = if attributes.include?(:season)
          attributes.fetch(:season).id
        else
          attributes.fetch(:season_id)
        end
        attrs = attributes.merge(
          season_id:, season: nil,
          slug: SecureRandom.alphanumeric(4).downcase,
          created_at: Time.now,
          updated_at: Time.now
        )

        events.changeset(:create, attrs.compact).commit
      end
    end
  end
end
