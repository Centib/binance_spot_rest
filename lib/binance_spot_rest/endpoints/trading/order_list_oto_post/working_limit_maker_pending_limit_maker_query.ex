defmodule BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.WorkingLimitMakerPendingLimitMakerQuery do
  @moduledoc """
  Order list oto: working limit maker pending limit maker query
  """

  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker, as: Working
  alias BinanceSpotRest.Endpoints.Trading.OrderPost.Shared.LimitMaker, as: Pending

  defstruct BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.UseShared.fields(Working, Pending) ++
              BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Common.fields()

  defimpl BinanceSpotRest.Query do
    def validate(q),
      do:
        q
        |> BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.UseShared.validation(
          Working,
          Pending
        )
        |> BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Common.validation()

    def prepare(q),
      do: %BinanceSpotRest.Query.RequestSpec{
        metadata: BinanceSpotRest.Endpoints.Trading.OrderListOtoPost.Endpoint.metadata(),
        query: q
      }
  end
end
