# frozen_string_literal: true

module Scoutatt
  module Relations
    class Attendances < Scoutatt::DB::Relation
      schema :attendances, infer: true
    end
  end
end
