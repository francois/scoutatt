# frozen_string_literal: true

module Scoutatt
  module Repos
    class SeasonRepo < Scoutatt::DB::Repo
      include Deps["relations.seasons"]
      include Deps["relations.events"]
      include Deps["relations.registrations"]

      def all_by_title = seasons.order(seasons[:title].desc).to_a

      def find_by_id!(id) = seasons.where(id:).one!

      def find_by!(slug:) = seasons.where(slug:).one!

      def delete_by_slug!(slug) = seasons.where(slug:).delete

      def create(attributes)
        attrs = {slug: SecureRandom.alphanumeric(4).downcase}
          .merge(attributes)
          .merge(created_at: Time.now, updated_at: Time.now)

        seasons.changeset(:create, attrs).commit
      end

      def update(slug, attributes)
        attrs = attributes.merge(updated_at: Time.now)
        seasons.where(slug:).changeset(:update, attrs).commit
      end
    end
  end
end
