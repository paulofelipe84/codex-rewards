const balancesController = require("../controllers").balances;

module.exports = app => {
  app.get("/api", (req, res) =>
    res.status(200).send({
      message: "Welcome to the API!"
    })
  );

  app.post("/api/balances", balancesController.create);
  app.get("/api/balances/rank", balancesController.rank);
};