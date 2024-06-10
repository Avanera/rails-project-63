# frozen_string_literal: true

module HexletCode
  module Tag
    module Inputs
      class Text
        COLS_DEFAULT = '20'
        ROWS_DEFAULT = '40'

        def build_tag_params(type, name, args, value)
          args[:cols] ||= COLS_DEFAULT
          args[:rows] ||= ROWS_DEFAULT

          { type:, name:, args:, value:, label: args.delete(:label) }
        end
      end
    end
  end
end
