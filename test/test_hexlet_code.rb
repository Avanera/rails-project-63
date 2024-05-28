# frozen_string_literal: true

require "test_helper"

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
end
