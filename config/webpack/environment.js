const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const VuetifyLoaderPlugin = require('vuetify-loader/lib/plugin')
const vue = require('./loaders/vue')
const style = require('./loaders/style')

const resolver = {
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  }
}

// const myCssLoaderOptions = {
//   module: true,
//   sourceMap: true,
//   localIdentName: '[name]__[local]___[hash:base64:5]'
// }

// const CSSLoader = environment.loaders.get('sass').use.find(el => el.loader === 'css-loader')
// CSSLoader.options = environment.config.merge(CSSLoader.options, myCssLoaderOptions)

environment.loaders.prepend('sass', style)
environment.loaders.prepend('vue', vue)
environment.plugins.prepend('VuetifyLoaderPlugin', new VuetifyLoaderPlugin())
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
// environment.config.merge(resolver)

module.exports = environment
