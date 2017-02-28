module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'index.js'
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
