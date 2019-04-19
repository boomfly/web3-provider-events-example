import Web3 from 'web3'

wsUrl = 'wss://ropsten.infura.io/ws'

options = {
  timeout: 15000
  # headers:
  #   authorization: 'Basic #{token}'
  clientConfig:
    closeTimeout: 1000
    keepalive: true
    keepaliveInterval: 20000
    dropConnectionOnKeepaliveTimeout: true
    keepaliveGracePeriod: 5000
}

provider = new Web3.providers.WebsocketProvider(wsUrl, options)

onConnect = ->
  console.log '[Ethereum] provider "connect" event'
onError = (error) ->
  console.error '[Ethereum] provider "error" event', {error}
onClose = (error) ->
  console.error '[Ethereum] provider "close" event', {error}

provider.on 'connect', onConnect
provider.on 'error', onError
provider.on 'close', onClose

web3 = new Web3(provider)

web3.eth.subscribe 'pendingTransactions'
.on 'data', (txHash) -> console.log 'pending tx', txHash

setInterval ->
  try
    block = await web3.eth.getBlock('latest')
  catch error
    console.error 'Error while cheking connecion', error.toString()
  console.log "Check connection connected #{provider.connected}, isConnecting #{provider.isConnecting()}, latestBlock #{block?.number}"
, 15000
