# frozen_string_literal: true

require 'active_support/inflector'
require_relative 'inputs/input'
require_relative 'inputs/text'

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
      extend ActiveSupport::Inflector

      attr_reader :object, :form_args
      attr_accessor :fields

      def initialize(obj, form_args, &)
        @object = obj
        @form_args = prepare_form_args(form_args)
        @fields = []
        create_fields_in_the_form(&)
      end

      def input(name, args = {})
        type = args.delete(:as) || 'input'
        begin
          klass = "HexletCode::Tag::Inputs::#{type.capitalize}".constantize
        rescue NameError
          raise_no_method(type)
        end
        value = get_current_value(name)
        tag_params = klass.new.build_tag_params(type, name, args, value)

        @fields << tag_params
      end

      def submit(value = 'Save')
        @fields << { type: 'submit', value: }
      end

      private

      def create_fields_in_the_form(&block)
        block.call(self)
      end

      def prepare_form_args(form_args)
        form_args[:action] = form_args.delete(:url)
        form_args[:method] ||= 'post'
        form_args.sort.to_h
      end

      def get_current_value(name)
        object.public_send(name)
      end

      def raise_no_method(type)
        error_message = "The tag with `:as` option '#{type}' can not be created."
        raise NoMethodError, error_message
      end
    end
  end
end
