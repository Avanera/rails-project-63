# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  autoload(:Tag, "hexlet_code/tag")

  class Error < StandardError; end

  def self.generate_tag(tag_name, *args)
    Tag.build(tag_name, *args)
  end
end
