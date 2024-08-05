# frozen_string_literal: true

module Scoutatt
  module Structs
    class Registration < Scoutatt::DB::Struct
      def present? = false

      def absent? = true
    end
  end
end
