# frozen_string_literal: true

module Scoutatt
  module Structs
    class Attendance < Scoutatt::DB::Struct
      def present? = !!presented_at
      def absent? = !present?

      def mark_absent = attributes[:presented_at] = nil

      def mark_present(now = Time.now) = attributes[:presented_at] = now
    end
  end
end
