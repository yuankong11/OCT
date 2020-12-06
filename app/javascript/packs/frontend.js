import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import router from '../frontend/router'

import Frontend from '../frontend/Frontend.vue'

Vue.use(ElementUI)
Vue.component(Frontend)

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        router,
        render: h => h(Frontend)
    }).$mount()
    document.body.appendChild(app.$el)

    console.log(app)
})
