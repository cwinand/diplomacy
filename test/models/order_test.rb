require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test 'move to bordered province is legal' do
    orders = Order.create([
      {
        start: 'par',
        end: 'bur',
        order_type: 'move',
        turn: turns(:first),
        game_country: game_countries(:game_country_fr),
        unit: units(:fr_army_par)
      },
      {
        start: 'con',
        end: 'bul',
        order_type: 'move',
        turn: turns(:first),
        game_country: game_countries(:game_country_tr),
        unit: units(:tr_army_con)
      },
      {
        start: 'eas',
        end: 'aeg',
        order_type: 'move',
        turn: turns(:first),
        game_country: game_countries(:game_country_tr),
        unit: units(:tr_fleet_eas)
      }
    ])

    assert orders[0].legal?
    assert orders[1].legal?
    assert orders[2].legal?
  end

  test 'move fleet to coast/correct split coast is legal' do
    order = Order.create(
      start: 'aeg',
      end: 'con',
      order_type: 'move',
      turn: turns(:first),
      game_country: game_countries(:game_country_tr),
      unit: units(:tr_fleet_aeg)
    )

    assert order.legal?

    order.update(
      end: 'bul',
      end_coast: 'sc'
    )

    assert order.legal?
  end

  test 'a fleet in portugal can move to either spanish coast' do
    order = Order.create(
      start: 'por',
      end: 'spa',
      end_coast: 'nc',
      order_type: 'move',
      turn: turns(:first),
      game_country: game_countries(:game_country_it),
      unit: units(:it_fleet_por)
    )

    assert order.legal?

    order.update(end_coast: 'sc')

    assert order.legal?
  end

  test 'move to unbordered province is illegal' do
    order = Order.create(
      start: 'rom',
      end: 'pie',
      order_type: 'move',
      turn: turns(:first),
      game_country: game_countries(:game_country_it),
      unit: units(:it_army_rom)
    )

    assert_not order.legal?
  end

  test 'move fleet to wrong split coast is illegal' do
    order = Order.create(
      start: 'wes',
      end: 'spa',
      order_type: 'move',
      turn: turns(:first),
      game_country: game_countries(:game_country_it),
      unit: units(:it_fleet_wes)
    )

    assert_not order.legal?

    order.update( end_coast: 'nc' )

    assert_not order.legal?
  end

  test 'correct support of move is legal' do
    orders = Order.create([
      {
        start: 'lon',
        end: 'wal',
        order_type: 'move',
        turn: turns(:first),
        game_country: game_countries(:game_country_en),
        unit: units(:en_army_lon)
      },
      {
        start: 'eng',
        end: 'eng',
        order_type: 'support',
        turn: turns(:first),
        game_country: game_countries(:game_country_en),
        unit: units(:fr_fleet_eng),
        support_start: 'lon',
        support_end: 'wal',
        support_order_type: 'move',
        support_order_unit_type: 'a'
      }
    ])

    assert orders[0].legal?
    assert orders[1].legal?
  end

  test 'support for a move that is not performed is not legal' do
    orders = Order.create([
      {
        start: 'mun',
        end: 'sil',
        order_type: 'move',
        turn: turns(:first),
        game_country: game_countries(:game_country_de),
        unit: units(:de_army_mun)
      },
      {
        start: 'ber',
        end: 'ber',
        order_type: 'support',
        turn: turns(:first),
        game_country: game_countries(:game_country_de),
        unit: units(:de_army_ber),
        support_start: 'mun',
        support_end: 'mun',
        support_order_type: 'hold',
        support_order_unit_type: 'a'
      }
    ])

    assert_not orders[1].legal?
  end

  test 'support for a supporting unit as a hold is legal' do
    orders = Order.create([
      {
        start: 'spa',
        end: 'spa',
        order_type: 'support',
        turn: turns(:first),
        game_country: game_countries(:game_country_fr),
        unit: units(:fr_army_spa),
        support_start: 'por',
        support_end: 'por',
        support_order_type: 'hold',
        support_order_unit_type: 'a'
      },
      {
        start: 'por',
        end: 'por',
        order_type: 'support',
        turn: turns(:first),
        game_country: game_countries(:game_country_fr),
        unit: units(:fr_army_por),
        support_start: 'spa',
        support_end: 'spa',
        support_order_type: 'hold',
        support_order_unit_type: 'a'
      }
    ])

    assert orders[0].legal?
    assert orders[1].legal?
  end

  test 'support from an army to fleet in sea is illegal' do
    orders = Order.create([
      {
        start: 'yor',
        end: 'yor',
        order_type: 'support',
        turn: turns(:first),
        game_country: game_countries(:game_country_en),
        unit: units(:en_army_yor),
        support_start: 'nth',
        support_end: 'nth',
        support_order_type: 'hold',
        support_order_unit_type: 'f'
      },
      {
        start: 'nth',
        end: 'nth',
        order_type: 'hold',
        turn: turns(:first),
        game_country: game_countries(:game_country_en),
        unit: units(:en_fleet_nth)
      }
    ])

    assert_not orders[0].legal?
  end

  test 'support from a fleet to army on land is illegal' do
    orders = Order.create([
      {
        start: 'pic',
        end: 'par',
        order_type: 'move',
        turn: turns(:first),
        game_country: game_countries(:game_country_fr),
        unit: units(:fr_army_pic)
      },
      {
        start: 'bre',
        end: 'bre',
        order_type: 'support',
        turn: turns(:first),
        game_country: game_countries(:game_country_fr),
        unit: units(:fr_fleet_bre),
        support_start: 'pic',
        support_end: 'par',
        support_order_type: 'move',
        support_order_unit_type: 'a'
      }
    ])

    assert_not orders[1].legal?
  end

end
