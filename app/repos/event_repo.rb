# frozen_string_literal: true

module Scoutatt
  module Repos
    class EventRepo < Scoutatt::DB::Repo
      include Deps["relations.events"]

      def find_all_by_season_id(season_id) = events.where(season_id:).to_a

      def find_all_by_season_slug(slug) = events.where(slug:).to_a

      def find_by!(slug:)= events.where(slug:).one!

      def event_ids_by_slug = events.to_a.map { [_1[:slug], _1[:id]] }.to_h

      def delete_by_slug(slug)
        event = find_by!(slug:)
        events.where(slug:).delete
        event
      end

      def create_many(attributes)
        attrs = attributes.map do
          _1[:season_id] = _1.delete(:season).id if _1.include?(:season)
          _1.merge(
            slug: SecureRandom.alphanumeric(4).downcase,
            created_at: Time.now,
            updated_at: Time.now
          )
        end

        events.changeset(:create, attrs).commit
      end

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

      def update(slug, attributes)
        attrs = attributes.merge(updated_at: Time.now)
        events.where(slug:).changeset(:update, attrs).commit
      end
    end
  end
end
