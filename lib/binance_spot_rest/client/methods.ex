defmodule BinanceSpotRest.Client.Methods do
  @moduledoc false

  @get BinanceSpotRest.Enums.Method._get()
  @post BinanceSpotRest.Enums.Method._post()
  @put BinanceSpotRest.Enums.Method._put()
  @delete BinanceSpotRest.Enums.Method._delete()

  defguard is_method(m) when m in [@get, @post, @put, @delete]
end
