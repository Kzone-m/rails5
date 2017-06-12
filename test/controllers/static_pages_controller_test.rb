require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "JQTraveler"
  end

  test "should get home" do
    # get static_pages_home_url
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    # get static_pages_help_url
    get helf_path
    assert_response :success
    assert_select "title", "HELP | #{@base_title}"
  end

  test "should get about" do
    # get static_pages_about_url
    get about_path
    assert_response :success
    assert_select "title", "ABOUT | #{@base_title}"
  end

  test "should get contact" do
    # get static_pages_contact_url
    get contact_path
    assert_response :success
    assert_select "title", "CONTACT | #{@base_title}"
  end
end
