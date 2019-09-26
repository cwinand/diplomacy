require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test 'valid move is valid' do
    assert orders(:valid_move).valid?
  end

  test 'invalid move is invalid' do
    assert_not orders(:invalid_move).valid?
  end

end
