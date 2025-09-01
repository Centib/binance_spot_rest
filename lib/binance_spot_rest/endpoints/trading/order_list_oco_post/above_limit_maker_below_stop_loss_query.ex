defmodule BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.AboveLimitMakerBelowStopLossQuery do
  @moduledoc """
             Order List Oco (post) - Above limit maker below stop loss query

             """ <> BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Endpoint.moduledoc()

  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker, as: Above
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.StopLoss, as: Below

  defstruct BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.UseShared.fields(Above, Below,
              side: BinanceSpotRest.Enums.Side._SELL()
            ) ++
              BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.UseShared.validation(Above, Below)
        |> Valpa.value_of_values(:side, [BinanceSpotRest.Enums.Side._SELL()])
        |> BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Common.validation()
        |> Valpa.map_compare_decimal_keys({:>, :abovePrice, :belowStopPrice})

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderListOcoPost.Endpoint.metadata(),
        query: q
      }
  end
end
