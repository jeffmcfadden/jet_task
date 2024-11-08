require 'stringio'

class SerializerTest < TLDR

  def test_serialization
    manager = JetTask::Manager.load(File.open("test/data/sample_projects_01.txt"))

    output = StringIO.new

    JetTask::TaskPaperSerializer.new(
      projects: manager.projects,
      global_tasks: manager.global_tasks,
      notes: manager.notes).write(output)

    expected = "# Test Project A:\n- [ ] A task\n- [ ] B task\n- [ ] This is another task\n\n# Test Project Beta:\n- [ ] What is this  @dunno(asdf)\n\n"

    assert_equal expected, output.string
  end

end