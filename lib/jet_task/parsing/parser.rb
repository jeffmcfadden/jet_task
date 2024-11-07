module JetTask

  class Parser
    attr_reader :global_tasks, :projects, :notes

    def initialize
      @global_tasks = []
      @projects = []
      @notes = []
    end

    def parse(io)
      context = :global_task # Default
      active_note = ""

      io.each_line do |line|

        # Is the line empty?
        if line.strip.empty?
          if !active_note.empty?
            @notes << active_note
            active_note = ""
          end

          context = :global_task
          next
        end

        # Does the line start with a hyphen?
        # Then we're dealing with a Task
        if line.strip[0] == "-"
          # JetTask.logger.debug "Found a task: #{line}"

          text, tags = extract_tags_and_values(line.delete_prefix("-").strip)
          new_task = JetTask::Task.new(name: text, tags: tags)

          if @projects.empty?
            @global_tasks << new_task
          else
            @projects.last.tasks << new_task
          end

          next
        end

        # Does the line end with a colon?
        # If so, we have a new project
        if line.strip[-1] == ":"
          # JetTask.logger.debug "Found a project: #{line}"
          text, tags = extract_tags_and_values(line.strip.delete_suffix(":").strip)

          context = :project
          @projects << JetTask::Project.new(name: text, tags: tags)
          next
        end

        # Must be a note
        # JetTask.logger.debug "Must be (part of) a note: #{line}"
        active_note << line
      end
    end

    # Extracts tags and their values from a line of text
    #
    # @example
    #   "This is a task @tag1 @tag2(asdf) with tags" => ["This is a task with tags", {tag1: nil, tag2: "asdf"}]
    #
    # @param line [String] the line of text to extract tags from
    # @return [Array<String, Array<JetTask::Tag>>] the remaining text and an array of tags
    def extract_tags_and_values(line)
      tags = {}
      remaining_text = line.dup

      # If the text "[X]" or "[x]" is found, remove it and append a tag "@done"
      if line.match(/\[x\]/i)
        remaining_text += " @done" # This will get parsed below
      end

      # Remove the "[X]" or "[x]" or "[ ]" from the text
      remaining_text.gsub!(/\[x\]|\[ \]/i, "")

      # Find all tags in the line
      # This regex matches a tag, which is an @ symbol followed by one or more word characters
      # Optionally followed by a parenthesized value

      regex = /@(\w+)(?:\(([^)]+)\))?/
      line.scan(regex) do |match|
        tag = match[0]
        value = match[1]

        tags[tag.to_sym] = value

        # Remove the tag from the remaining text
        remaining_text.gsub!(regex, "")
      end

      # Return objects
      tags = tags.map{ |k, v| JetTask::Tag.new(name: k, value: v) }

      return remaining_text, tags
    end

  end
end