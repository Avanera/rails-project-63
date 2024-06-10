# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'hexlet_code'
require 'minitest/autorun'
require 'pry'
require 'yaml'

FIXTURES = YAML.load_file('test/fixtures/form.yml')
