require File.expand_path("../test_helper", __FILE__)

class MockClientTest < Minitest::Test

  def setup
    WebMock.disable_net_connect!
    stub_request(:any, "http://localhost:9292/accounts/26").to_return(body: '{"id":26,"org_id":26,"revenue":1598}')
    stub_request(:any, "http://localhost:9292/orgs?page=1").to_return(body: '{"results":[12,8,26,1,18,33,11,34,31,15],"page":1,"pages":4}')
    stub_request(:any, "http://localhost:9292/orgs?page=2").to_return(body: '{"results":[4,19,32,29,17,24,9,25,27,3],"page":2,"pages":4}')
    stub_request(:any, "http://localhost:9292/accounts/org/26").to_return(body: '[26,57,111,131,211,296,546,584,586,600,656,679,752,796,933,947,958,961]')
  end

  def test_default_orgs
    # skip
    expected = {"results":[12,8,26,1,18,33,11,34,31,15],"page":1,"pages":4}.to_json
    assert_equal expected, MockClient.new("http://localhost:9292").orgs
  end 

  def test_orgs_page_params
    # skip
    expected_page_1_params = {"results":[12,8,26,1,18,33,11,34,31,15],"page":1,"pages":4}.to_json
    expected_page_2_params = {"results":[4,19,32,29,17,24,9,25,27,3],"page":2,"pages":4}.to_json
    assert_equal expected_page_1_params, MockClient.new("http://localhost:9292").orgs
    assert_equal expected_page_2_params, MockClient.new("http://localhost:9292").orgs(2)
  end

  def test_accounts_by_org_id
    accounts = '[26,57,111,131,211,296,546,584,586,600,656,679,752,796,933,947,958,961]'
    assert_equal accounts, MockClient.new("http://localhost:9292").accounts_by_org_id(26)
  end

end