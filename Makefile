install:
		gem install bundler
		bundle install
lint:
		bundle exec rubocop
test:
		bundle exec rake test

.PHONY: install lint test
