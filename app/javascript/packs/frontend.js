import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import VueResource from 'vue-resource'

// import store from './store'
import router from '../frontend/Routes'
import App from '../frontend/App.vue'

Vue.use(ElementUI)
Vue.use(VueResource)
Vue.component(App)

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        router,
        render: h => h(App),
    }).$mount()
    document.body.appendChild(app.$el)

    console.log(app)
})
