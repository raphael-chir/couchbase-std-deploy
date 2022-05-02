var showdown = require("showdown");
const fs = require("fs");
showdown.setFlavor("github");
var converter = new showdown.Converter();

fs.readFile("README.md", "utf8", function (err, data) {
  var html = converter.makeHtml(data);
  fs.writeFile("index.html", html, function (err) {
    if (err) throw err;
    console.log("Done !");
  });
});
