# frozen_string_literal: true

module Scoutatt
  module Relations
    class Registrations < Scoutatt::DB::Relation
      schema :registrations, infer: true
    end
  end
end
