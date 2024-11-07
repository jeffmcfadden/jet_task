module JetTask

  # A set of tags
  # @note In a TagSet, Tags _must_ have unique names. If you try to add a tag with the same name as an existing tag, the existing tag will be replaced.
  class TagSet
    include Enumerable
    attr_reader :tags

    # @param [Array<Tag>] tags
    def initialize(tags: [])
      @tags = tags.map{ [_1.name, _1] }.to_h
    end

    def add(tag)
      if tag.is_a?(String)
        tag = Tag.new(name: tag)
      end

      @tags[tag.name] = tag
    end

    alias_method :+, :add
    alias_method :<<, :add

    def remove(tag)
      @tags.delete(tag.name)
    end

    alias_method :-, :remove

    # Returns the tag with the given name, or nil if not found
    # @param [String] name
    # @return [JetTask::Tag, nil]
    def named(name)
      @tags[name]
    end

    def size
      @tags.size
    end

    alias_method :length, :size
    alias_method :count, :size

    def each(&block)
      @tags.values.each(&block)
    end


  end

end