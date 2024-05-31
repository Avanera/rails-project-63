# frozen_string_literal: true

module HexletCode
  module Tag
    #
    # The HexletCode::Tag::Form class is responsible for building HTML form tags.
    # It provides a DSL to easily generate form elements such as <input> and <textarea>
    # tags with various attributes.
    #
    # Example usage:
    #     form.input :job, as: :text, cols: 50, rows: 50
    #   user = User.new(name: "rob", job: "hexlet")
    #   form_html = HexletCode::Tag::Form.build(user, url: "#") do |form|
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
        type = args.delete(:as) || "input"
        method_name = "create_#{type}_tag"
        raise_no_method unless respond_to?(method_name)
        str = send(method_name, name, args)

        @fields_str += str
      end

      def create_text_tag(name, args)
        args[:cols] ||= "20"
        args[:rows] ||= "40"

        attrs_str, current_value = prepare_data_for_any_tag(name, args)

        "<textarea name=\"#{name}\"#{attrs_str}>#{current_value}</textarea>"
      end

      def create_input_tag(name, args)
        attrs_str, current_value = prepare_data_for_any_tag(name, args)

        "<input name=\"#{name}\" type=\"text\" value=\"#{current_value}\"#{attrs_str}>"
      end

      def prepare_data_for_any_tag(name, args)
        attrs_str = args.map { |k, v| " #{k}=\"#{v}\"" }.join("")
        current_value = object.public_send(name)
        [attrs_str, current_value]
      end

      def raise_no_method
        error_message = "The tag with this `:as` option can not be created."
        raise NoMethodError, error_message
      end
    end
  end
end
