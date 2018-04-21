require File.expand_path("../test_helper", __FILE__)

class TestOrganization < Minitest::Test

  def setup
    accounts = [146,167,227,310,345,359,402,469,493,518,576,610,631,641,694,702,791,815,822,866,896,915]
    users = [4,44,84,124,164,204,244,284]
    @organization = Organization.new(4, "Franecki-Schneider", 22, "subsidiary", accounts, users)
  end

  def test_subsidiary_is_correct
    accounts = [146,167,227,310,345,359,402,469,493,518,576,610,631,641,694,702,791,815,822,866,896,915]
    users = [4,44,84,124,164,204,244,284]
    assert @organization.subsidiary?
  end

  def test_total_revenue_adds_properly
    expected = 66649
    assert_equal expected, @organization.total_revenue
  end

  def test_calculate_support_score
    expected = 2
    assert_equal expected, @organization.calculate_support_score
  end
end