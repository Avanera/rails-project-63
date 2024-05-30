# frozen_string_literal: true

module HexletCode
  module Tag
    #
    # The HexletCode::Tag::Form class is responsible for building HTML form tags.
    # It provides a DSL to easily generate form elements such as <input> and <textarea>
    # tags with various attributes.
    #
    # Example usage:
    #   user = User.new(name: 'rob', job: 'hexlet')
    #   form_html = HexletCode::Tag::Form.build(user, url: '#') do |form|
    #     form.input :job, as: :text, cols: 50, rows: 50
    #   end
    #   puts form_html
    #   # Output:
    #   # <form action="#" method="post">
    #   # <textarea cols="50" rows="50" name="job">hexlet</textarea>
    #   # </form>
    #
    # The `build` class method initializes a new Form object, sets the form's action URL,
    # and yields to a block where input fields can be added.
    # The `input` method dynamically adds either a <textarea> or <input> field to the form.
    # The `make_textarea_tag` and `make_input_tag` methods generate the appropriate HTML
    # tags based on the provided attributes.
    #
    # Attributes:
    # - object: The object containing the data for the form fields.
    # - fields_str: A string that accumulates the generated HTML for the form fields.
    #
    class Form
      attr_reader :object
      attr_accessor :fields_str

      def initialize(obj)
        @object = obj
        @fields_str = ""
      end

      def self.build(obj, args, &block)
        form = Form.new(obj)
        url = args[:url] || "#"
        block.call(form)
        "<form action=\"#{url}\" method=\"post\">#{form.fields_str}</form>"
      end

      def input(name, args = {})
        str =
          if args[:as] == :text
            make_textarea_tag(name, args)
          else
            make_input_tag(name, args)
          end

        @fields_str += str
      end

      def make_textarea_tag(name, args)
        cols = args[:cols] || "20"
        rows = args[:rows] || "40"
        body = object.public_send(name)

        "<textarea name=\"#{name}\" cols=\"#{cols}\" rows=\"#{rows}\">#{body}</textarea>"
      end

      def make_input_tag(name, args)
        attrs_str = args.map { |k, v| " #{k}=\"#{v}\"" }.join("")
        value = object.public_send(name)

        "<input name=\"#{name}\" type=\"text\" value=\"#{value}\"#{attrs_str}>"
      end
    end
  end
end
