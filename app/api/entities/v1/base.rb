module API
  module Entities
    module V1
      class Base < Grape::Entity
        format_with(:iso_timestamp) { |dt| dt.iso8601 if dt }
        format_with(:int_timestamp) { |dt| dt.to_i if dt }
        format_with(:date_int_timestamp) { |dt| dt.to_time(:utc).to_i if dt }
        format_with(:pretty_float) { |dt| dt.to_f.round(2) if dt }
        format_with(:pretty_1_precision) { |dt| dt.to_f.round(1) if dt }
        format_with(:round_float) { |dt| dt.to_f.round if dt }
      end
    end
  end
end
