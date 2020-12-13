const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const { VuetifyLoaderPlugin } = require('vuetify-loader')
const vue = require('./loaders/vue')
const style = require('./loaders/style')

const resolver = {
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  }
}

environment.loaders.prepend('sass', style)
environment.loaders.prepend('vue', vue)
environment.plugins.prepend('VuetifyLoaderPlugin', new VuetifyLoaderPlugin())
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
module.exports = environment
