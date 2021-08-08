const balancesController = require("../controllers").balances;

module.exports = app => {
  app.use((req, res, next) => {
    res.set({
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': '*'
    })
    next()
  })
  app.post("/api/balances", balancesController.updateCreate)
  app.get("/api/balances/rank", balancesController.rank)
  app.put("/api/balances/:address", balancesController.update)
};