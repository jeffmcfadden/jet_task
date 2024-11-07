# frozen_string_literal: true
require "time"
require_relative "jet_task/version"

module JetTask
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "jet_task/models/concerns/taggable"
require_relative "jet_task/models/project"
require_relative "jet_task/models/task"
require_relative "jet_task/models/tag"
require_relative "jet_task/models/tag_set"
require_relative "jet_task/models/note"
