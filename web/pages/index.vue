<template>
  <div>
    <body>
      <div class="heroSection">
        <img src="../assets/CDEX-LOGO.png" alt="" class="position-absolute bottom-0 d-md-block d-none" height="500px">
        <div class="container">
          <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
              <a class="navbar-brand" href="#"><img src="../assets/CODEX-LOGO-BLACK.png" alt="" class="logo" srcset=""></a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                  <li class="nav-item">
                    <a class="nav-link" href="/about">About</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/reward">Reward Members</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/loyalty">Loyalty Program</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#">Audit</a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>

          <div class="row cvh position-relative">
            <div class="col-md-6 align-self-center my-md-0 mt-4">
              <h1 class="fw-bold width">Stake your CDEX <br> tokens and earn <br> rewards</h1>
              <p class="width">Build your CDEX balance by staking in our smart contract audited by Certik. Users can unstake at anytime.</p>
              <div class="mt-5">
                <v-btn class="btn cbtn bg-prime shadow-sm me-md-3" x-large href="/reward">Start Staking</v-btn>
                <v-btn class="btn cbtn btn-dark shadow-sm ms-md-5 ms-3" x-large @click="scrollMeTo('loyalty')">Learn More</v-btn>
              </div>
            </div>
            <div class="col-md-6 align-self-center position-relative z-0 my-md-0 my-5">

              <div class="row g-md-3 g-2 ">
                <img src="../assets/hero_pic.png"
                  class="img-fluid position-absolute col-12 col-md-10 align-self-center heroimage" alt="" srcset="">
                <div class="col-6">
                  <div class="ccard p-md-4 p-3 text-white bg-prime">
                    <img src="../assets/purse_icon.png" alt="" class="pb-2" srcset="" width="45px">
                    <p>CDEX Amount Staked</p>
                    <template v-if="loadingStats">
                      <v-row>
                        <v-col>
                          <v-progress-circular
                            :size="25"
                            :width="7"
                            indeterminate
                            color="white"
                          />
                        </v-col>
                      </v-row>
                    </template>
                    <template v-else>
                      <h4 class="fw-bold overflow-hidden">{{ amountStaked.toLocaleString() }}</h4>
                    </template>
                  </div>
                </div>
                <div class="col-6">
                  <div class="ccard bg-dark p-md-4 p-3 text-white ">
                    <img src="../assets/staking_yield.png" alt="" class="pb-2" srcset="" width="45px">
                    <p>Staking Yield (Dynamic APR)</p>
                    <template v-if="loadingStats">
                      <v-row>
                        <v-col>
                          <v-progress-circular
                            :size="25"
                            :width="7"
                            indeterminate
                            color="white"
                          />
                        </v-col>
                      </v-row>
                    </template>
                    <template v-else>
                      <h4 class="fw-bold">{{ yearlyYield.toLocaleString('en-US', { style: 'decimal', maximumFractionDigits: 2 }) }}%</h4>
                    </template>
                  </div>
                </div>
                <div class="col-6">
                  <div class="ccard p-md-4 p-3">
                    <img src="../assets/total_rewards.png" alt="" class="pb-2" srcset="" width="45px">
                    <p>CDEX Total Rewards</p>
                    <template v-if="loadingStats">
                      <v-row>
                        <v-col>
                          <v-progress-circular
                            :size="25"
                            :width="7"
                            indeterminate
                            color="black"
                          />
                        </v-col>
                      </v-row>
                    </template>
                    <template v-else>
                      <h4 class="fw-bold">{{ Math.floor(totalRewardsAmount).toLocaleString() }}</h4>
                    </template>
                  </div>
                </div>
                <div class="col-6">
                  <div class="ccard bg-white p-md-4 p-3">
                    <img src="../assets/reward_members.png" alt="" class="pb-2" srcset="" width="45px">
                    <p>Total Reward Members</p>
                    <template v-if="loadingStats">
                      <v-row>
                        <v-col>
                          <v-progress-circular
                            :size="25"
                            :width="7"
                            indeterminate
                            color="black"
                          />
                        </v-col>
                      </v-row>
                    </template>
                    <template v-else>
                      <h4 class="fw-bold">{{ totalMembers }}</h4>
                    </template>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>

      <div class="tileSection">
        <div class="container py-5">
          <div class="row p-md-5 mx-md-5">
            <div class="col-md-3 col-7">
              <img src="../assets/loyalty_img.png" class="img-fluid" alt="">
            </div>
            <div class="col-md-8 p-3" ref="loyalty">
              <h4 class="fw-bold">Get rewarded more for achieving different thresholds of the Codex Reward Loyalty Program.
              </h4>
              <p class="py-2">We have made a program which enables users to earn proporpotionaly to the amount of token they
                have. <br>
                See our detailed Loyalty program to know more about the reward benefits.</p>
              <v-btn class="btn cbtn-small bg-prime" x-large href="/loyalty">See the Loyalty Program</v-btn>
            </div>
          </div>
          <div class="row p-md-5 mx-md-5">
            <div class="col-md-3 col-7">
              <img src="../assets/audit_img.png" class="img-fluid" alt="">
            </div>
            <div class="col-md-8 p-3">
              <h4 class="fw-bold">See the professional audit of the smart contracts used, so you can be sure your tokens are
                safe.</h4>
              <p class="py-2">
                Our contracts have been audited by Certik. 
                <br>CertiK is a pioneer in blockchain security, utilizing best-in-class AI technology to secure and monitor blockchain protocols and smart contracts. 
                <br>CertiK’s mission is to secure the cyber world.
              </p>
              <v-btn class="btn cbtn-small bg-prime" x-large href="/audit">Go to Audit Page</v-btn>
            </div>
          </div>
        </div>

      </div>

      <div class="calSection my-md-5">
        <div class="container">
          <div class="row">
            <div class="col-md-5 text-center">
              <img src="../assets/calc_img.png" class="img-fluid" alt="" srcset="" width="80%">
            </div>
            <div class="col-md-6 px-md-4 my-4 align-self-center">
              <h2 class="fw-bold h1">Calculate your rewards first hand before buying.</h2>
              <p class="py-4 lh-1_8">By using the CDEX rewards calculator, users are able to get an idea of the rewards that they will be receiving before and during staking. These numerics are estimates given by the current percentage rate and are subject to change.</p>
              <v-btn class="btn cbtn btn-dark" x-large href="/reward">Calculate your Rewards</v-btn>
            </div>
          </div>
        </div>
      </div>

      <div class="my-md-5">
        <div class="container py-4">
          <div class="row p-md-5 p-0 m-0 justify-content-center call2action">
            <!-- <img src="../assets/call2action.svg" alt="" class="img-fluid image position-absolute" srcset="" > -->
            <div class="align-self-center col-12 text-center">
              <h1 class="fw-bold text-white mt-5">Stake your CDEX tokens <br> and earn rewards</h1>
              <v-btn class="btn cbtn btn-dark my-5" x-large href="https://stex.com/?ref=33646848" target="_blank">Buy your CDEX Tokens</v-btn>
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
            <p class="text-white lh-1_8 fw-lighter w-md-75">An Ecosystem for Developers of The New Generation.
Pushing innovation behind blockchain applications and software development.</p>
          </div>
          <div class="col-md-6 align-self-center">
            <div class="ul">
              <a href="/about" class="nav-link text-white">About the token</a>
              <a href="/reward" class="nav-link text-white">Reward Members</a>
              <a href="/loyalty" class="nav-link text-white">Loyalty Program</a>
              <a href="/audit" class="nav-link text-white">Reward Member Audit</a>
            </div>
          </div>

        </div>
        <div class="row py-4 text-center">
          <p class="text-muted">Copyright 2021 | Codex on Althash</p>
        </div>
      </div>
    </footer>
  </div>
</template>
<script>
  import utils from '../libs/utils'

  const contractAddress = '0eddd6cd6174219e7d008bc48d2ad951975d0df7' // testnet

  const abiJson = JSON.parse(
    '[{"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "earned", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "CDEXRanking", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "rewards", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier3Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_owner", "type": "address"} ], "name": "nominateNewOwner", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_paused", "type": "bool"} ], "name": "setPaused", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "totalSupply", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "getRewardForDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "withdraw", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyTier1Bonus", "type": "uint256"}, {"name": "_loyaltyTier2Bonus", "type": "uint256"}, {"name": "_loyaltyTier3Bonus", "type": "uint256"} ], "name": "setLoyaltyTiersBonus", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "getLoyaltyTiers", "outputs": [{"name": "tier1", "type": "uint256"}, {"name": "tier2", "type": "uint256"}, {"name": "tier3", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyBonusTotal", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardsDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "reward", "type": "uint256"} ], "name": "notifyRewardAmount", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [], "name": "getReward", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedLoyaltyBonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "CDEXToken", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "nominatedOwner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyTier1", "type": "uint256"}, {"name": "_loyaltyTier2", "type": "uint256"}, {"name": "_loyaltyTier3", "type": "uint256"} ], "name": "setLoyaltyTiers", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "paused", "outputs": [{"name": "", "type": "bool"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier1", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "balanceOf", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier2", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "totalMembers", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "acceptOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [{"name": "a", "type": "uint256"}, {"name": "b", "type": "uint256"} ], "name": "min", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardRate", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastTimeRewardApplicable", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "userRewardPerTokenPaid", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "owner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastPauseTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier1Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "stake", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "getLoyaltyTiersBonus", "outputs": [{"name": "tier1Bonus", "type": "uint256"}, {"name": "tier2Bonus", "type": "uint256"}, {"name": "tier3Bonus", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastUpdateTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_rewardsDuration", "type": "uint256"} ], "name": "setRewardsDuration", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerToken", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier3", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "depositTokens", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerTokenStored", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "exit", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "periodFinish", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedRewardTokens", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier2Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"inputs": [{"name": "_owner", "type": "address"}, {"name": "_CDEXTokenContractAddress", "type": "address"}, {"name": "_rankingContractAddress", "type": "address"} ], "payable": false, "stateMutability": "nonpayable", "type": "constructor"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardAdded", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Staked", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Withdrawn", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "loyaltyBonus", "type": "uint256"} ], "name": "LoyaltyBonusPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newDuration", "type": "uint256"} ], "name": "RewardsDurationUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "token", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Recovered", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "sender", "type": "address"}, {"indexed": false, "name": "receiver", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardsDeposited", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyTier1", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier2", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier3", "type": "uint256"} ], "name": "LoyaltyTiersUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyTier1Bonus", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier2Bonus", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier3Bonus", "type": "uint256"} ], "name": "LoyaltyTiersBonussUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "isPaused", "type": "bool"} ], "name": "PauseChanged", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerNominated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "oldOwner", "type": "address"}, {"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerChanged", "type": "event"} ]'
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
      this.refreshStats()
    },
    
    data () {
      return {
        loadingStats: true,
        amountStaked: 0,
        yearlyYield: 0,
        yearlyReward: 0,
        totalRewardsAmount: 0,
        totalMembers: 0
      }
    },

    methods: {
      async getStats () {
        var self = this
        self.loadingStats = true
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
            'getRewardForDuration',
            [],
          )
          
          self.totalRewardsAmount = decodedResult[0] / 1e8

          if (self.yearlyReward > 0) {
            self.yearlyYield = self.yearlyReward / self.amountStaked * 100
          }

          decodedResult = await utils.callContractFunction(
            contractAddress,
            abiJson,
            'totalMembers',
            [],
          )
          self.totalMembers = decodedResult[0]

          self.loadingStats = false
        } catch (e) {
          console.log('Error reading stats: ' + e.stack || e.toString() || e)
          alert(e.message || e)
        }
      },

      refreshStats () {
        var self = this
        setInterval(async () => {
          await self.getStats()
        }, 1000 * 60)
      },

      scrollMeTo(refName) {
        var element = this.$refs[refName];
        var top = element.offsetTop;

        window.scrollTo(0, top);
      }
    }
  }
</script>
<style scoped src="../assets/css/home.scss" lang="scss" />
