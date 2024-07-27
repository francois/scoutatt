# frozen_string_literal: true

module Scoutatt
  module Relations
    class Seasons < Scoutatt::DB::Relation
      schema :seasons, infer: true

      use :pagination
      per_page 25
    end
  end
end
