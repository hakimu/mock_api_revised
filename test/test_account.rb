require File.expand_path("../test_helper", __FILE__)

class TestAccount < Minitest::Test

  def setup
    # @account = Account.new(26)
    @account = Account.new(26)
    # stub_request(:get, "http://localhost:9292/accounts/26").
    # with(:headers => {'API_KEY' => 'foo'}).
    # to_return(:status => 200, :body => "", :headers => {})
    stub_request(:get, "http://localhost:9292/accounts/26").
      with(  headers: {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'Api-Key'=>'',
    'Host'=>'localhost:9292',
    'User-Agent'=>'Ruby'
    }).
  to_return(status: 200, body: "", headers: {})
    
  end

  def test_revenue_is_correct
    expected = 1598
    assert_equal expected, @account.revenue
  end
end

