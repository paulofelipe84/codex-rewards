import Wallet from './wallet'

let wallet = false

function getWallet() {
  return wallet
}

function setWallet(wal) {
  wallet = wal
}

function restoreFromWif(wif) {
  return wallet = Wallet.restoreFromWif(wif)
}

export default {
  getWallet,
  setWallet,
  restoreFromWif
}
