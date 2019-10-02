require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test 'move to bordered province is legal' do
    assert orders(:a_move_par_bur).legal?
    assert orders(:a_move_con_bul).legal?
    assert orders(:f_move_aeg_eas).legal?
  end

  test 'move fleet to coast/correct split coast is legal' do
    assert orders(:f_move_aeg_con).legal?
    assert orders(:f_move_aeg_bul_sc).legal?
  end

  test 'move to unbordered province is illegal' do
    assert_not orders(:a_move_par_bel).legal?
  end

  test 'move fleet to wrong split coast is illegal' do
    assert_not orders(:f_move_aeg_bul_nil).legal?
    assert_not orders(:f_move_aeg_bul_ec).legal?
  end

  test 'correct support of move is legal' do
    assert orders(:f_aeg_support_a_con_bul).legal?
  end

  test 'support for a move that is not performed is not legal' do
    assert_not orders(:a_ber_support_a_mun_hold).legal?
  end

  test 'support for a supporting unit as a hold is legal' do
    assert orders(:f_eng_support_f_pic_hold).legal?
  end

  test 'support from an army to fleet in sea is illegal' do
    assert_not orders(:a_con_support_f_aeg_eas).legal?
  end

  test 'support from a fleet to army on land is illegal' do
    assert_not orders(:f_bre_support_a_pic_par).legal?
  end

end
