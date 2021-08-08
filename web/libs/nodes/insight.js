import axios from 'axios'

const apiPrefix = 'https://testnet.htmlcoin.com/api' //'https://explorer.htmlcoin.com/api'

const _get = async url => {
  return (await axios.get(apiPrefix + url)).data
}

const _post = async (url, data) => {
  return (await axios.post(apiPrefix + url, data)).data
}

export default {
  async getInfo (address) {
    return _get(`/addr/${address}`)
  },

  async getHrc20 (address) {
    return _get(`/erc20/balances?balanceAddress=${address}`)
  },

  async getTokenInfo (contractAddress) {
   return _get(`/erc20/${contractAddress}`)
  },

  async getTxList (address) {
    return _get(`/txs/?address=${address}`)
  },

  async getUtxoList (address) {
    return (await _get(`/addr/${address}/utxo`)).map(item => {
      return {
        address: item.address,
        txid: item.txid,
        confirmations: item.confirmations,
        isStake: item.isStake,
        amount: item.amount,
        value: item.satoshis,
        hash: item.txid,
        pos: item.vout,
      }
    })
  },

  async sendRawTx (rawTx) {
    return (await (_post('/tx/send', { rawtx: rawTx }))).txid
  },

  async fetchRawTx (txid) {
    return (await _get(`/rawtx/${txid}`)).rawtx
  },

  getTxExplorerUrl (tx) {
    return `https://testnet.htmlcoin.com/tx/${tx}`
  },

  getAddrExplorerUrl (addr) {
    return `https://testnet.htmlcoin.com/address/${addr}`
  },

  async callContract (address, encodedData) {
    return (await _get(`/contracts/${address}/hash/${encodedData}/call`)).executionResult.output
  },
}