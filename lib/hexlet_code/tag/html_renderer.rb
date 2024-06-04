# frozen_string_literal: true

module HexletCode
  module Tag
    # The HtmlRenderer class is responsible for converting form objects into HTML strings.
    # It defines methods for building the form and rendering various input types as HTML tags.
    # Here’s how you might use it:
    # form = HexletCode::Tag::Form.new(user, url: "/users", method: "post")
    # form.call do |f|
    #   f.input :name, class: "user-input", label: "Name"
    #   f.input :job, as: "text", cols: 50, rows: 50, label: "Job"
    #   f.submit "Save it"
    # end
    # html = HexletCode::Tag::HtmlRenderer.build(form)
    #
    # Example output:
    # <form action="/users" method="post">
    #   <label for="name">Name</label><input name="name" type="text" value="rob" class="user-input">
    #   <label for="job">Job</label><textarea name="job" cols="20" rows="40">hexlet</textarea>
    #   <input type="submit" value="Save it">
    # </form>
    #
    class HtmlRenderer
      class << self
        def build(form)
          form_args_str = ''
          form.form_args.each { |k, v| form_args_str += " #{k}=\"#{v}\"" }
          fields = create_fields(form)

          "<form#{form_args_str}>#{fields}</form>"
        end

        def create_fields(form)
          form.fields.each_with_object(String.new) do |params, fields_str|
            field = send("#{params[:type]}_tag_string", params)
            fields_str << field
          end
        end

        def submit_tag_string(params)
          "<input type=\"submit\" value=\"#{params[:value]}\">"
        end

        def text_tag_string(params)
          data = prepare_data_for_a_tag(params)
          tag = "<textarea name=\"#{params[:name]}\"#{data[:attrs_str]}>#{params[:value]}</textarea>"

          data[:label_str] + tag
        end

        def input_tag_string(params)
          data = prepare_data_for_a_tag(params)
          tag = "<input name=\"#{params[:name]}\" type=\"text\" value=\"#{params[:value]}\"#{data[:attrs_str]}>"

          data[:label_str] + tag
        end

        private

        def prepare_data_for_a_tag(params)
          params[:label] ||= params[:name].capitalize
          label_str = "<label for=\"#{params[:name]}\">#{params[:label]}</label>"
          attrs_str = params[:args].map { |k, v| " #{k}=\"#{v}\"" }.join

          { label_str:, attrs_str: }
        end
      end
    end
  end
end
