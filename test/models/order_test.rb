require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test 'move to bordered province is valid' do
    assert orders(:a_move_par_bur).valid?
    assert orders(:a_move_con_bul).valid?
    assert orders(:f_move_aeg_eas).valid?
  end

  test 'move fleet to coast/correct split coast is valid' do
    assert orders(:f_move_aeg_con).valid?
    assert orders(:f_move_aeg_bul_sc).valid?
  end

  test 'move to unbordered province is invalid' do
    assert_not orders(:a_move_par_bel).valid?
  end

  test 'move fleet to wrong split coast is invalid' do
    assert_not orders(:f_move_aeg_bul_nil).valid?
    assert_not orders(:f_move_aeg_bul_ec).valid?
  end

end
