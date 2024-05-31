# frozen_string_literal: true

module HexletCode
  # The HexletCode::Tag class is responsible for generating HTML tags.
  # It provides a class method `build` that creates an HTML tag string
  # based on the given tag name and optional attributes.
  #
  # Example usage:
  #   HexletCode::Tag.build("br")  # => "<br>"
  #   HexletCode::Tag.build("img", src: "path/to/image")  # => "<img src=\"path/to/image\">"
  #
  # Arguments:
  #   tag (String): The name of the HTML tag to be generated.
  #   args (Hash): A hash of attributes to be added to the tag.
  #
  # Returns:
  #   String: The generated HTML tag string.
  #
  module Tag
    autoload :Form, "hexlet_code/tag/form"

    def self.build(tag, args = {})
      return "<#{tag}>" if args.empty?

      arg_str = args.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
      "<#{tag} #{arg_str}>"
    end
  end
end
