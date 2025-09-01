defmodule BinanceSpotRest.Endpoints.MarketData.AggTrades.Endpoint do
  @moduledoc false

  def metadata do
    %BinanceSpotRest.Query.EndpointMetadata{
      endpoint: "/api/v3/aggTrades",
      method: BinanceSpotRest.Enums.Method._get(),
      security_type: BinanceSpotRest.Enums.SecurityType._NONE()
    }
  end
end
