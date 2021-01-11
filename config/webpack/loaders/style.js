module.exports = {
  test: /\.s(c|a)ss$/,
  use: [
    'vue-style-loader',
    'css-loader',
    {
      loader: 'sass-loader',
      // Requires sass-loader@^7.0.0
      options: {
        implementation: require('sass'),
        // indentedSyntax: true // optional
      },
      // Requires sass-loader@^8.0.0
    },
    // {
    //   loader: "postcss-loader",
    //   options: {
    //     sourceMap: true
    //   }
    // },
    // {
    //   loader: "sass-loader", options: {
    //     sourceMap: true
    //   }
    // }
  ],
}
