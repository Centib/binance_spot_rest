defmodule BinanceSpotRest.Client.Security do
  @moduledoc false

  @none BinanceSpotRest.Enums.SecurityType._NONE()
  @trade BinanceSpotRest.Enums.SecurityType._TRADE()
  @user_data BinanceSpotRest.Enums.SecurityType._USER_DATA()
  @user_stream BinanceSpotRest.Enums.SecurityType._USER_STREAM()

  defguard is_security_type(st) when st in [@none, @trade, @user_data, @user_stream]

  defguard is_api_key(st) when st in [@trade, @user_data, @user_stream]
  defguard is_no_api_key(st) when st in [@none]

  defguard is_signature(st) when st in [@trade, @user_data]
  defguard is_no_signature(st) when st in [@none, @user_stream]
end
