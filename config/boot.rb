ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
# This app is especially used as the testy app and we want to show that it's not packed
ENV["AVO_IN_DEVELOPMENT"] = "1"

require "bundler/setup" # Set up gems listed in the Gemfile.
# require "bootsnap/setup" # Speed up boot time by caching expensive operations.
