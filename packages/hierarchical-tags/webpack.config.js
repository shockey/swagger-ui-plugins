const path = require("path");

module.exports = {
  entry: "./src/index.jsx",
  output: {
    path: path.resolve(__dirname, "build"),
    filename: "swagger-ui-hierarchical-tags-plugin.[contenthash:8].js",
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: [
              "@babel/preset-env", 
              "@babel/preset-react",
            ]
          }
        }
      }
    ]
  },
  resolve: {
    extensions: [".js",".jsx"]
  }
}

