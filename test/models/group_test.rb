require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group = Fabricate(:group)
  end

  test 'create' do
    assert_difference ['Group.count', 'PaperTrail::Version.count'] do
      Group.create! Fabricate.attributes_for(:group)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Group.count' do
        @group.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @group.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Group.count', -1) { @group.destroy }
    end
  end

  test 'validates blank attributes' do
    @group.attr = ''

    assert @group.invalid?
    assert_equal 1, @group.errors.size
    assert_equal_messages @group, :attr, :blank
  end

  test 'validates unique attributes' do
    new_group = Fabricate(:group)
    @group.attr = new_group.attr

    assert @group.invalid?
    assert_equal 1, @group.errors.size
    assert_equal_messages @group, :attr, :taken
  end
end
