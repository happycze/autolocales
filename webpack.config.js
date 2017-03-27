const WebpackTouch = require('webpack-touch');

var entryDir=__dirname + "/app/assets/javascripts/";
var prodMode=process.argv[2]=="--optimize-minimize";
var sourceMaps=prodMode?"":"inline-source-map";

console.log("Running in "+(prodMode?"production":"development")+" mode...");

module.exports = {
  entry: {
    application: entryDir+"application.js"
  },
  output: {
    path: entryDir+"/bundles/",
    filename: "[name].js",
    libraryTarget: "var",
    library: ["Autolocales","[name]"] 
  },
  module: {
    loaders:[
      { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader'},
      { test: /\.css$/, loader: "style!css" }
    ]
  },
  externals: {
    "react": "React",
    "react-dom": "ReactDOM"
  },
  devtool: sourceMaps,
  plugins: [
      new WebpackTouch({filename: './tmp/restart.txt', delay: 2000})
    ]
}