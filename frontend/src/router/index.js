import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '@/components/Dashboard'
import Homework from '@/components/Homework'
import Resource from '@/components/Resource'
import LiveLesson from '@/components/LiveLesson/LiveLesson.vue'
import LectureInfo from '@/components/LectureInfo/LectureInfo.vue'
import Calendar from '@/components/Calendar'
import Todo from '@/components/Todo'


Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Dashboard',
      component: Dashboard
    },
    {
      path: '/homework',
      name: 'Homework',
      component: Homework
    },
    {
      path: '/resource',
      name: 'Resource',
      component: Resource
    },
    {
      path: '/liveLesson',
      name: 'LiveLesson',
      component: LiveLesson
    },
    {
      path: '/lectureInfo',
      name: 'LectureInfo',
      component: LectureInfo
    },
    {
      path: '/calendar',
      name: 'Calendar',
      component: Calendar
    },
    {
      path: '/todo',
      name: 'Todo',
      component: Todo
    }
  ]
})
