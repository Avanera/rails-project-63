# frozen_string_literal: true

require_relative 'hexlet_code/version'
# The HexletCode module provides a simple interface for generating HTML tags.
# It autoloads its internal Tag module, which is responsible for building the HTML tags.
#
# Example usage:
#   HexletCode.generate_tag("br")  # => "<br>"
#   HexletCode.generate_tag("img", src: "path/to/image")  # => "<img src=\"path/to/image\">"
#
# Additionally, the form_for method allows for easy generation of forms based on object data:
#   User = Struct.new(:name, :job, :gender, keyword_init: true)
#   user = User.new(name: "rob", job: "hexlet", gender: "m")
#   form_html = HexletCode.form_for(user, url: "#") do |f|
#     f.input :name, class: "user-input", label: "Name"
#     f.input :job
#     f.submit "Wow"
#   end
#   puts form_html
#   # Output:
#   # <form action="#" method="post">
#   #   <label for="name">Name</label>
#   #   <input name="name" type="text" value="rob" class="user-input">
#   #   <input name="job" type="text" value="hexlet">
#   #   <input type="submit" value="Wow">
#   # </form>
#
module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  class Error < StandardError; end

  def self.generate_tag(tag_name, *)
    Tag.build(tag_name, *)
  end

  def self.form_for(obj, args = {}, &)
    form = Tag::Form.new(obj, args).call(&)
    Tag::HtmlRenderer.build(form)
  end
end
