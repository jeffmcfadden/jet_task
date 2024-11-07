# frozen_string_literal: true
require "time"
require_relative "jet_task/version"

module JetTask
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "jet_task/concerns/taggable"
require_relative "jet_task/project"
require_relative "jet_task/task"
require_relative "jet_task/tag"
require_relative "jet_task/tag_set"
require_relative "jet_task/note"
