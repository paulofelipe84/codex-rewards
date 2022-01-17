import axios from 'axios'

const apiPrefix = 'https://explorer.htmlcoin.com/api' //'http://cdexplorer.net:7001'

const _get = async url => {
  return (await axios.get(apiPrefix + url)
    .catch(function (error) {
      if (error.response) {
        // Request made and server responded
        console.log(error.response.data);
        console.log(error.response.status);
        console.log(error.response.headers);
      } else if (error.request) {
        // The request was made but no response was received
        console.log(error.request);
      } else {
        // Something happened in setting up the request that triggered an Error
        console.log('Error', error.message);
      }
    })
  ).data
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
    return `http://cdexplorer.net/tx/${tx}`
  },

  getAddrExplorerUrl (addr) {
    return `http://cdexplorer.net/address/${addr}`
  },

  async callContract (address, encodedData) {
    return (await _get(`/contracts/${address}/hash/${encodedData}/call`)).executionResult.output
    // TODO: Codex api
    //return (await _get(`/contract/${address}/call?data=${encodedData}`)).executionResult.output
  },
}