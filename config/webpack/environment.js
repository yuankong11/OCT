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

environment.loaders.prepend('sass', style)
environment.loaders.prepend('vue', vue)
nvironment.plugins.prepend('VuetifyLoaderPlugin', new VuetifyLoaderPlugin())
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
module.exports = environment
