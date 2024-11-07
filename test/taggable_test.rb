class TaggableTest < TLDR
  class TaggableClass
    include JetTask::Taggable

    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  def setup
    @taggable = TaggableClass.new("Test")
  end

  def test_can_add_tags
    @taggable.tags << "tag1"
    @taggable.tags << JetTask::Tag.new(name: "tag2")

    assert_equal 2, @taggable.tags.size
  end

  def test_tags_override_properly
    @taggable.tags << JetTask::Tag.new(name: "tag1")
    @taggable.tags << JetTask::Tag.new(name: "tag1", value: "value1")

    assert_equal 1, @taggable.tags.size
    assert_equal "value1", @taggable.tags.named("tag1").value
  end

end