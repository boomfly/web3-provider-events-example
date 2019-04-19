# Used

    node - 8.15.1 / 10.15.3
    web3 - 1.0.0-beta.52

# Install npm dependencies

    npm i

# One terminal to build js

    npm run server

# Second terminal to run nodemon

    npm start

# Sample output

On starup `connect` event fired as expected:

    [Ethereum] provider "connect" event
    pending tx 0xb8c7032fd7a05d7606541deec57940b6680dd52409bdb6125e6eb121dc7e4e3b
    pending tx 0x8bdb5473779f7aa37e0bf2eacfa2d017280ba16166bbd24a7dfb4e80ca8b4f45
    pending tx 0x0b64b3841fb115bfa25c77072d2402fd9cdb61f20eebc2561354808902a5c74e
    pending tx 0x0f9defb78956072193a1fee2b53d730513f22b4ee673ff90b90e0446e3afc67d
    pending tx 0x3e3e5a3407b4f38aff3b649b79ac0b57ebd49e637902f67085b3dff01c01aad0

    pending tx 0x88d5ed656b1ae27eec4846cca58dff1eb2da87982d4fff5aa105d2051d214999
    pending tx 0xefd02a0d9b95e91fa86f4b8ab10b8a0aef52cb43f36691a363da54ab14253b1a
    pending tx 0xb347153c82b73a74b20135e3147e82bb2a04005cb1f6b639a6799bb43666ad7a

`connect` occur normally and new pending start firing. Then turn network off. It wait some time and fire `error` event.

    Error while cheking connecion Error: Connection error: Timeout exceeded
    Check connection connected false, isConnecting false, latestBlock undefined

    Error while cheking connecion Error: Connection error: Connection is not open on send()
    Check connection connected false, isConnecting false, latestBlock undefined
    [Ethereum] provider "error" event { error:
    _Event {
     type: 'error',
     isTrusted: false,
     _yaeti: true,
     target:
      W3CWebSocket {
        _listeners: [Object],
        addEventListener: [Function: _addEventListener],
        removeEventListener: [Function: _removeEventListener],
        dispatchEvent: [Function: _dispatchEvent],
        _url: 'wss://ropsten.infura.io/ws',
        _readyState: 3,
        _protocol: undefined,
        _extensions: '',
        _bufferedAmount: 0,
        _binaryType: 'arraybuffer',
        _connection: undefined,
        _client: [WebSocketClient] },
     cancelable: true,
     stopImmediatePropagation: [Function] } }
     Error while cheking connecion Error: Connection error: Connection is not open on send()
     Check connection connected false, isConnecting false, latestBlock undefined

Next enable network again and here is the issue: `connect` event does not fired and subscriptions do not resubscribed. But socket connected and next calls to api will works as expected. Here logs:

    Error while cheking connecion Error: Connection error: Connection is not open on send()
    Check connection connected false, isConnecting false, latestBlock undefined
    Error while cheking connecion Error: Connection error: Connection is not open on send()
    Check connection connected false, isConnecting false, latestBlock undefined
    Check connection connected true, isConnecting false, latestBlock 5435004
    Check connection connected true, isConnecting false, latestBlock 5435005
