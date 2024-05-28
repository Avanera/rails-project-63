# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag, args = {})
      return "<#{tag}>" if args.empty?

      arg_str = args.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
      "<#{tag} #{arg_str}>"
    end
  end
end
