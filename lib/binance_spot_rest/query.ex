defprotocol BinanceSpotRest.Query do
  def validate(query)
  def prepare(query)
end
