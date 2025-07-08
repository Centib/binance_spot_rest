defmodule BinanceSpotRest do
  @moduledoc """
  Entry point for making Binance Spot REST API requests.
  """

  import Loe

  @spec request(struct(), keyword()) :: {:ok, term()} | {:error, term()}
  @doc """
  Processes a query struct into a request and optionally validates or sends it.

  ## Options

    - `:validate` (default: `true`) — whether to validate the query before preparing.
    - `:execute` (default: `true`) — whether to actually execute the HTTP request or return the request struct.

  ## Examples

      BinanceSpotRest.request(query)
      BinanceSpotRest.request(query, validate: false)
      BinanceSpotRest.request(query, execute: false)
  """
  def request(q, opts \\ []) do
    validate = Keyword.get(opts, :validate, true)
    execute = Keyword.get(opts, :execute, true)

    q
    ~>> maybe_validate(validate)
    ~>> BinanceSpotRest.Query.prepare()
    ~>> BinanceSpotRest.Client.create_request()
    ~>> maybe_make_request(execute)
  end

  defp maybe_validate(q, true), do: q ~>> BinanceSpotRest.Query.validate()
  defp maybe_validate(q, false), do: q

  defp maybe_make_request(r, true), do: r ~>> BinanceSpotRest.Client.make_request()
  defp maybe_make_request(r, false), do: r
end
