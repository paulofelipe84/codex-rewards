const Balances = require("../models").Balances;

module.exports = {
  create(req, res) {
    return Balances.create({
      address: req.body.address,
      balance: req.body.balance
    })
      .then(balance =>
        res
          .status(201)
          .send({
            success: true,
            message: "Successfully created a balance entity.",
            balance
          })
      )
      .catch(error => res.status(400).send(error));
  },

  rank(req, res) {
    return Balances.findAll({
      order: [
        ['balance', 'DESC']
      ],
      limit: 10
    })
      .then(items => res.status(200).send(items))
      .catch(error => res.status(400).send(error));
  },
};