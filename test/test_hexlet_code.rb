# frozen_string_literal: true

require "test_helper"
require "yaml"

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_generates_tags
    tag = "img"
    args = { src: "path/to/image" }

    assert_equal(
      '<img src="path/to/image">',
      HexletCode.generate_tag(tag, args)
    )
  end

  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_it_generates_forms
    user = User.new name: "rob", job: "hexlet", gender: "m"
    args = { url: "/users" }

    result = HexletCode.form_for user, args do |f|
      f.input :name, class: "user-input"
      f.input :gender, as: :text
      f.input :job, as: :text, rows: 50, cols: 50
    end

    expected_form = YAML.load_file("test/fixtures/form.yml")["user"]["html_form"]

    assert_equal(expected_form, result)
  end
end
