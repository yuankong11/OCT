import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import router from '../../frontend/router'

import Dashboard from '../../frontend/components/Dashboard.vue'

Vue.use(ElementUI)
Vue.component(Dashboard)

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        router,
        render: h => h(Dashboard)
    }).$mount()
    document.body.appendChild(app.$el)

    console.log(app)
})
