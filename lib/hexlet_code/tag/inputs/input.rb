# frozen_string_literal: true

module HexletCode
  module Tag
    module Inputs
      class Input
        def build_tag_params(type, name, args, value)
          { type:, name:, args:, value:, label: args.delete(:label) }
        end
      end
    end
  end
end
