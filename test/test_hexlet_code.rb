# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_generates_tags
    tag = 'img'
    args = { src: 'path/to/image' }

    assert_equal(
      '<img src="path/to/image">',
      HexletCode.generate_tag(tag, args)
    )
  end

  User = Struct.new(:name, :job, :gender, keyword_init: true)
  def setup
    @user = User.new name: 'rob', job: 'hexlet', gender: 'm'
  end

  def test_it_generates_a_form_with_defaults
    result = HexletCode.form_for @user, {} do |f|
      f.input :name
      f.input :job, as: :text
      f.submit
    end

    expected_form = FIXTURES['user']['html_form_with_defaults']

    assert_equal(expected_form, result)
  end

  def test_it_generates_a_form_with_custom_params
    args = { url: '/users', method: :get, class: 'hexlet-form' }

    result = HexletCode.form_for @user, args do |f|
      f.input :name, class: 'user-input'
      f.input :gender, as: :text, label: 'Gender Identity'
      f.input :job, as: :text, cols: 50, rows: 50
      f.submit 'Wow'
    end

    expected_form = FIXTURES['user']['html_form_with_custom_params']

    assert_equal(expected_form, result)
  end

  def test_it_raises_no_method_error
    error = assert_raises(NoMethodError) do
      HexletCode.form_for User.new do |f|
        f.input :job, as: :no_such_tag
      end
    end

    assert_equal "The tag with `:as` option 'no_such_tag' can not be created.", error.message
  end
end
