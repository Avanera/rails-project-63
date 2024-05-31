# frozen_string_literal: true

require_relative "hexlet_code/version"
# The HexletCode module provides a simple interface for generating HTML tags.
# It autoloads its internal Tag module, which is responsible for building the HTML tags.
#
# Example usage:
#   HexletCode.generate_tag("br")  # => "<br>"
#   HexletCode.generate_tag("img", src: "path/to/image")  # => "<img src=\"path/to/image\">"
#
# Additionally, the form_for method allows for easy generation of forms based on object data:
#   User = Struct.new(:name, :job, :gender, keyword_init: true)
#     f.input :name, class: 'user-input'
#   user = User.new(name: "rob", job: "hexlet", gender: "m")
#   form_html = HexletCode.form_for(user, url: "#") do |f|
#     f.input :job
#   end
#   puts form_html
#   # Output:
#   # <form action="#" method="post">
#   #   <input name="name" type="text" value="rob" class="user-input">
#   #   <input name="job" type="text" value="hexlet">
#   # </form>
#
module HexletCode
  autoload(:Tag, "hexlet_code/tag")

  class Error < StandardError; end

  def self.generate_tag(tag_name, *args)
    Tag.build(tag_name, *args)
  end

  def self.form_for(obj, args = {}, &block)
    Tag::Form.build(obj, args, &block)
  end
end
