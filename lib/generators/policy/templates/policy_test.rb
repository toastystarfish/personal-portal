<% module_namespacing do -%>
class <%= class_name %>Policy < ActiveSupport::TestCase

  setup do
    @policy = <%= class_name %>Policy.new(User.new, <%= class_name %>)
  end

  test "scope" do
    skip
  end

  test "allows access to index" do
    assert @policy.index?
  end

  test "allows access to show" do
    assert @policy.show?
  end

  test "allows access to new" do
    assert @policy.new?
  end

  test "allows access to create" do
    assert @policy.create?
  end

  test "allows access to edit" do
    assert @policy.edit?
  end

  test "allows access to update" do
    assert @policy.update?
  end

  test "allows access to destroy" do
    assert @policy.destroy?
  end
end
<% end -%>
