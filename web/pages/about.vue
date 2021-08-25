<template>
  <div>
    <div>
      <body>
        <div class="heroSection">
          <img src="../assets/icon-purple.png" alt="" class="position-absolute d-md-block d-none bg-icon" height="500px">
          <div class="container">
            <nav class="navbar navbar-expand-lg navbar-light">
              <div class="container-fluid">
                <a class="navbar-brand" href="#"><img src="../assets/CODEX-LOGO-BLACK.png" alt="" class="logo" srcset=""></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <img src="../assets/ham-icon.svg" alt="">
                    <!-- <span class="navbar-toggler-icon"></span> -->
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                  <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                      <a class="nav-link" href="/">Home</a>
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

            <div class="row">
              <div class="col-md-6 align-self-center order-md-0 order-1 text-md-start text-center">
                <h1 class="fw-bold ">About the CDEX Token</h1>
                <p class="me-md-5 pe-md-5">
                  CDEX is a token made by the Codex and HTML Coin community to give exclusive benefits to certain software services, as well as fascilitate faster and easier transactions.
                  <br><br>
                  It is a valid utility token on several platforms created by Codex on Althash.
                </p>
                <div class="me-md-5">
                  <v-btn large href="https://coinmarketcap.com/currencies/codex/" target="_blank" class="btn cbtn btn-dark ms-md-5 ms-0 w-max my-2">Learn more about CODEX</v-btn>
                </div>
              </div>
              <div class="col-md-6 align-self-center order-md-1 order-0">
                <img src="../assets/about-img.png" class="img-fluid" alt="" srcset="">
              </div>
            </div>

            <hr>
            <div class="text-center py-3">
              <h4 class="fw-bolder mx-5 mx-md-0">What makes CDEX a unique token</h4>

              <div class="row my-md-4 px-md-5 mb-md-5">
                <div class="col-md-4 px-4 py-2 px-md-0 py-md-0">
                  <div class="ccard mx-md-4 text-center p-3">
                    <v-spacer />
                    <div style="text-align: center;">
                      <img src="../assets/smart1.png" alt="" class="my-2" width="100px">
                      <h6 class="fw-bold grey--text">Lightning fast transfers</h6>
                    </div>
                    <v-spacer />
                  </div>
                </div>
                <div class="col-md-4 px-4 py-2 px-md-0 py-md-0">
                  <div class="ccard mx-md-4 text-center p-3 ">
                    <v-spacer />
                    <div>
                      <img src="../assets/smart2.png" alt="" class="my-2" width="100px">
                      <h6 class="fw-bold grey--text">Nearly Fee-less transactions</h6>
                    </div>
                    <v-spacer />
                  </div>
                </div>
                <div class="col-md-4 px-4 py-2 px-md-0 py-md-0">
                  <div class="ccard mx-md-4 text-center p-3 ">
                    <v-spacer />
                    <div>
                      <img src="../assets/smart3.png" alt="" class="my-2" width="100px">
                      <h6 class="fw-bold grey--text">Based on HTMLCoin</h6>
                    </div>
                    <v-spacer />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="calSection my-md-5">
            <div class="container">
                <div class="row">
                    
                    <div class="col-md-7 px-md-4 my-4 align-self-center order-md-0 order-1">
                        <h2 class="fw-bold h1">Stake your CDEX tokens and accrue more CDEX by second!</h2>
                        <p class="py-2 lh-1_8 py-md-4">
                          By staking CDEX, users are able to build up more tokens by the second. According to the amount of CDEX tokens a user is staking, they may qualify for certain tiers on the loyalty program. These different tiers, 'Codex Pawn', 'Codex Knight', and 'Codex King', offer users a CDEX staking % booster and random HRC20 reward eligibility. Please be informed that every interaction with the Smart Contract requires gas from the user in the form of HTML Coin. Users are able to unstake whenever they desire.
                        </p>
                        <v-btn class="btn cbtn bg-prime" href="https://stex.com/?ref=33646848" target="_blank">Buy your CDEX Tokens</v-btn>
                    </div>
                    <div class="col-md-5 text-center align-self-center order-md-1 order-0">
                        <img src="../assets/about-stake.png" class="img-fluid p-md-4" alt="" srcset="" width="100%">
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
  </div>
</template>

<script>
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
    }
  }
</script>
<style scoped src="../assets/css/about.scss" lang="scss" />
  