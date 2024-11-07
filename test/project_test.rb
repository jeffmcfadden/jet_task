
class ProjectTest < TLDR
  def test_default_name
    assert_equal "Untitled", JetTask::Project.new.name
  end
end
