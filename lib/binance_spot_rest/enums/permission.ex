defmodule BinanceSpotRest.Enums.Permission do
  @moduledoc """
  Defines account and symbol permissions for the Binance Spot REST API.

  This enum corresponds to the `permissions` field in the
  [Binance API – Exchange Information](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#exchange-information).

  Permissions indicate which types of trading are allowed for a given symbol.

  Supported values:

    * `:SPOT` – Spot trading permission.
      *Note:* This is the **only permission available on Testnet.*

    * `:MARGIN` – Margin trading permission.

    * `:LEVERAGED` – Leveraged token trading permission.

    * `:TRD_GRP_002` .. `:TRD_GRP_025` – Internal Binance trading groups, used
      to define more granular or special trading permissions.
      These may vary by account type and are not typically used in standard
      Spot/Margin API operations.
  """
  use Numa, [
    # only :SPOT is available for testnet
    :SPOT,
    :MARGIN,
    :LEVERAGED,
    :TRD_GRP_002,
    :TRD_GRP_003,
    :TRD_GRP_004,
    :TRD_GRP_005,
    :TRD_GRP_006,
    :TRD_GRP_007,
    :TRD_GRP_008,
    :TRD_GRP_009,
    :TRD_GRP_010,
    :TRD_GRP_011,
    :TRD_GRP_012,
    :TRD_GRP_013,
    :TRD_GRP_014,
    :TRD_GRP_015,
    :TRD_GRP_016,
    :TRD_GRP_017,
    :TRD_GRP_018,
    :TRD_GRP_019,
    :TRD_GRP_020,
    :TRD_GRP_021,
    :TRD_GRP_022,
    :TRD_GRP_023,
    :TRD_GRP_024,
    :TRD_GRP_025
  ]
end
