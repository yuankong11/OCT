import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import VueResource from 'vue-resource'
import Vuetify from 'vuetify/lib'
import 'vuetify/dist/vuetify.min.css'
// import store from './store'
import router from '../frontend/Routes'
import App from '../frontend/App.vue'
Vue.use(Vuetify)
Vue.use(ElementUI)
Vue.use(VueResource)
Vue.component(App)

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        router,
        vuetify: new Vuetify(),
        render: h => h(App),
    }).$mount()
    document.body.appendChild(app.$el)

    console.log(app)
})
