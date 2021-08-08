import axios from 'axios'

const apiPrefix = 'https://j7nmvpu2a5.execute-api.us-east-1.amazonaws.com/latest/api'

const _get = async url => {
  return (await axios.get(apiPrefix + url)).data
}

const _post = async (url, data) => {
  return (await axios.post(apiPrefix + url, data)).data
}

export default {
  async getRanking () {
    return _get(`/balances/rank`)
  },

  async updateBalance (_address, _balance) {
    return (await (_post('/balances', { address: _address, balance: _balance })))
  }

}