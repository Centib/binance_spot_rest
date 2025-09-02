defprotocol BinanceSpotRest.Query do
  @moduledoc """
  Protocol for endpoint query structs.

  Provides two main functions to handle query validation and preparation
  before sending requests via `BinanceSpotRest.Client`.

  ## Functions

    * `validate(query)` - Validates the query struct.
      Returns `{:ok, query}` if valid or `{:error, reason}` if invalid.

    * `prepare(query)` - Prepares the query for sending.
      Returns `{:ok, %BinanceSpotRest.Query.RequestSpec{}}` containing
      metadata and the original query struct.

  ## Usage Example

      iex> import Loe
      iex> query = %BinanceSpotRest.Endpoints.General.Time.Query{}
      iex> query ~>> BinanceSpotRest.Query.validate()
      {:ok, %BinanceSpotRest.Endpoints.General.Time.Query{}}
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

  **Note:** All endpoint query structs should implement this protocol.
  """

  def validate(query)
  def prepare(query)
end
