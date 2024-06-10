# frozen_string_literal: true

module HexletCode
  module Tag
    module Inputs
      class Text
        def build_tag_params(type, name, args, value)
          args[:cols] ||= '20'
          args[:rows] ||= '40'

          { type:, name:, args:, value:, label: args.delete(:label) }
        end
      end
    end
  end
end
