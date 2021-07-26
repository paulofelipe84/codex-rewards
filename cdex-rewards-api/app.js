const http = require("http");
const express = require("express");
const logger = require("morgan");

const port = parseInt(process.env.PORT, 10) || 8000;

// Set up the express app
const app = express();
const server = http.createServer(app);

// Log requests to the console.
app.use(logger("dev"));

// Parse incoming requests data
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Require our routes into the application.
require("./server/routes")(app);
app.get("*", (req, res) =>
  res.status(200).send({
    message: "Welcome!"
  })
);

app.set("port", port);

server.listen(port);