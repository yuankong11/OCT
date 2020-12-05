import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import router from '../../frontend/router'

import LectureInfo from '../../frontend/components/LectureInfo/LectureInfo.vue'

Vue.use(ElementUI)
Vue.component(LectureInfo)

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        router,
        render: h => h(LectureInfo)
    }).$mount()
    document.body.appendChild(app.$el)

    console.log(app)
})
