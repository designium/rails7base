require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # include Discard::Model

  setup do
    get '/users/sign_in'
    sign_in users(:one)

    # p = Post.new
    # p.title = "Testing 1234"
    # p.content = "1234"
    # p.user = users(:one)

    @post = posts(:three)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { content: @post.content, title: @post.title, user_id: @post.user_id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get '/users/sign_in'
    sign_in users(:one)
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    @post.title = "Test TEst"
    @post.content = 12341234
    @post.user_id = 1
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title, user_id: @post.user_id } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.kept.count", -1) do
      @post.discard
      post_url(@post)
    end
    assert_response :success
    # assert_redirected_to posts_url
  end
end
