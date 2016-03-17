require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  def setup
    @invitation = Fabricate(:invitation)
  end

  test 'create' do
    assert_difference ['Invitation.count', 'PaperTrail::Version.count'] do
      Invitation.create! Fabricate.attributes_for(:invitation)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Invitation.count' do
        @invitation.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @invitation.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Invitation.count', -1) { @invitation.destroy }
    end
  end

  test 'validates blank attributes' do
    @invitation.attr = ''

    assert @invitation.invalid?
    assert_equal 1, @invitation.errors.size
    assert_equal_messages @invitation, :attr, :blank
  end

  test 'validates unique attributes' do
    new_invitation = Fabricate(:invitation)
    @invitation.attr = new_invitation.attr

    assert @invitation.invalid?
    assert_equal 1, @invitation.errors.size
    assert_equal_messages @invitation, :attr, :taken
  end
end
