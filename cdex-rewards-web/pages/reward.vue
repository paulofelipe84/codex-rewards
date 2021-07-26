<template>
  <div>
    <body>
      <div class="heroSection">
        <div class="container">
          <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
              <a class="navbar-brand" href="#"><img src="../assets/logo.png" alt="" class="logo" srcset=""></a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <!-- <span class="navbar-toggler-icon"></span> -->
                <img src="../assets/ham-icon.svg" alt="">
              </button>
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                  <li class="nav-item">
                    <a class="nav-link" href="/">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="#">Reward Members</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#">Loyalty Program</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#">Reward Members Audit</a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>

          <div class="row text-center my-4 justify-content-center">
            <h1 class="fw-bold ">CDEX Rewards Members </h1>
            <p class="width">Lorem ipsum dolor sit, amet consectetur adipisicing elit. Excepturi, repellendus! Temporibus,
              tenetur perferendis sit quam velit adipisci quasi repellat nisi accusantium facere soluta! </p>
          </div>
          <div class="row mb-3 my-md-5">
            <div class="col-md-4 my-2 my-md-0">
              <div class="ccard bg-white p-md-4 p-3">
                <img src="../assets/peace_icon.png" alt="" class="pb-4" srcset="" width="45px">
                <p class="my-2">Total Reward Members</p>
                <h4 class="fw-bold">{{ totalMembers }}</h4>
              </div>
            </div>
            <div class="col-md-4 my-2 my-md-0">
              <div class="ccard bg-dark p-md-4 p-3 text-white ">
                <img src="../assets/stats_icon.png" alt="" class="pb-4" srcset="" width="45px">
                <p class="my-2">Staking Yield (Dynamic APR)</p>
                <h4 class="fw-bold">{{ yearlyYield.toLocaleString('en-US', { style: 'decimal', maximumFractionDigits: 2 }) }}%</h4>
              </div>
            </div>
            <div class="col-md-4 my-2 my-md-0">
              <div class="ccard p-md-4 p-3 bg-prime">
                <img src="../assets/exchange_icon.png" alt="" class="pb-4" srcset="" width="45px">
                <p class="my-2">CDEX Total Rewards</p>
                <h4 class="fw-bold">{{ Math.floor(totalRewardsAmount).toLocaleString() }}</h4>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="calcSection">
        <div class="container">
          <div class="row mb-5">
            <div class="col-md-8">

              <div class="calcCard p-4">
                <p>Estimated Reward Calculator</p>
                <hr>
                <label for="" class="text-muted fw-bold my-2">Enter staked amount in CDEX</label><br>
                <input type="text" v-model.lazy="calculationAmount" v-money="money" @keydown="clearEstimatedCalculations"><br><br>
                <label  class="text-muted fw-bold">Select a staking time</label><br>
                <div class="mb-4">
                  <v-radio-group
                    v-model="stakingTime"
                    row
                    @change="calculateEstimatedReturns(yearlyReward, amountStaked, stakingTime)"
                  >
                    <v-radio value="1month">
                      <template v-slot:label>
                        <label for="1month" class="radio">1 month</label>
                      </template>
                    </v-radio>
                    <v-radio value="3months">
                      <template v-slot:label>
                        <label for="3months" class="radio">3 months</label>
                      </template>
                    </v-radio>
                    <v-radio value="6months">
                      <template v-slot:label>
                        <label for="6months" class="radio">6 months</label>
                      </template>
                    </v-radio>
                    <v-radio value="1year">
                      <template v-slot:label>
                        <label for="1year" class="radio">1 year</label>
                      </template>
                    </v-radio>
                  </v-radio-group>
                </div>
                <p>Estimated Calculated Rewards</p>
                <hr>
                <div class="row">
                  <div class="col-md-4 col">
                    <p>Estimated Return</p>
                    <h2 class="prime fw-bold">{{ Math.floor(estimatedReturns).toLocaleString() }} CDEX</h2>
                  </div>
                  <div class="col-md-4 col">
                    <p>Final Value</p>
                    <h2 class="prime fw-bold">{{ Math.floor(totalBalanceAfterReturns).toLocaleString() }} CDEX</h2>
                  </div>
                  <div class="col-md-4 mt-md-0 mt-3">
                    <p>ROI</p>
                    <h2 class="prime fw-bold">{{ Math.floor(returnOverInvestment).toLocaleString() }}%</h2>
                  </div>
                </div>
              </div>

              <div class="mt-md-4 mb-md-0 my-3">
                <div class="row p-md-1 p-0 m-0 justify-content-center call2action">
                  <!-- <img src="../assets/call2action.svg" alt="" class="img-fluid image position-absolute" srcset="" > -->
                  <div class="align-self-center col-12 text-center my-4 justify-content-center">
                    <h1 class="fw-bold text-white m-2 px-md-5">Stake your CDEX tokens and earn rewards</h1>
                    <button class="btn cbtn btn-dark m-3">Buy your CDEX Tokens</button>
                  </div>
                </div>
              </div>

            </div>
            <div class="col-md-4">

              <!-- add or remove dark-leader css class next to calcCard for dark version or light version of Leaderboard -->

              <div class="calcCard px-4 pt-4 h-100 dark-leader">
                <p>Leaderboard for Top wallets</p>
                <hr> 
                <!-- use for loop here for card item -->
                <div class="lboard-item-card p-3 my-3">
                  <h6 class="fw-bold">0xd6f1c564a6c76934a84e594c89c9964152839f68</h6>
                  <div class="row">
                    <div class="col-8">
                      <h6 class="m-0">Rewards - 45,000 CDEX</h6>
                    </div>
                    <div class="col-4">
                      <p class="m-0">26 hours ago</p>
                    </div>
                  </div>
                </div>
                
                <div class="lboard-item-card p-3 my-3">
                  <h6 class="fw-bold">0xd6f1c564a6c76934a84e594c89c9964152839f68</h6>
                  <div class="row">
                    <div class="col-8">
                      <h6 class="m-0">Rewards - 45,000 CDEX</h6>
                    </div>
                    <div class="col-4">
                      <p class="m-0">26 hours ago</p>
                    </div>
                  </div>
                </div>

                <div class="lboard-item-card p-3 my-3">
                  <h6 class="fw-bold">0xd6f1c564a6c76934a84e594c89c9964152839f68</h6>
                  <div class="row">
                    <div class="col-8">
                      <h6 class="m-0">Rewards - 45,000 CDEX</h6>
                    </div>
                    <div class="col-4">
                      <p class="m-0">26 hours ago</p>
                    </div>
                  </div>
                </div>
                
                <div class="lboard-item-card p-3 my-3">
                  <h6 class="fw-bold">0xd6f1c564a6c76934a84e594c89c9964152839f68</h6>
                  <div class="row">
                    <div class="col-8">
                      <h6 class="m-0">Rewards - 45,000 CDEX</h6>
                    </div>
                    <div class="col-4">
                      <p class="m-0">26 hours ago</p>
                    </div>
                  </div>
                </div>

                <div class="lboard-item-card p-3 my-3">
                  <h6 class="fw-bold">0xd6f1c564a6c76934a84e594c89c9964152839f68</h6>
                  <div class="row">
                    <div class="col-8">
                      <h6 class="m-0">Rewards - 45,000 CDEX</h6>
                    </div>
                    <div class="col-4">
                      <p class="m-0">26 hours ago</p>
                    </div>
                  </div>
                </div>
                
                <div class="lboard-item-card p-3 my-3">
                  <h6 class="fw-bold">0xd6f1c564a6c76934a84e594c89c9964152839f68</h6>
                  <div class="row">
                    <div class="col-8">
                      <h6 class="m-0">Rewards - 45,000 CDEX</h6>
                    </div>
                    <div class="col-4">
                      <p class="m-0">26 hours ago</p>
                    </div>
                  </div>
                </div>
                <!-- till here  -->
              </div>
            </div>
          </div>
        </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
    <footer class="footer bg-dark position-relative overflow-hidden">
      <img src="../assets/cdex-logo-white.png" class="position-absolute footIcon" alt="" srcset="" width="400px">
      <div class="container footer">
        <div class="row pt-5 mx-md-5">
          <div class="col-md-6">
            <img src="../assets/logo-white.png" alt="" class="my-3" width="100px">
            <h5 class="prime fw-bold">HOME BASE</h5>
            <hr class="w-md-75 text-white">
            <p class="text-white lh-1_8 fw-lighter w-md-75">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi
              tincidunt nulla integer congue sollicitudin sit bibendum. Facilisis</p>
          </div>
          <div class="col-md-6 align-self-center">
            <div class="ul">
              <a href="#" class="nav-link text-white">About the token</a>
              <a href="#" class="nav-link text-white">Reward Members</a>
              <a href="#" class="nav-link text-white">Loyalty Program</a>
              <a href="#" class="nav-link text-white">Tool Kit</a>
              <a href="#" class="nav-link text-white">Reward Member Audit</a>
            </div>
          </div>

        </div>
        <div class="row py-4 text-center">
          <p class="text-muted">Copyright 2021 | CODEX </p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
  import utils from '../libs/utils'
  import { VMoney } from 'v-money'

  const contractAddress = '1519aa50473b2aa25cb1d960d0a1784f91f015b3' // testnet

  const abiJson = JSON.parse(
    '[{"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "earned", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "rewards", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_owner", "type": "address"} ], "name": "nominateNewOwner", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_paused", "type": "bool"} ], "name": "setPaused", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "totalSupply", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "getRewardForDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "withdraw", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyBonusTier3", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyBonusTier1", "type": "uint256"}, {"name": "_loyaltyBonusTier2", "type": "uint256"}, {"name": "_loyaltyBonusTier3", "type": "uint256"} ], "name": "setLoyaltyBonusTiers", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyBonusTotal", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardsDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "reward", "type": "uint256"} ], "name": "notifyRewardAmount", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [], "name": "getReward", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedLoyaltyBonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "CDEXToken", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "nominatedOwner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyTier1", "type": "uint256"}, {"name": "_loyaltyTier2", "type": "uint256"}, {"name": "_loyaltyTier3", "type": "uint256"} ], "name": "setLoyaltyTiers", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "paused", "outputs": [{"name": "", "type": "bool"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier1", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "balanceOf", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier2", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "totalMembers", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "acceptOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [{"name": "a", "type": "uint256"}, {"name": "b", "type": "uint256"} ], "name": "min", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardRate", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastTimeRewardApplicable", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "userRewardPerTokenPaid", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "owner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastPauseTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "stake", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyBonusTier2", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastUpdateTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_rewardsDuration", "type": "uint256"} ], "name": "setRewardsDuration", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerToken", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier3", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyBonusTier1", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "depositTokens", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerTokenStored", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "exit", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "periodFinish", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedRewardTokens", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"inputs": [{"name": "_owner", "type": "address"}, {"name": "_CDEXToken", "type": "address"} ], "payable": false, "stateMutability": "nonpayable", "type": "constructor"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardAdded", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Staked", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Withdrawn", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "loyaltyBonus", "type": "uint256"} ], "name": "LoyaltyBonusPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newDuration", "type": "uint256"} ], "name": "RewardsDurationUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "token", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Recovered", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "sender", "type": "address"}, {"indexed": false, "name": "receiver", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"}, {"indexed": false, "name": "bonus", "type": "uint256"} ], "name": "RewardsAndBonusDeposited", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyTier1", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier2", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier3", "type": "uint256"} ], "name": "LoyaltyTiersUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyBonusTier1", "type": "uint256"}, {"indexed": false, "name": "loyaltyBonusTier2", "type": "uint256"}, {"indexed": false, "name": "loyaltyBonusTier3", "type": "uint256"} ], "name": "LoyaltyBonusTiersUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "isPaused", "type": "bool"} ], "name": "PauseChanged", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerNominated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "oldOwner", "type": "address"}, {"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerChanged", "type": "event"} ]',
  )

  export default {
    head () {
      return {
        link: [
          { 
            rel: 'stylesheet', 
            href: 'https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css', 
            crossorigin: 'anonymous',
            integrity: 'sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC' 
          },
          { 
            rel: 'stylesheet', 
            href: 'https://cdn.jsdelivr.net/npm/@xz/fonts@1/serve/plus-jakarta-display.min.css'
          },
          { 
            rel: 'stylesheet', 
            href: 'https://cdn.jsdelivr.net/npm/@xz/fonts@1/serve/plus-jakarta-text.min.css'
          }
        ],
        title: 'CODEX'
      }
    },
    
    async mounted () {
      await this.getStats()
      //await this.getRanking()
    },
    
    data () {
      return {
        loadingStats: true,
        yearlyReward: 0,
        amountStaked: 0,
        yearlyYield: 0,
        totalRewardsAmount: 0,
        totalMembers: 0,
        calculationAmount: 500000,
        money: {
          decimal: '.',
          thousands: ',',
          prefix: '',
          suffix: '',
          precision: 0,
          masked: false /* doesn't work with directive */
        },
        estimatedReturns: 0,
        totalBalanceAfterReturns: 0,
        returnOverInvestment: 0,
        stakingTime: '1year'
      }
    },

    directives: {
      money: VMoney
    },

    methods: {
      async getStats () {
        var self = this
        try {
          var decodedResult = await utils.callContractFunction(
            contractAddress,
            abiJson,
            'totalSupply',
            [],
          )
          self.amountStaked = decodedResult[0] / 1e8

          decodedResult = await utils.callContractFunction(
            contractAddress,
            abiJson,
            'rewardRate',
            [],
          )
          // RewardRate: Number of tokens rewarded per second
          self.yearlyReward = decodedResult[0] / 1e8 * 31536000 // 1 Year in seconds
          
          decodedResult = await utils.callContractFunction(
            contractAddress,
            abiJson,
            'depositedRewardTokens',
            [],
          )
          let depositedRewardTokens = decodedResult[0] / 1e8

          self.totalRewardsAmount = depositedRewardTokens
          self.yearlyYield = self.yearlyReward / self.amountStaked * 100

          decodedResult = await utils.callContractFunction(
            contractAddress,
            abiJson,
            'totalMembers',
            [],
          )
          self.totalMembers = decodedResult[0]

          self.calculateEstimatedReturns(self.yearlyReward, self.amountStaked, '1year')

          self.loadingStats = false
        } catch (e) {
          console.log('Error reading stats: ' + e.stack || e.toString() || e)
          alert(e.message || e)
        }
      },

      calculateEstimatedReturns (yearlyReward, amountStaked, period) {

        var self = this
        
        var userBalanceToAdd = parseInt(self.calculationAmount.replace(/,/g, ''))
        var newYearlyYield = yearlyReward / (amountStaked + userBalanceToAdd)
        var yearlyReturns = userBalanceToAdd * newYearlyYield
        
        switch (period) {
          case '1year':
            self.estimatedReturns = yearlyReturns
            break
          case '6months':
            self.estimatedReturns = yearlyReturns / 2
            break
          case '3months':
            self.estimatedReturns = yearlyReturns / 4
            break
          case '1month':
            self.estimatedReturns = yearlyReturns / 12
            break
          default:
            self.estimatedReturns = yearlyReturns
        }
        
        self.totalBalanceAfterReturns = self.estimatedReturns + userBalanceToAdd
        self.returnOverInvestment = self.estimatedReturns / userBalanceToAdd * 100
      },

      clearEstimatedCalculations () {
        var self = this
        
        self.estimatedReturns = 0,
        self.totalBalanceAfterReturns = 0
        self.returnOverInvestment = 0
        self.stakingTime = false

      },

      async getRanking () {
        try {
          var self = this
        } catch(e) {
          console.log('Error reading ranking: ' + e.stack || e.toString() || e)
          alert(e.message || e)
        }
      }
    }
  }
</script>
<style scoped src="../assets/css/reward.scss" lang="scss" />