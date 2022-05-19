const express = require("express");
const app = express();
const path = require("path");
const router = express.Router();
const { spawn } = require("child_process");
var showdown = require("showdown");
const fs = require("fs");
showdown.setFlavor("github");
var converter = new showdown.Converter();

router.get("/", function (req, res) {
  fs.readFile("README.md", "utf8", function (err, data) {
    var html = converter.makeHtml(data);
    fs.writeFile("index.html", html, function (err) {
      if (err) throw err;
      console.log("Done !");
    });
  });
  res.sendFile(path.join(__dirname + "/index.html"));
  //__dirname : It will resolve to your project folder.
  const ls = spawn("sh", ["/sandbox/utils/init-sandbox.sh"]);

  ls.stdout.on("data", (data) => {
    console.log(`stdout: ${data}`);
  });

  ls.stderr.on("data", (data) => {
    console.log(`stderr: ${data}`);
  });

  ls.on("error", (error) => {
    console.log(`error: ${error.message}`);
  });

  ls.on("close", (code) => {
    console.log(`child process exited with code ${code}`);
  });
});

app.use("/", router);
app.listen(process.env.port || 8080);

console.log("Running at Port 8080");
