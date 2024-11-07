module JetTask
  module Taggable
    def tags
      @tags ||= TagSet.new
    end

    def add_tag(tag:)
      tags.add(tag: tag)
    end

    def remove_tag(tag:)
      tags.remove(tag: tag)
    end

    def named_tag(name)
      tags.named(name)
    end
  end
end