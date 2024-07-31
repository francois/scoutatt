# frozen_string_literal: true

module Scoutatt
  module Relations
    class Events < Scoutatt::DB::Relation
      schema :events, infer: true
    end
  end
end
