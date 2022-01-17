<template>
  <div>
    <div>
      <body>
        <div class="heroSection">
          <div class="container">
            <nav class="navbar navbar-expand-lg navbar-light">
              <div class="container-fluid">
                <a class="navbar-brand" href="#"><img src="../assets/CODEX-LOGO-BLACK.png" alt="" class="logo" srcset=""></a>
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
                      <a class="nav-link" href="/about">About</a>
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

            <div class="row text-center my-4 justify-content-center">
              <h1 class="fw-bold ">CDEX Rewards Members </h1>
              <p class="width">
                Codex on Althash has provided users with a platform to build their CDEX holdings through Certik verified Smart Contracting.
              </p>
            </div>
            <div class="row mb-3 my-md-5">
              <div class="col-md-4 my-2 my-md-0">
                <div class="ccard bg-white p-md-4 p-3">
                  <img src="../assets/reward_members.png" alt="" class="pb-4" srcset="" width="45px">
                  <p class="my-2">Total Reward Members</p>
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
              <div class="col-md-4 my-2 my-md-0">
                <div class="ccard bg-dark p-md-4 p-3 text-white ">
                  <img src="../assets/staking_yield.png" alt="" class="pb-4" srcset="" width="45px">
                  <p class="my-2">Staking Yield (Dynamic APR)</p>
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
              <div class="col-md-4 my-2 my-md-0">
                <div class="ccard p-md-4 p-3 bg-prime">
                  <img src="../assets/total_rewards.png" alt="" class="pb-4" srcset="" width="45px">
                  <p class="my-2">CDEX Amount Staked</p>
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
                    <h4 class="fw-bold">{{ Math.floor(amountStaked).toLocaleString() }}</h4>
                  </template>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="calcSection">
          <div class="container">
            <div class="row mb-5">
              <div class="col-md-8">

                <div v-if="!wallet">
                  <div class="calcCard mb-4 p-4">
                    <v-btn block @click="loginDialog=true" x-large color="deep-purple accent-2">
                      Start Staking!
                    </v-btn>
                  </div>
                  <div class="calcCard p-4">
                    <p>Estimated Reward Calculator</p>
                    <hr>
                    <div class="row">
                      <div class="col-8">
                        <label for="" class="text-muted fw-bold my-2">Enter staked amount in CDEX</label>
                        <br>
                        <input 
                          type="text" 
                          v-model.lazy="calculationAmount" 
                          v-money="money" 
                          @keydown="$event.key !== '-' ? clearEstimatedCalculations() : $event.preventDefault()">
                      </div>
                      <div class="col-4">
                        <template v-if="calculationTier > 0">
                          <label for="" class="text-muted fw-bold my-2">Loyalty Rewards Status</label>
                          <br>
                        </template>
                        <template v-if="calculationTier == 1">
                          <a href="/loyalty"><img src="../assets/king.png" class="rounded-circle" alt="" width="50px" srcset=""></a>
                          <span class="fw-bold">Codex King</span>
                        </template>
                        <template v-else-if="calculationTier == 2">
                          <a href="/loyalty"><img src="../assets/knight.png" class="rounded-circle" alt="" width="50px" srcset=""></a>
                          <span class="fw-bold">Codex Knight</span>
                        </template>
                        <template v-else-if="calculationTier == 3">
                          <a href="/loyalty"><img src="../assets/pawn.png" class="rounded-circle" alt="" width="50px" srcset=""></a>
                          <span class="fw-bold">Codex Pawn</span>
                        </template>
                      </div>
                    </div>
                    <br><br>
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
                        <template v-if="loadingStats">
                          <v-row>
                            <v-col>
                              <v-progress-circular
                                :size="40"
                                :width="7"
                                indeterminate
                                color="deep-purple accent-2"
                              />
                            </v-col>
                          </v-row>
                        </template>
                        <template v-else>
                          <h2 class="prime fw-bold">{{ Math.floor(estimatedReturns).toLocaleString() }} CDEX</h2>
                        </template>
                      </div>
                      <div class="col-md-4 col">
                        <p>Final Value</p>
                        <template v-if="loadingStats">
                          <v-row>
                            <v-col>
                              <v-progress-circular
                                :size="40"
                                :width="7"
                                indeterminate
                                color="deep-purple accent-2"
                              />
                            </v-col>
                          </v-row>
                        </template>
                        <template v-else>
                          <h2 class="prime fw-bold">{{ Math.floor(totalBalanceAfterReturns).toLocaleString() }} CDEX</h2>
                        </template>
                      </div>
                      <div class="col-md-4 mt-md-0 mt-3">
                        <p>ROI</p>
                        <template v-if="loadingStats">
                          <v-row>
                            <v-col>
                              <v-progress-circular
                                :size="40"
                                :width="7"
                                indeterminate
                                color="deep-purple accent-2"
                              />
                            </v-col>
                          </v-row>
                        </template>
                        <template v-else>
                          <h2 class="prime fw-bold">{{ Math.floor(returnOverInvestment).toLocaleString() }}%</h2>
                        </template>
                      </div>
                    </div>
                  </div>
                  <div class="calcCard my-4 p-4">
                    <v-btn block @click="loginDialog=true" x-large color="deep-purple accent-2">
                      Start Staking!
                    </v-btn>
                  </div>
                </div>

                <div class="calcCard card mb-3" v-else>
                  <div class="card-header">
                    <p class="fw-bold text-white py-2 m-0">Your CDEX Wallet: {{ wallet.info.address }}</p>
                  </div>
                  <div class="card-body p-4">
                    <!-- <label for="" class="text-muted fw-bold my-2">Enter stacked amount</label><br>
                    <input type="text" value="500 USD"><br><br> -->
                    <div class="row">
                      <div class="col-6 text-small">Total Balance Available</div>
                      <div class="col-6 text-end text-small">
                        Approved Balance (not staked)
                        <v-tooltip left>
                          <template v-slot:activator="{ on, attrs }">
                            <v-btn
                              color="white"
                              dark
                              v-bind="attrs"
                              v-on="on"
                              icon
                              small
                            >
                              <v-icon x-small>mdi-information</v-icon>
                            </v-btn>
                          </template>
                          <span>
                            In order to stake, you need to pre-approve 
                            <br>
                            an amount to be utilized by the staking contract.
                            <br>
                            <br>
                            You don't need to stake the whole approved balance.
                          </span>
                        </v-tooltip>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-6">
                        <template v-if="loadingWalletData">
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
                          <h3 class="fw-bolder">{{ walletTokenBalance.toLocaleString("en-US", {style: "decimal", minimumFractionDigits: 2, maximumFractionDigits: 4}) }}</h3>
                        </template>
                      </div>
                      <div class="col-6 text-end">
                        <h3 class="fw-bolder">
                          <template v-if="loadingWalletData">
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
                            {{ userApprovedBalance.toLocaleString("en-US", {style: "decimal", minimumFractionDigits: 2, maximumFractionDigits: 4}) }}
                          </template>
                        </h3>
                        <v-btn 
                          outlined 
                          small 
                          @click="approveDialog=true"
                        >
                          <v-icon
                            left
                            color="white"
                            small
                          >
                            mdi-pencil
                          </v-icon>
                          Update
                        </v-btn>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-6 text-small">
                      </div>
                      <div class="col-6 text-end  text-small">
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-6 text-small">Total Staked</div>
                      <div class="col-6 text-end text-small">Your Loyalty Program Status</div>
                    </div>
                    <div class="row">
                      <div class="col-6">
                        <template v-if="loadingWalletData">
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
                          <h3 class="fw-bolder">{{ userStakedBalance.toLocaleString("en-US", {style: "decimal", minimumFractionDigits: 2, maximumFractionDigits: 4}) }}</h3>
                        </template>
                      </div>
                      <div class="col-6 text-end">
                        <template v-if="loadingWalletData">
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
                          <template v-if="userLoyaltyTier==0">
                            <a href="/loyalty"><img src="../assets/no_status.png" class="rounded-circle" alt="" width="70px" srcset=""></a>
                            <span class="fw-bold">No status yet!</span>
                          </template>
                          <template v-else-if="userLoyaltyTier==3">
                            <a href="/loyalty"><img src="../assets/pawn.png" class="rounded-circle" alt="" width="70px" srcset=""></a>
                            <span class="fw-bold">Codex Pawn</span>
                          </template>
                          <template v-else-if="userLoyaltyTier==2">
                            <a href="/loyalty"><img src="../assets/knight.png" class="rounded-circle" alt="" width="70px" srcset=""></a>
                            <span class="fw-bold">Codex Knight</span>
                          </template>
                          <template v-else>
                            <a href="/loyalty"><img src="../assets/king.png" class="rounded-circle" alt="" width="70px" srcset=""></a>
                            <span class="fw-bold">Codex King</span>
                          </template>
                        </template>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-6 text-small"></div>
                      <div class="col-6 text-end text-small">Estimated Yearly Earnings</div>
                    </div>
                    <div class="row">
                      <div class="col-6">
                      </div>
                      <div class="col-6 text-end">
                        <template v-if="loadingWalletData">
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
                          <h3 class="fw-bolder">{{ userYearlyReturns.toLocaleString("en-US", {style: "decimal", minimumFractionDigits: 2, maximumFractionDigits: 2}) }}</h3>
                        </template>
                      </div>
                    </div>
                    <hr>
                    <div class="row">
                      <div class="col-6">
                        <h5 class="">Total Earnings Available</h5>
                      </div>
                      <div class="col-6 text-end">
                        <template v-if="loadingWalletData">
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
                          <h3 class="fw-bolder sec">{{ userEarnings.toLocaleString("en-US", {style: "decimal", minimumFractionDigits: 2, maximumFractionDigits: 4}) }}</h3>
                          <v-btn 
                            v-if="userEarnings>0"
                            outlined 
                            small
                            @click="withdrawDialog=true"
                          >
                            <v-icon
                              left
                              color="white"
                              small
                            >
                              mdi-download
                            </v-icon>
                            Withdraw
                          </v-btn>
                        </template>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer p-4">
                    <h6>Stake CODEX</h6>
                    <div class="row">
                      <div class="col-9">
                        <input 
                          type="text" 
                          class="header fw-bolder prime" 
                          v-model.lazy="stakeAmount"
                          v-money="money"
                        >
                      </div>
                      <div class="col-3 text-end">
                        <v-btn 
                            outlined 
                            small
                            @click="stakeMax"
                            color="grey"
                          >
                            Stake Max
                          </v-btn>
                      </div>
                    </div>
                    <hr>
                    <div class="row">
                      <div class="col-6">
                        <v-btn 
                          outlined 
                          x-large
                          @click="unstakeAmount=userStakedBalance;unstakeDialog=true"
                          color="deep-purple accent-2"
                          :disabled="userStakedBalance==0"
                        >
                          Unstake
                        </v-btn>
                      </div>
                      <div class="col-6 text-end">
                        <v-btn  
                          x-large
                          @click="stakeDialog=true"
                          color="deep-purple accent-2"
                        >
                          Stake
                        </v-btn>
                      </div>
                    </div>
                  </div>
                </div>
      
                <div class="mt-md-4 mb-md-0 my-3">
                  <div class="row p-md-1 p-0 m-0 justify-content-center call2action">
                    <!-- <img src="../assets/call2action.svg" alt="" class="img-fluid image position-absolute" srcset="" > -->
                    <div class="align-self-center col-12 text-center my-4 justify-content-center">
                      <h2 class="fw-bold text-white m-2 px-md-5">Stake your CDEX tokens and earn rewards</h2>
                      <v-btn class="btn cbtn btn-dark m-3" x-large href="https://stex.com/?ref=33646848" target="_blank">Buy your CDEX Tokens</v-btn>
                    </div>
                  </div>
                </div>

              </div>
              <div class="col-md-4">

                <!-- add or remove dark-leader css class next to calcCard for dark version or light version of Leaderboard -->

                <div class="calcCard px-4 pt-4 h-100 dark-leader">
                  <p>Leaderboard for Top wallets</p>
                  <hr> 
                  <!-- ranking starts -->
                  <template v-if="loadingRanking">
                    <v-row>
                      <v-col />
                      <v-col>
                        <v-progress-circular
                          :size="50"
                          :width="7"
                          indeterminate
                          color="#574FE8"
                        />
                      </v-col>
                      <v-col />
                    </v-row>
                  </template>
                  <template v-else>
                    <div class="lboard-item-card p-3 my-3" v-for="rankedWallet in ranking" :key="rankedWallet.address">
                      <h6 class="fw-bold">{{ rankedWallet.address }}</h6>
                      <div class="row">
                        <div class="col-8">
                          <h6 class="m-0 header">Staked: {{ Math.floor(rankedWallet.balance).toLocaleString() }} CDEX</h6>
                        </div>
                        <div class="col-4">
                        </div>
                      </div>
                    </div>
                  </template>
                  <!-- end of ranking  -->
                </div>
              </div>
            </div>
          </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
          crossorigin="anonymous" />
      </body>
    </div>
    <footer class="footer bg-dark position-relative overflow-hidden">
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
          <p class="text-muted">Copyright 2021 | Codex on Althash </p>
        </div>
      </div>
    </footer>
    <v-dialog class="modal-dialog modal-dialog-centered" width="500px" v-model="stakeSuccess">
      <div class="modal-content black--text">
        <div class="modal-header text-center">
          <h4 class="modal-title w-100 fw-bolder" id="succesModalLabel">Staking Successful</h4>
          <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
        </div>
        <div class="modal-body text-center">
          <img src="../assets/success.png" alt="" width="160">
          <h2 class="fw-bolder prime">500,010.0000 CDX</h2>
          <h4 class="fw-bolder">Staked Successfully</h4>
          <p class="px-5 mx-2 subtitle my-4">Check your wallet to see the updated status of your staking.</p>
        </div>
        <div class="modal-footer">
          <v-btn plain x-large @click="stakeSuccess=false">
            Go to Wallet<v-icon>mdi-arrow-right</v-icon>
          </v-btn>
        </div>
      </div>
    </v-dialog>
    <v-dialog class="modal-dialog modal-dialog-centered" width="500px" v-model="loginDialog">
      <div class="modal-content black--text">
        <div class="modal-header text-center py-2">
          <h2 class="modal-title w-100 fw-bolder" id="loginModalLabel">Login</h2>
          <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
        </div>
        <div class="modal-body">
          <p>Your private key</p>
          <v-text-field
            :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
            :type="showPassword ? 'text' : 'password'"
            @click:append="showPassword = !showPassword"
            @keydown.enter="login(privateKey)"
            solo
            background-color="grey"
            v-model="privateKey"
          />
          <v-container>
            <v-row align="center">
              <v-col cols="5"><v-divider/></v-col>
              <v-col cols="2"><h6><center>OR</center></h6></v-col>
              <v-col cols="5"><v-divider/></v-col>
            </v-row>
          </v-container>
          <div class="file text-center">
            <file-reader style="color:white;" @upload="parseKeyFile"></file-reader>
            <password :open="passwordRequired" notEmpty="true" @password="inputed"></password>
            <p>
              Upload your Althash Web Wallet encrypted text file
            </p>
          </div>
        </div>
        <div class="modal-footer">
          <v-btn plain x-large @click="login(privateKey)">
            Login<v-icon>mdi-arrow-right</v-icon>
          </v-btn>
        </div>
      </div>
    </v-dialog>
    <v-dialog class="modal-dialog  modal-dialog-centered" width="500px" v-model="approveDialog">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title fw-bolder black--text" id="confirmModal1Label">Update approved balance</h3>
          <v-btn icon @click="approveDialog=false">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
        </div>
        <div class="modal-body black--text">
          <p class="mb-1">New approved balance</p>
          <div class="row mb-2">
            <div class="col-10">
              <input 
                type="text" 
                class="header fw-bolder prime" 
                v-model.lazy="approveAmount" 
                v-money="money"
              >
              <span class="h3 fw-bolder prime">
                CDEX
              </span>
            </div>
          </div>
          <p class="mb-1">Transaction Fees</p>
          <h4 class="fw-bolder mb-2">1.01 HTML</h4>
        </div>
        <div class="modal-footer">
          <v-btn plain x-large @click="approve">
            <h4>Approve</h4> <v-icon>mdi-check-circle</v-icon>
          </v-btn>
        </div>
      </div>
    </v-dialog>
    <v-dialog class="modal-dialog  modal-dialog-centered" width="500px" v-model="withdrawDialog">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title fw-bolder black--text" id="confirmModal1Label">Withdraw Rewards</h3>
          <v-btn icon @click="withdrawDialog=false">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
        </div>
        <div class="modal-body black--text">
          <p class="mb-1">Total Rewards</p>
          <div class="row mb-2">
            <div class="col-10">
              <span class="h3 fw-bolder prime">
                {{ userEarnings.toLocaleString("en-US", {style: "decimal", minimumFractionDigits: 2, maximumFractionDigits: 4}) }} CDEX
              </span>
            </div>
          </div>
          <p class="mb-1">Transaction Fees</p>
          <h4 class="fw-bolder mb-2">1.01 HTML</h4>
        </div>
        <div class="modal-footer">
          <v-btn plain x-large @click="withdraw">
            <h4>Withdraw</h4> <v-icon>mdi-download</v-icon>
          </v-btn>
        </div>
      </div>
    </v-dialog>
    <v-dialog class="modal-dialog  modal-dialog-centered" width="500px" v-model="unstakeDialog">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title fw-bolder black--text" id="confirmModal1Label">Unstake</h3>
          <v-btn icon @click="unstakeDialog=false">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
        </div>
        <div class="modal-body black--text">
          <p class="mb-1">Amount to be unstaked</p>
          <div class="row mb-2">
            <div class="col-10">
              <input 
                type="text" 
                class="header fw-bolder prime" 
                v-model.lazy="unstakeAmount" 
                v-money="money"
              >
              <span class="h3 fw-bolder prime">
                CDEX
              </span>
            </div>
          </div>
          <p class="mb-1">Transaction Fees</p>
          <h4 class="fw-bolder mb-2">1.01 HTML</h4>
        </div>
        <div class="modal-footer">
          <v-btn plain x-large @click="unstake">
            <h4>Unstake</h4> <v-icon>mdi-download</v-icon>
          </v-btn>
        </div>
      </div>
    </v-dialog>
    <v-dialog class="modal-dialog  modal-dialog-centered" width="500px" v-model="stakeDialog">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title fw-bolder black--text" id="confirmModal1Label">Stake</h3>
          <v-btn icon @click="stakeDialog=false">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
        </div>
        <div class="modal-body black--text">
          <p class="mb-1">Amount to be staked</p>
          <div class="row mb-2">
            <div class="col-10">
              <input 
                type="text" 
                class="header fw-bolder prime" 
                v-model.lazy="stakeAmount" 
                v-money="money"
              >
              <span class="h3 fw-bolder prime">
                CDEX
              </span>
            </div>
          </div>
          <p class="mb-1">Transaction Fees</p>
          <h4 class="fw-bolder mb-2">1.01 HTML</h4>
        </div>
        <div class="modal-footer">
          <v-btn plain x-large @click="stake">
            <h4>Stake</h4> <v-icon>mdi-upload</v-icon>
          </v-btn>
        </div>
      </div>
    </v-dialog>
    <v-dialog class="modal-dialog  modal-dialog-centered" width="500px" v-model="txSent">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title fw-bolder black--text">Transaction Sent!</h3>
          <v-btn icon @click="txSent=false">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
        </div>
        <div class="modal-body text-center black--text">
          <template v-if="loadingTx">
            <v-row>
              <v-col>
                <p class="mb-1">Please wait...</p>
              </v-col>
              <v-col>
                <v-progress-circular
                  :size="40"
                  :width="7"
                  indeterminate
                  color="blue"
                />
              </v-col>
            </v-row>
          </template>
          <template v-else>
              <p class="fw-bolder">Your transaction has been broadcasted to the Althash Blockchain.</p>
              <br>
              <v-btn :href="txViewUrl" target="_blank" color="deep-purple accent-2">Check transaction progress</v-btn>
              <br>
              <p class="px-5 mx-2 subtitle my-4">The values on this page will not reflect the changes until the transaction is confirmed by the network.</p>
          </template>
        </div>
      </div>
    </v-dialog>
  </div>
</template>

<script>
  import utils from '../libs/utils'
  import { VMoney } from 'v-money'
  import webWallet from '../libs/web-wallet'
  import server from '../libs/server'
  import base58 from 'bs58'
  import fileReader from '../components/FileReader'
  import password from '../components/Password'
  import keyfile from '../libs/keyfile'
  import base58check from 'base58check'

  const prefix = '29' // testnet = '64' | mainnet = '29'
  
  const stakingContractAddress = '0eddd6cd6174219e7d008bc48d2ad951975d0df7'
  const tokenContractAddress = 'c09850f32c4ef8c455a38353aa35effbe4f15775'
  const rankingContractAddress = '6f43d8eadb7d96cdd266d7c5b382b732b20679e3'

  const stakingAbiJson = JSON.parse(
    '[{"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "earned", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "CDEXRanking", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "rewards", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier3Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_owner", "type": "address"} ], "name": "nominateNewOwner", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_paused", "type": "bool"} ], "name": "setPaused", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "totalSupply", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "getRewardForDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "withdraw", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyTier1Bonus", "type": "uint256"}, {"name": "_loyaltyTier2Bonus", "type": "uint256"}, {"name": "_loyaltyTier3Bonus", "type": "uint256"} ], "name": "setLoyaltyTiersBonus", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "getLoyaltyTiers", "outputs": [{"name": "tier1", "type": "uint256"}, {"name": "tier2", "type": "uint256"}, {"name": "tier3", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyBonusTotal", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardsDuration", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "reward", "type": "uint256"} ], "name": "notifyRewardAmount", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": false, "inputs": [], "name": "getReward", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedLoyaltyBonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "CDEXToken", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "nominatedOwner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_loyaltyTier1", "type": "uint256"}, {"name": "_loyaltyTier2", "type": "uint256"}, {"name": "_loyaltyTier3", "type": "uint256"} ], "name": "setLoyaltyTiers", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "paused", "outputs": [{"name": "", "type": "bool"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier1", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "account", "type": "address"} ], "name": "balanceOf", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier2", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "totalMembers", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "acceptOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [{"name": "a", "type": "uint256"}, {"name": "b", "type": "uint256"} ], "name": "min", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardRate", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastTimeRewardApplicable", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "userRewardPerTokenPaid", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "owner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastPauseTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier1Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "stake", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "getLoyaltyTiersBonus", "outputs": [{"name": "tier1Bonus", "type": "uint256"}, {"name": "tier2Bonus", "type": "uint256"}, {"name": "tier3Bonus", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "lastUpdateTime", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_rewardsDuration", "type": "uint256"} ], "name": "setRewardsDuration", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerToken", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier3", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "amount", "type": "uint256"} ], "name": "depositTokens", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "rewardPerTokenStored", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [], "name": "exit", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "periodFinish", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "depositedRewardTokens", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "loyaltyTier2Bonus", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"inputs": [{"name": "_owner", "type": "address"}, {"name": "_CDEXTokenContractAddress", "type": "address"}, {"name": "_rankingContractAddress", "type": "address"} ], "payable": false, "stateMutability": "nonpayable", "type": "constructor"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardAdded", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Staked", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Withdrawn", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "user", "type": "address"}, {"indexed": false, "name": "loyaltyBonus", "type": "uint256"} ], "name": "LoyaltyBonusPaid", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newDuration", "type": "uint256"} ], "name": "RewardsDurationUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "token", "type": "address"}, {"indexed": false, "name": "amount", "type": "uint256"} ], "name": "Recovered", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "sender", "type": "address"}, {"indexed": false, "name": "receiver", "type": "address"}, {"indexed": false, "name": "reward", "type": "uint256"} ], "name": "RewardsDeposited", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyTier1", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier2", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier3", "type": "uint256"} ], "name": "LoyaltyTiersUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "loyaltyTier1Bonus", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier2Bonus", "type": "uint256"}, {"indexed": false, "name": "loyaltyTier3Bonus", "type": "uint256"} ], "name": "LoyaltyTiersBonussUpdated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "isPaused", "type": "bool"} ], "name": "PauseChanged", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerNominated", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "oldOwner", "type": "address"}, {"indexed": false, "name": "newOwner", "type": "address"} ], "name": "OwnerChanged", "type": "event"} ]'
  )

  const tokenAbiJson = JSON.parse(
    '[{"constant": true, "inputs": [], "name": "name", "outputs": [{"name": "", "type": "string"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_spender", "type": "address"}, {"name": "_value", "type": "uint256"} ], "name": "approve", "outputs": [{"name": "success", "type": "bool"} ], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "totalSupply", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_from", "type": "address"}, {"name": "_to", "type": "address"}, {"name": "_value", "type": "uint256"} ], "name": "transferFrom", "outputs": [{"name": "success", "type": "bool"} ], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "decimals", "outputs": [{"name": "", "type": "uint8"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "balanceOf", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "symbol", "outputs": [{"name": "", "type": "string"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_to", "type": "address"}, {"name": "_value", "type": "uint256"} ], "name": "transfer", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "address"}, {"name": "", "type": "address"} ], "name": "allowance", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"inputs": [], "payable": false, "stateMutability": "nonpayable", "type": "constructor"}, {"payable": true, "stateMutability": "payable", "type": "fallback"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "_from", "type": "address"}, {"indexed": true, "name": "_to", "type": "address"}, {"indexed": false, "name": "_value", "type": "uint256"} ], "name": "Transfer", "type": "event"}, {"anonymous": false, "inputs": [{"indexed": true, "name": "_owner", "type": "address"}, {"indexed": true, "name": "_spender", "type": "address"}, {"indexed": false, "name": "_value", "type": "uint256"} ], "name": "Approval", "type": "event"} ]'
  )

  const rankingAbiJson = JSON.parse(
    '[{"constant": true, "inputs": [{"name": "", "type": "address"} ], "name": "addressPosition", "outputs": [{"name": "", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_key", "type": "uint256"}, {"name": "_value", "type": "address"} ], "name": "insert", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [{"name": "key", "type": "uint256"} ], "name": "prev", "outputs": [{"name": "_key", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "first", "outputs": [{"name": "_key", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "last", "outputs": [{"name": "_key", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "_key", "type": "uint256"} ], "name": "getNode", "outputs": [{"name": "key", "type": "uint256"}, {"name": "parent", "type": "uint256"}, {"name": "left", "type": "uint256"}, {"name": "right", "type": "uint256"}, {"name": "red", "type": "bool"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "key", "type": "uint256"} ], "name": "exists", "outputs": [{"name": "_exists", "type": "bool"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "_key", "type": "uint256"}, {"name": "_pos", "type": "uint256"} ], "name": "getValue", "outputs": [{"name": "value", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_contractAddress", "type": "address"} ], "name": "setCodexStakingContractAddress", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [], "name": "codexStakingContract", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "owner", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "_value", "type": "uint256"} ], "name": "getValuesLength", "outputs": [{"name": "length", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": false, "inputs": [{"name": "_key", "type": "uint256"}, {"name": "_value", "type": "address"} ], "name": "remove", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function"}, {"constant": true, "inputs": [{"name": "", "type": "uint256"}, {"name": "", "type": "uint256"} ], "name": "values", "outputs": [{"name": "", "type": "address"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "_positions", "type": "uint256"} ], "name": "ranking", "outputs": [{"name": "", "type": "address[]"}, {"name": "", "type": "uint256[]"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [], "name": "root", "outputs": [{"name": "_key", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"constant": true, "inputs": [{"name": "key", "type": "uint256"} ], "name": "next", "outputs": [{"name": "_key", "type": "uint256"} ], "payable": false, "stateMutability": "view", "type": "function"}, {"inputs": [], "payable": false, "stateMutability": "nonpayable", "type": "constructor"}, {"anonymous": false, "inputs": [{"indexed": false, "name": "where", "type": "string"}, {"indexed": false, "name": "key", "type": "uint256"}, {"indexed": false, "name": "value", "type": "address"} ], "name": "Log", "type": "event"} ]'
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
      await this.getRanking()
      this.refreshData()
    },
    
    data () {
      return {
        wallet: false,
        privateKey: '',
        walletTokenBalance: 0,
        userYearlyReturns: 0,
        userStakedBalance: 0,
        userApprovedBalance: 0,
        approveAmount: 0,
        stakeAmount: 0,
        unstakeAmount: 0,
        userEarnings: 0,
        loadingStats: true,
        loadingWalletData: false,
        loadingRanking: true,
        stakeSuccess: false,
        loginDialog: false,
        approveDialog: false,
        stakeDialog: false,
        unstakeDialog: false,
        withdrawDialog: false,
        showPassword: false,
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
        stakingTime: '1year',
        ranking: [],
        gasPrice: '40',
        gasLimit: '2500000',
        fee: '0.01',
        txSent: false,
        txViewUrl: '',
        loadingTx: false,
        content: '',
        passwordRequired: false,
        loyaltyTier1: 0,
        loyaltyTier2: 0,
        loyaltyTier2: 0,
        loyaltyTier1Bonus: 0,
        loyaltyTier2Bonus: 0,
        loyaltyTier3Bonus: 0,
        userLoyaltyTier: 0,
        userLoyaltyBonus: 1,
        calculationTier: 0
      }
    },

    components: {
      fileReader,
      password,
    },

    directives: {
      money: VMoney
    },

    methods: {
      async login (privateKey) {
        var self = this
        
        try {
          webWallet.restoreFromWif(privateKey)
          self.wallet = webWallet.getWallet()
          const userHexAddress = '0x' + base58.decode(self.wallet.info.address).toString('hex').substr(2, 40)
          // User total token balance
          var decodedResult = await utils.callContractFunction(
            tokenContractAddress,
            tokenAbiJson,
            'balanceOf',
            [userHexAddress]
          )
          self.walletTokenBalance = parseInt(decodedResult[0]) / 1e8

        } catch (e) {
          console.log('Error: ' + e.stack || e.toString() || e)
          alert('Error when restoring wallet. \nPlease check your private key / key file password.')
        }

        self.loginDialog = false
        
        await self.getWalletStats()
      },

      async getStats () {
        var self = this
        self.loadingStats = true
        try {
          var decodedResult = await utils.callContractFunction(
            stakingContractAddress,
            stakingAbiJson,
            'totalSupply',
            [],
          )
          self.amountStaked = decodedResult[0] / 1e8

          decodedResult = await utils.callContractFunction(
            stakingContractAddress,
            stakingAbiJson,
            'rewardRate',
            [],
          )
          // RewardRate: Number of tokens rewarded per second
          self.yearlyReward = decodedResult[0] / 1e8 * 31536000 // 1 Year in seconds
          
          decodedResult = await utils.callContractFunction(
            stakingContractAddress,
            stakingAbiJson,
            'getRewardForDuration',
            [],
          )
          
          self.totalRewardsAmount = decodedResult[0] / 1e8

          if (self.yearlyReward > 0 && self.amountStaked > 0) {
            self.yearlyYield = self.yearlyReward / self.amountStaked * 100
          }

          decodedResult = await utils.callContractFunction(
            stakingContractAddress,
            stakingAbiJson,
            'totalMembers',
            [],
          )
          self.totalMembers = decodedResult[0]

          // Loyalty tiers and bonuses. 
          decodedResult = await utils.callContractFunction(
            stakingContractAddress,
            stakingAbiJson,
            'getLoyaltyTiers',
            [],
          )
          self.loyaltyTier1 = parseInt(decodedResult[0])
          self.loyaltyTier2 = parseInt(decodedResult[1])
          self.loyaltyTier3 = parseInt(decodedResult[2])
          
          decodedResult = await utils.callContractFunction(
            stakingContractAddress,
            stakingAbiJson,
            'getLoyaltyTiersBonus',
            [],
          )
          self.loyaltyTier1Bonus = 1 + (decodedResult[0] / 10000)
          self.loyaltyTier2Bonus = 1 + (decodedResult[1] / 10000)
          self.loyaltyTier3Bonus = 1 + (decodedResult[2] / 10000)

          // Calculate Estimated Yearly Returns
          self.calculateEstimatedReturns(self.yearlyReward, self.amountStaked, self.stakingTime)

          self.loadingStats = false
        } catch (e) {
          console.log('Error reading stats: ' + e.stack || e.toString() || e)
          alert(e.message || e)
        }
      },

      async getWalletStats () {
        var self = this
        if (self.wallet) {
          try {
            self.loadingWalletData = true
            const userHexAddress = '0x' + base58.decode(self.wallet.info.address).toString('hex').substr(2, 40)
            // User total token balance
            var decodedResult = await utils.callContractFunction(
              tokenContractAddress,
              tokenAbiJson,
              'balanceOf',
              [userHexAddress]
            )
            self.walletTokenBalance = parseInt(decodedResult[0]) / 1e8

            // User total staked balance
            decodedResult = await utils.callContractFunction(
              stakingContractAddress,
              stakingAbiJson,
              'balanceOf',
              [userHexAddress]
            )
            self.userStakedBalance = parseInt(decodedResult[0])

            switch (true) {
              case (self.userStakedBalance >= parseInt(self.loyaltyTier1)):
                self.userLoyaltyTier = 1
                self.userLoyaltyBonus = self.loyaltyTier1Bonus
                break;
              case (self.userStakedBalance >= self.loyaltyTier2):
                self.userLoyaltyTier = 2
                self.userLoyaltyBonus = self.loyaltyTier2Bonus
                break;
              case (self.userStakedBalance >= self.loyaltyTier3):
                self.userLoyaltyTier = 3
                self.userLoyaltyBonus = self.loyaltyTier3Bonus
                break;
              default:
                self.userLoyaltyTier = 0
                self.userLoyaltyBonus = 1
                break;
            }

            self.userStakedBalance = decodedResult[0] / 1e8

            // Calculate yearly returns considering the loyalty program bonus
            self.userYearlyReturns = self.userStakedBalance * self.yearlyYield * self.userLoyaltyBonus / 100

            // User approved balance
            decodedResult = await utils.callContractFunction(
              tokenContractAddress,
              tokenAbiJson,
              'allowance',
              [userHexAddress, '0x' + stakingContractAddress]
            )
            self.userApprovedBalance = decodedResult[0] / 1e8
            self.stakeAmount = self.userApprovedBalance

            // User earned balance
            decodedResult = await utils.callContractFunction(
              stakingContractAddress,
              stakingAbiJson,
              'earned',
              [userHexAddress]
            )

            self.userEarnings = decodedResult[0] / 1e8 * self.userLoyaltyBonus

            self.loadingWalletData = false
          } catch (e) {
            console.log('Error: ' + e.stack || e.toString() || e)
            alert('Error when fetching wallet statistics.')
          }
        }
      },

      async calculateEstimatedReturns (yearlyReward, amountStaked, period) {

        var self = this

        var userBalanceToAdd = parseInt(self.calculationAmount.replace(/,/g, ''))

        if (userBalanceToAdd > 0) {
          var newYearlyYield = yearlyReward / (amountStaked + userBalanceToAdd)
          self.calculationTier = 0
          var yearlyReturns = userBalanceToAdd * newYearlyYield

          if (self.loyaltyTier1 > 0) {
            switch (true) {
              case (userBalanceToAdd >= self.loyaltyTier1 / 1e8):
                self.calculationTier = 1
                yearlyReturns = userBalanceToAdd * newYearlyYield * self.loyaltyTier1Bonus
                break
              case (userBalanceToAdd >= self.loyaltyTier2 / 1e8):
                self.calculationTier = 2
                yearlyReturns = userBalanceToAdd * newYearlyYield * self.loyaltyTier2Bonus
                break
              case (userBalanceToAdd >= self.loyaltyTier3 / 1e8):
                self.calculationTier = 3
                yearlyReturns = userBalanceToAdd * newYearlyYield * self.loyaltyTier3Bonus
                break
              default:
                self.calculationTier = 0
                yearlyReturns = userBalanceToAdd * newYearlyYield
                break
            }
          }
          
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
        }
      },

      clearEstimatedCalculations () {
        var self = this
        
        self.estimatedReturns = 0,
        self.totalBalanceAfterReturns = 0
        self.returnOverInvestment = 0
        self.stakingTime = false
        self.calculationTier = 0

      },

      async getRanking () {
        try {
          var self = this
          self.loadingRanking = true
          var rankingAddress
          var rankingBalance

          const positions = self.totalMembers >= 10 ? 10 : self.totalMembers

          var decodedResult = await utils.callContractFunction(
            rankingContractAddress,
            rankingAbiJson,
            'ranking',
            [positions]
          )

          for (var i = 0; i < positions; i++) {
            rankingAddress = base58check.encode(decodedResult[0][i].substring(2), prefix)
            rankingBalance = (decodedResult[1][i] / 1e8).toString()
            self.ranking[i] = {
              'address': rankingAddress.substring(0, 6) + '...' + rankingAddress.substring(rankingAddress.length-6, rankingAddress.length), 
              'balance': rankingBalance.toLocaleString("en-US", {style: "decimal", minimumFractionDigits: 2, maximumFractionDigits: 2})
            }
          }

          self.loadingRanking = false
        } catch(e) {
          console.log('Error reading ranking: ' + e.stack || e.toString() || e)
          alert(e.message || e)
        }
      },

      async approve () {
        var self = this

        var approveAmount = parseInt(self.approveAmount.replace(/,/g, '')) 

        if (approveAmount <= self.walletTokenBalance) {
          self.approveDialog = false
          self.txSent = true
          self.loadingTx = true

          approveAmount = approveAmount * 1e8

          const encodedData = utils.encodeContractSendFunction(
            tokenAbiJson, 
            'approve', 
            [
              '0x' + stakingContractAddress,
              approveAmount
            ]
          )

          try {
            const rawTx = await webWallet.getWallet().generateSendToContractTx(
              tokenContractAddress, 
              encodedData, 
              self.gasLimit, 
              self.gasPrice, 
              self.fee
            )

            const txId = await webWallet.getWallet().sendRawTx(rawTx)

            self.txViewUrl = server.currentNode().getTxExplorerUrl(txId)
            self.loadingTx = false

          } catch (e) {
            alert(e.message || e)
            return false
          }
        } else {
          alert('Error: The approve amount must be less or equal to your token balance.')
        }
      },

      async withdraw () {
        var self = this

        self.withdrawDialog = false
        self.txSent = true
        self.loadingTx = true

        const encodedData = utils.encodeContractSendFunction(
          stakingAbiJson, 
          'getReward', 
          []
        )

        try {
          const rawTx = await webWallet.getWallet().generateSendToContractTx(
            stakingContractAddress, 
            encodedData, 
            self.gasLimit, 
            self.gasPrice, 
            self.fee
          )
        
          const txId = await webWallet.getWallet().sendRawTx(rawTx)
          self.txViewUrl = server.currentNode().getTxExplorerUrl(txId)
          self.loadingTx = false

        } catch (e) {
          alert(e.message || e)
          return false
        }
      },

      stakeMax () {
        var self = this
        self.stakeAmount = self.userApprovedBalance > self.walletTokenBalance ? Math.trunc(self.walletTokenBalance) : Math.trunc(self.userApprovedBalance);
      },

      async unstake () {
        var self = this
        var unstakeAmount = parseInt(self.unstakeAmount.replace(/,/g, ''))

        if (unstakeAmount <= self.userStakedBalance) {

          unstakeAmount = unstakeAmount * 1e8

          self.unstakeDialog = false
          self.txSent = true
          self.loadingTx = true

          const encodedData = utils.encodeContractSendFunction(
            stakingAbiJson, 
            'withdraw', 
            [unstakeAmount]
          )

          try {
            const rawTx = await webWallet.getWallet().generateSendToContractTx(
              stakingContractAddress, 
              encodedData, 
              self.gasLimit, 
              self.gasPrice, 
              self.fee
            )
          
            const txId = await webWallet.getWallet().sendRawTx(rawTx)
            self.txViewUrl = server.currentNode().getTxExplorerUrl(txId)
            self.loadingTx = false

            let userFinalStakedAmount = self.userStakedBalance - parseInt(self.stakeAmount.replace(/,/g, ''))

          } catch (e) {
            alert(e.message || e)
            return false
          }
        } else {
          alert('The value to unstake needs to be equal or less than your staked balance.')
        }
      },

      async stake () {
        var self = this
        var stakeAmount = parseInt(self.stakeAmount.replace(/,/g, ''))

        if (stakeAmount <= self.walletTokenBalance && stakeAmount <= self.userApprovedBalance) {

          stakeAmount = stakeAmount * 1e8

          self.stakeDialog = false
          self.txSent = true
          self.loadingTx = true

          const encodedData = utils.encodeContractSendFunction(
            stakingAbiJson, 
            'stake', 
            [stakeAmount]
          )

          try {
            const rawTx = await webWallet.getWallet().generateSendToContractTx(
              stakingContractAddress, 
              encodedData, 
              self.gasLimit, 
              self.gasPrice, 
              self.fee
            )
          
            const txId = await webWallet.getWallet().sendRawTx(rawTx)
            self.txViewUrl = server.currentNode().getTxExplorerUrl(txId)
            self.loadingTx = false

          } catch (e) {
            alert(e.message || e)
            return false
          }
        } else {
          alert('The value to stake needs to be equal or less than your total balance available and total approved balance.')
        }
      },

      parseKeyFile (upload) {
        var self = this
        let content = keyfile.parse(upload.content)
        if (content) {
          self.passwordRequired = true
          self.content = content
        }
      },
      
      inputed (password) {
        var self = this
        self.passwordRequired = false
        try {
          self.login(keyfile.decode(self.content, password))
        }
        catch (e) {
          alert('Error when restoring from key file.')
          console.log(e.stack || e.toString() || e)
          return false
        }
      },

      refreshData () {
        var self = this

        setInterval(async () => {
          await self.getStats()
          if (self.wallet) {
            await self.getWalletStats()
          }
        }, 1000 * 60)

        setInterval(async () => {
          await self.getRanking()
        }, 5000 * 60)
      }
    }
  }
</script>
<style scoped src="../assets/css/reward.scss" lang="scss" />