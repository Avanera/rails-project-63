# frozen_string_literal: true

require_relative "hexlet_code/version"

# The module autoloads its internal Tag class, which is responsible for
# building the HTML tags.
#
# Example usage:
#   HexletCode.generate_tag('br')  # => "<br>"
#   HexletCode.generate_tag('img', src: 'path/to/image')  # => "<img src=\"path/to/image\">"
#
module HexletCode
  autoload(:Tag, "hexlet_code/tag")

  class Error < StandardError; end

  def self.generate_tag(tag_name, *args)
    Tag.build(tag_name, *args)
  end
end
