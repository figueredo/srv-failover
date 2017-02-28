module.exports = {
  entry: './src/index.js',
  devtool: '#source-map',
  output: {
    filename: 'index-webpack.js'
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: [ 'coffee-loader' ]
      }
    ]
  }
}
