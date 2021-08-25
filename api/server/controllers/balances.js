const Balances = require("../models").Balances
const bitcoinMessage = require('bitcoinjs-message')
const { Op } = require("sequelize")

module.exports = {
  updateCreate(req, res) {
    if (bitcoinMessage.verify(req.body.address, req.body.address, req.body.signature)) {
      return Balances.findOne({
        where: { 
          address: req.body.address,
          current: 1
        }
      })
      .then(function (row) {
        if (row !== null) {
          // Record exists. Updating current flag...
          return Balances.update({ current: 0 }, {
            where: {
              address: req.body.address
            }
          })
        }
      })
      .then(function () {
        return Balances.create({
          address: req.body.address,
          balance: req.body.balance,
          current: 1
        })
      })
      .then(() => res.status(200)
        .send({ message: "Address balance updated successfully!" })
      )
      .catch(error => res.status(400).send(error))
    } else {
      res.status(400).send({ message: "Error: Permission denied." })
    }
  },
  
  create(req, res) {
    return Balances.create({
      address: req.body.address,
      balance: req.body.balance
    })
      .then(balance => res.status(201)
        .send({
          success: true,
          message: "Successfully created a balance entity.",
          balance
        })
      )
      .catch(error => res.status(400).send(error))
  },

  update(req, res) {
    return Balances.update(req.body, {
      where: {
        address: req.params.address
      }
    })
    .then(() => res.status(200)
      .send({ message: "Address balance updated successfully!" })
    )
    .catch(error => res.status(400).send(error))
  },

  rank(req, res) {
    return Balances.findAll({
      where: {
        [Op.and]: [
          { current: 1 },
          { 
            balance: { 
              [Op.gt]: 0 
            } 
          }
        ]
      },
      order: [
        ['balance', 'DESC']
      ],
      limit: 10
    })
      .then(items => res.status(200)
      .send(items)
    )
      .catch(error => res.status(400).send(error))
  },
}