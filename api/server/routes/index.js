const balancesController = require("../controllers").balances;

module.exports = app => {
  app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    next();
  });
  app.post("/api/balances", balancesController.create);
  app.get("/api/balances/rank", balancesController.rank);
  app.put("/api/balances/:address", balancesController.update);
};