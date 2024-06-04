# frozen_string_literal: true

module HexletCode
  module Tag
    # This class, HexletCode::Tag::Form, is designed for creating a form object in Ruby. The primary
    # method call accepts a block that invokes either the input or submit methods to generate the
    # respective fields. Here’s how you might use it:
    # form = HexletCode::Tag::Form.new(user, url: "/users", method: "post")
    # form.call do |f|
    #   f.input :name, class: "user-input", label: "Name"
    #   f.input :job
    #   f.submit "Save it"
    # end
    # Example output:
    # <HexletCode::Tag::Form:0x0000000111ec6370
    #   @fields=[
    #     {:type=>"input", :name=>:name, :args=>{:class=>"user-input"}, :value=>"rob", :label=>"Name"},
    #     {:type=>:text, :name=>:job, :args=>{:cols=>20, :rows=>40}, :value=>"hexlet", :label=>"Job"},
    #     {:type=>"submit", :value=>"Save it"}
    #   ],
    #   @form_args={:action=>"/users", :method=>"post"},
    #   @object=#<struct TestHexletCode::User name="rob", job="hexlet", gender="m">
    # >
    #
    class Form
      attr_reader :object, :form_args
      attr_accessor :fields

      def initialize(obj, form_args)
        @object = obj
        @fields = []
        @form_args = prepare_form_args(form_args)
      end

      def call(&block)
        block.call(self)
        self
      end

      def input(name, args = {})
        type = args.delete(:as) || "input"
        method_name = "#{type}_tag_params"
        raise_no_method unless respond_to?(method_name)
        tag_params = send(method_name, type, name, args)

        @fields << tag_params
      end

      def submit(value = "Save")
        @fields << { type: "submit", value: }
      end

      def input_tag_params(type, name, args)
        prepare_tag_args(type, name, args)
      end

      def text_tag_params(type, name, args)
        args[:cols] ||= "20"
        args[:rows] ||= "40"

        prepare_tag_args(type, name, args)
      end

      private

      def prepare_form_args(form_args)
        { action: form_args[:url], method: form_args[:method] || "post" }
      end

      def prepare_tag_args(type, name, args)
        { type:, name:, args:, value: current_value(name), label: args.delete(:label) }
      end

      def current_value(name)
        object.public_send(name)
      end

      def raise_no_method
        error_message = "The tag with this `:as` option can not be created."
        raise NoMethodError, error_message
      end
    end
  end
end
