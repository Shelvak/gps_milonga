require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    @location = Fabricate(:location)
  end

  test 'create' do
    assert_difference ['Location.count', 'PaperTrail::Version.count'] do
      Location.create! Fabricate.attributes_for(:location)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Location.count' do
        @location.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @location.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Location.count', -1) { @location.destroy }
    end
  end

  test 'validates blank attributes' do
    @location.attr = ''

    assert @location.invalid?
    assert_equal 1, @location.errors.size
    assert_equal_messages @location, :attr, :blank
  end

  test 'validates unique attributes' do
    new_location = Fabricate(:location)
    @location.attr = new_location.attr

    assert @location.invalid?
    assert_equal 1, @location.errors.size
    assert_equal_messages @location, :attr, :taken
  end
end
