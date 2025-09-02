defmodule BinanceSpotRest.Query.RequestSpec do
  @moduledoc """
  Low-level request specification (internal/advanced use).

  This struct represents a full request specification that is returned by
  `BinanceSpotRest.Query.prepare/1`. It includes metadata about the endpoint
  and the actual query struct.

  ## Workflow

  1. Start with a query struct for an endpoint:

      iex> query = %BinanceSpotRest.Endpoints.General.Time.Query{}

  2. Validate the query:

      iex> query ~>> BinanceSpotRest.Query.validate()
      {:ok, %BinanceSpotRest.Endpoints.General.Time.Query{}}

  3. Prepare the request spec:

      iex> query ~>> BinanceSpotRest.Query.validate() ~>> BinanceSpotRest.Query.prepare()
      {:ok,
       %BinanceSpotRest.Query.RequestSpec{
         metadata: %BinanceSpotRest.Query.EndpointMetadata{
           endpoint: "/api/v3/time",
           method: :get,
           security_type: :NONE
         },
         query: %BinanceSpotRest.Endpoints.General.Time.Query{}
       }}

  ## Fields

    * `:metadata` - `BinanceSpotRest.Query.EndpointMetadata` struct describing the endpoint, HTTP method,
      and security type
    * `:query` - The query struct containing parameters for the request

  **Note:** Typically created by `Query.prepare/1` and used internally by `BinanceSpotRest.Client.create_request/2`.
  """

  @enforce_keys [:metadata, :query]
  defstruct [:metadata, :query]
end
