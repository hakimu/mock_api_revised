require File.expand_path("../test_helper", __FILE__)

class TestAccount < Minitest::Test

  def setup
    WebMock.disable_net_connect!
    stub_request(:any, "http://localhost:9292/accounts/26").to_return(body: '{"id":26,"org_id":26,"revenue":1598}')
  end

  def test_revenue_is_correct
    expected = 1598
    assert_equal expected, Account.new(26).revenue
  end
end

