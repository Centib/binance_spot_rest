import Config

config :binance_spot_rest,
  base_url: System.get_env("BINANCE_SPOT_REST_BASE_URL", "https://testnet.binance.vision"),
  api_key: System.get_env("BINANCE_SPOT_REST_API_KEY"),
  secret_key: System.get_env("BINANCE_SPOT_REST_SECRET_KEY")
