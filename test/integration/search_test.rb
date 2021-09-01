require "test_helper"

class SearchTest < ActionDispatch::IntegrationTest
  def setup
    @adminuser = users(:yamada)
    log_in_as(@adminuser)

    @store = stores(:ramen1)
    @other_store = stores(:ramen2)
  end

  test "no search results" do
    get search_path
    assert_template "search/search"
    get search_path params: {keyword: "無効な検索"}
    assert_select "a[href=?]", store_path(@store), count: 0
    assert_select "a[href=?]", store_path(@other_store), count: 0
    assert_select "div.no-results"
  end

  test "search test" do
    get search_path
    get search_path params: {keyword: "めんや てすと"}
    assert_select "a[href=?]", store_path(@store)
    assert_select "a[href=?]", store_path(@other_store), count: 0
    get search_path params: {keyword: "四郎"}
    assert_select "a[href=?]", store_path(@store), count: 0
    assert_select "a[href=?]", store_path(@other_store)
    assert_select "div.no-results", count: 0
  end

end
