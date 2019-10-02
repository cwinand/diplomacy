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

  test 'correct support of move is valid' do
    assert orders(:f_aeg_support_a_con_bul).valid?
  end

  test 'support for a move that is not performed is not valid' do
    assert_not orders(:a_ber_support_a_mun_hold).valid?
  end

  test 'support for a supporting unit as a hold is valid' do
    assert orders(:f_eng_support_f_pic_hold).valid?
  end

  test 'support from an army to fleet in sea is invalid' do
    assert_not orders(:a_con_support_f_aeg_eas).valid?
  end

  test 'support from a fleet to army on land is invalid' do
    assert_not orders(:f_bre_support_a_pic_par).valid?
  end

end
