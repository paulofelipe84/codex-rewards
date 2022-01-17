<template>
  <div>
    <body>
      <div class="heroSection pb-5x2">
        <img src="../assets/icon-purple.png" alt="" class="position-absolute bottom-0 d-md-block d-none" height="500px">
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
                      <a class="nav-link" href="/">Home</a>
                    </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/about">About</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/reward">Reward Members</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#">Audit</a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>

          <div class="row text-center my-md-4 mt-4 mb-1 justify-content-center black--text">
            <h1 class="fw-bold">CDEX Loyalty Program</h1>
            <p class="width">
              By staking enough CDEX, users are able to gain additional benefits from our platform. Climb the ranks to reach the top tier as a Codex King! 
            </p>
          </div>

          <div class="row">
            <div class="col-md-4 my-2">

              <!-- Pawn Card start here -->

              <div class="programcard">
                <div class="text-center p-3 black--text">
                  <img src="../assets/pawn.png" class="rounded-circle" alt="" width="140px" srcset="">
                  <h4 class="fw-bold">Codex Pawn</h4>
                  <hr>
                  <p class="p-0 m-2">Eligible when you have</p>
                  <template v-if="loadingStats">
                    <v-row>
                      <v-col>
                        <v-progress-circular
                          :size="40"
                          :width="7"
                          indeterminate
                          color="black"
                        />
                      </v-col>
                    </v-row>
                  </template>
                  <template v-else>
                    <h2 class="fw-bolder prime">{{ loyaltyTier3.toLocaleString() }}</h2>
                  </template>
                  <h6 class="fw-bold">CDEX STAKED</h6>
                </div>
                <div>
                  <div class="d-inline-flex flex-wrap w-100 px-3 black--text">
                    <div class="col-6  align-self-center">
                      <p class="small-font m-0">CDEX Staking % <br>Booster </p>
                    </div>
                    <div class="col-6 text-end align-self-center">
                      <template v-if="loadingStats">
                      <v-row>
                        <v-col>
                          <v-progress-circular
                            :size="40"
                            :width="7"
                            indeterminate
                            color="black"
                          />
                        </v-col>
                      </v-row>
                      </template>
                      <template v-else>
                        <h5 class="m-0 fw-bolder">{{ loyaltyTier3Bonus }}%</h5>
                      </template>
                    </div>
                    <hr class="w-100 my-2">
                    <div class="col-6 mb-3 align-self-center">
                      <p class="small-font m-0">Random HRC20 Reward Eligibilty</p>
                    </div>
                    <div class="col-6 mb-3 text-end align-self-center">
                      <h5 class="m-0 fw-bolder red--text">Not eligible</h5>
                    </div>
                  </div>
                </div>
                <div class="dark-part bg-dark  p-3">
                  <div class="col-9 align-self-center">
                    <p class="m-0">Token Utility Awards</p>
                  </div>
                  <div class="col-3 align-self-center text-end">
                    <h5 class="m-0">5%</h5>
                  </div>
                </div>
              </div>

              <!-- Pawn card End Here -->

            </div>

            <div class="col-md-4 my-2">

              <!-- Knight card start here -->

              <div class="programcard">
                  <div class="text-center p-3 black--text">
                    <img src="../assets/knight.png" class="rounded-circle" alt="" width="140px" srcset="">
                    <h4 class="fw-bold">Codex Knight</h4>
                    <hr>
                    <p class="p-0 m-2">Eligible when you have </p>
                    <template v-if="loadingStats">
                      <v-row>
                        <v-col>
                          <v-progress-circular
                            :size="40"
                            :width="7"
                            indeterminate
                            color="black"
                          />
                        </v-col>
                      </v-row>
                    </template>
                    <template v-else>
                      <h2 class="fw-bolder prime">{{ loyaltyTier2.toLocaleString() }}</h2>
                    </template>
                    <h6 class="fw-bold">CDEX STAKED</h6>
                  </div>
                  <div>
                    <div class="d-inline-flex flex-wrap w-100 px-3 black--text">
                      <div class="col-6  align-self-center">
                        <p class="small-font m-0">CDEX Staking % <br>Booster </p>
                      </div>
                      <div class="col-6 text-end align-self-center">
                        <template v-if="loadingStats">
                          <v-row>
                            <v-col>
                              <v-progress-circular
                                :size="40"
                                :width="7"
                                indeterminate
                                color="black"
                              />
                            </v-col>
                          </v-row>
                        </template>
                        <template v-else>
                          <h5 class="m-0 fw-bolder">{{ loyaltyTier2Bonus }}%</h5>
                        </template>
                      </div>
                      <hr class="w-100 my-2">
                      <div class="col-6 mb-3 align-self-center">
                        <p class="small-font m-0">Random HRC20 Reward Eligibilty</p>
                      </div>
                      <div class="col-6 mb-3 text-end align-self-center">
                        <h5 class="m-0 fw-bolder red--text">Not eligible</h5>
                      </div>
                    </div>
                  </div>
                  <div class="dark-part bg-dark  p-3">
                    <div class="col-9 align-self-center">
                        <p class="m-0">Token Utility Awards</p>
                    </div>
                    <div class="col-3 align-self-center text-end">
                        <h5 class="m-0">10%</h5>
                    </div>
                  </div>
              </div>

              <!-- Knight Card ends here -->

            </div>

            <div class="col-md-4 my-2">

              <!-- King card start here -->

              <div class="programcard king-bg text-white">
                  <div class="text-center p-3">
                    <img src="../assets/king.png" class="rounded-circle" alt="" width="140px" srcset="">
                    <h4 class="fw-bold">Codex King</h4>
                    <hr>
                    <p class="p-0 m-2">Eligible when you have </p>
                    <template v-if="loadingStats">
                      <v-row>
                        <v-col>
                          <v-progress-circular
                            :size="40"
                            :width="7"
                            indeterminate
                            color="white"
                          />
                        </v-col>
                      </v-row>
                    </template>
                    <template v-else>
                      <h2 class="fw-bolder">{{ loyaltyTier1.toLocaleString() }}</h2>
                    </template>
                    <h6 class="fw-bold">CDEX STAKED</h6>
                  </div>
                  <div>
                    <div class="d-inline-flex flex-wrap w-100 px-3">
                      <div class="col-6  align-self-center">
                        <p class="small-font m-0">CDEX Staking % <br>Booster </p>
                      </div>
                      <div class="col-6 text-end align-self-center">
                        <template v-if="loadingStats">
                          <v-row>
                            <v-col>
                              <v-progress-circular
                                :size="40"
                                :width="7"
                                indeterminate
                                color="white"
                              />
                            </v-col>
                          </v-row>
                        </template>
                        <template v-else>
                          <h5 class="m-0 fw-bolder">{{ loyaltyTier1Bonus }}%</h5>
                        </template>
                      </div>
                      <hr class="w-100 my-2">
                      <div class="col-6 mb-3 align-self-center">
                        <p class="small-font m-0">Random HRC20 Reward Eligibilty</p>
                      </div>
                      <div class="col-6 mb-3 text-end sec align-self-center">
                        <h5 class="m-0 fw-bolder">Eligible</h5>
                      </div>
                    </div>
                  </div>
                  <div class="dark-part bg-dark  p-3">
                    <div class="col-9 align-self-center">
                      <p class="m-0">Token Utility Awards</p>
                    </div>
                    <div class="col-3 align-self-center text-end">
                      <h5 class="m-0">20%</h5>
                    </div>
                  </div>
              </div>
              <!-- King Card ends here -->
            </div>
          </div>
        </div>
      </div>

      <div class="call2actionSection">
        <div class="container">
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
        </div>
      </div>

      <footer class="bg-dark position-relative overflow-hidden">
        <img src="../assets/cdex-logo-white.png" class="position-absolute footIcon" alt="" srcset="" width="400px">
        <div class="container footer">
          <div class="row pt-5 mx-md-5">
            <div class="col-md-6">
              <img src="../assets/logo-white.png" alt="" class="my-3" width="100px">
              <h5 class="prime fw-bold">HOME BASE</h5>
              <hr class="w-md-75 text-white">
              <p class="text-white lh-1_8 fw-lighter w-md-75">
                An Ecosystem for Developers of The New Generation.
                Pushing innovation behind blockchain applications and software development.
              </p>
            </div>
            <div class="col-md-6 align-self-center">
              <div class="ul">
                <a href="/" class="nav-link text-white">Home</a>
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
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous">
      </script>
    </body>
  </div>
</template>

<script>
  import utils from '../libs/utils'

  const contractAddress = '0eddd6cd6174219e7d008bc48d2ad951975d0df7' // testnet

  const abiJson = JSON.parse(
    '[{"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "earned", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "rewards", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier3Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_owner", "type": "address"} ], "name": "nominateNewOwner", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_paused", "type": "bool"} ], "name": "setPaused", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "totalSupply", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "getRewardForDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "withdraw", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyTier1Bonus", "type": "uint256"}, {"name": "_loyaltyTier2Bonus", "type": "uint256"}, {"name": "_loyaltyTier3Bonus", "type": "uint256"} ], "name": "setLoyaltyTiersBonus", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "getLoyaltyTiers", "outputs": [{"name": "tier1", "type": "uint256"}, {"name": "tier2", "type": "uint256"}, {"name": "tier3", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyBonusTotal", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardsDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "reward", "type": "uint256"} ], "name": "notifyRewardAmount", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [], "name": "getReward", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedLoyaltyBonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "CDEXToken", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "nominatedOwner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyTier1", "type": "uint256"}, {"name": "_loyaltyTier2", "type": "uint256"}, {"name": "_loyaltyTier3", "type": "uint256"} ], "name": "setLoyaltyTiers", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "paused", "outputs": [{"name": "", "type": "bool"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier1", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "balanceOf", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier2", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "totalMembers", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "acceptOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [{"name": "a", "type": "uint256"}, {"name": "b", "type": "uint256"} ], "name": "min", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardRate", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastTimeRewardApplicable", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "userRewardPerTokenPaid", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "owner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastPauseTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier1Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "stake", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "getLoyaltyTiersBonus", "outputs": [{"name": "tier1Bonus", "type": "uint256"}, {"name": "tier2Bonus", "type": "uint256"}, {"name": "tier3Bonus", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastUpdateTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_rewardsDuration", "type": "uint256"} ], "name": "setRewardsDuration", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerToken", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier3", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "depositTokens", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerTokenStored", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "exit", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "periodFinish", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedRewardTokens", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier2Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"inputs": [{"name": "_owner", "type": "address"}, {"name": "_CDEXToken", "type": "address"} ], "payable": false, "stateMutability": "nonpayable", "type": "constructor"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardAdded", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Staked", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Withdrawn", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "loyaltyBonus", "type": "uint256"} ], "name": "LoyaltyBonusPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newDuration", "type": "uint256"} ], "name": "RewardsDurationUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "token", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Recovered", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "sender", "type": "address"}, {"indexed": false, "name": "receiver", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"}, {"indexed": false, "name": "bonus", "type": "uint256"} ], "name": "RewardsAndBonusDeposited", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyTier1", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier2", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier3", "type": "uint256"} ], "name": "LoyaltyTiersUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyTier1Bonus", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier2Bonus", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier3Bonus", "type": "uint256"} ], "name": "LoyaltyTiersBonussUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "isPaused", "type": "bool"} ], "name": "PauseChanged", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerNominated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "oldOwner", "type": "address"}, {"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerChanged", "type": "event"} ]'
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
    },

    data () {
      return {
        loyaltyTier1: 0,
        loyaltyTier2: 0,
        loyaltyTier3: 0,
        loyaltyTier1Bonus: 0,
        loyaltyTier2Bonus: 0,
        loyaltyTier3Bonus: 0,
        loadingStats: true
      }
    },

    methods: {
      async getStats () {
        var self = this
        try {
          var decodedResult = await utils.callContractFunction(
            contractAddress,
            abiJson,
            'getLoyaltyTiers',
            [],
          )
          self.loyaltyTier1 = decodedResult[0] / 1e8
          self.loyaltyTier2 = decodedResult[1] / 1e8
          self.loyaltyTier3 = decodedResult[2] / 1e8
          
          decodedResult = await utils.callContractFunction(
            contractAddress,
            abiJson,
            'getLoyaltyTiersBonus',
            [],
          )
          self.loyaltyTier1Bonus = decodedResult[0] / 100
          self.loyaltyTier2Bonus = decodedResult[1] / 100
          self.loyaltyTier3Bonus = decodedResult[2] / 100

          self.loadingStats = false

        } catch (e) {
          console.log('Error reading stats: ' + e.stack || e.toString() || e)
          alert(e.message || e)
        }
      }
    }
  }
</script>
<style scoped src="../assets/css/loyalty.scss" lang="scss" />