require 'test_helper'

class TradesControllerTest < ActionController::TestCase
  setup do
    @trade = trades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trade" do
    assert_difference('Trade.count') do
      post :create, trade: { actual_amount: @trade.actual_amount, agent_number: @trade.agent_number, amount: @trade.amount, base_commission: @trade.base_commission, biz_count: @trade.biz_count, commission: @trade.commission, merchant_number: @trade.merchant_number, profit: @trade.profit, terminal_number: @trade.terminal_number, trade_date: @trade.trade_date }
    end

    assert_redirected_to trade_path(assigns(:trade))
  end

  test "should show trade" do
    get :show, id: @trade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trade
    assert_response :success
  end

  test "should update trade" do
    patch :update, id: @trade, trade: { actual_amount: @trade.actual_amount, agent_number: @trade.agent_number, amount: @trade.amount, base_commission: @trade.base_commission, biz_count: @trade.biz_count, commission: @trade.commission, merchant_number: @trade.merchant_number, profit: @trade.profit, terminal_number: @trade.terminal_number, trade_date: @trade.trade_date }
    assert_redirected_to trade_path(assigns(:trade))
  end

  test "should destroy trade" do
    assert_difference('Trade.count', -1) do
      delete :destroy, id: @trade
    end

    assert_redirected_to trades_path
  end
end
