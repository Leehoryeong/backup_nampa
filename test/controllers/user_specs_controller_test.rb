require 'test_helper'

class UserSpecsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_spec = user_specs(:one)
  end

  test "should get index" do
    get user_specs_url
    assert_response :success
  end

  test "should get new" do
    get new_user_spec_url
    assert_response :success
  end

  test "should create user_spec" do
    assert_difference('UserSpec.count') do
      post user_specs_url, params: { user_spec: { age: @user_spec.age, allergy: @user_spec.allergy, atopy: @user_spec.atopy, bb: @user_spec.bb, color: @user_spec.color, eyebrow: @user_spec.eyebrow, eyeline: @user_spec.eyeline, lip: @user_spec.lip, pimple: @user_spec.pimple, skincolor: @user_spec.skincolor, skintype: @user_spec.skintype } }
    end

    assert_redirected_to user_spec_url(UserSpec.last)
  end

  test "should show user_spec" do
    get user_spec_url(@user_spec)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_spec_url(@user_spec)
    assert_response :success
  end

  test "should update user_spec" do
    patch user_spec_url(@user_spec), params: { user_spec: { age: @user_spec.age, allergy: @user_spec.allergy, atopy: @user_spec.atopy, bb: @user_spec.bb, color: @user_spec.color, eyebrow: @user_spec.eyebrow, eyeline: @user_spec.eyeline, lip: @user_spec.lip, pimple: @user_spec.pimple, skincolor: @user_spec.skincolor, skintype: @user_spec.skintype } }
    assert_redirected_to user_spec_url(@user_spec)
  end

  test "should destroy user_spec" do
    assert_difference('UserSpec.count', -1) do
      delete user_spec_url(@user_spec)
    end

    assert_redirected_to user_specs_url
  end
end
