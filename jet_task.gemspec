# frozen_string_literal: true

require_relative "lib/jet_task/version"

Gem::Specification.new do |spec|
  spec.name = "jet_task"
  spec.version = JetTask::VERSION
  spec.authors = ["Jeff McFadden"]
  spec.email = ["jeffmcfadden@users.noreply.github.com"]

  spec.summary = "A TaskPaper cli tool and library"
  spec.description = "Work with TaskPaper projects from the command line or as a library."
  spec.homepage = "https://github.com/jeffmcfadden/jet_task"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jeffmcfadden/jet_task"
  spec.metadata["changelog_uri"] = "https://github.com/jeffmcfadden/jet_task"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "tldr"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
