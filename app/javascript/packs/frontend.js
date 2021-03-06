import Vue from 'vue'
import ElementUI from 'element-ui'
import Vuetify from 'vuetify/lib'
import 'element-ui/lib/theme-chalk/index.css'
import VueResource from 'vue-resource'
import BootstrapVue from 'bootstrap-vue'
// import 'vuetify/dist/vuetify.min.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import '@mdi/font/css/materialdesignicons.css'

import store from '../frontend/store'
import router from '../frontend/Routes'
import App from '../frontend/App.vue'

Vue.use(Vuetify)
Vue.use(ElementUI)
Vue.use(VueResource)
Vue.use(BootstrapVue)
Vue.component(App)

router.beforeEach((to, from, next) => {
    if (to.path === '/login') {
        sessionStorage.removeItem('logged')
    }
    let user = sessionStorage.getItem('logged')
    if (!user && to.path !== '/login') {
        next({ path: '/login' })
    } else {
        next()
    }
})

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        router,
        store,
        vuetify: new Vuetify({
            icons: {
                iconfont: 'md',
            }
        }),
        render: h => h(App),
    }).$mount()
    document.body.appendChild(app.$el)
    router.push(window.postfix)

    console.log(app)
})
