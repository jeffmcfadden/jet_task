# frozen_string_literal: true
require "time"
require "logger"
require_relative "jet_task/version"

module JetTask
  class Error < StandardError; end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end

  # Your code goes here...
end

require_relative "jet_task/models/concerns/taggable"
require_relative "jet_task/models/project"
require_relative "jet_task/models/project_set"
require_relative "jet_task/models/task"
require_relative "jet_task/models/task_set"
require_relative "jet_task/models/tag"
require_relative "jet_task/models/tag_set"
require_relative "jet_task/models/note"

require_relative "jet_task/parsing/parser"

require_relative "jet_task/manager"